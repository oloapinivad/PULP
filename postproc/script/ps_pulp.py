from netCDF4 import Dataset
import numpy as np
import glob
import os
import sys

print "Rebuilding ps files..."

# to be run from command line with arguments: some defaults
# are provided to run from virtual environment
if (len(sys.argv)>1) :
        DIRIN=sys.argv[1]
        expname=sys.argv[2]
else :
        expname="dycoms2_rf01_sex00"
        DIRIN="/Users/paolo/Desktop/uclales_post/"+expname+"/run"


#variables that need to be summed instead of averaged
sumvars=["wr_cs1","wr_cs2","wv_cs1","wv_cs2","wt_cs1","wt_cs2","rt_cs1","rt_cs2","rl_cs1","rl_cs2","tv_cs1","tv_cs2","tl_cs1","tl_cs2","w_cs1", "w_cs2","cnt_cs1","cnt_cs2"]

#file dimension
nx=len(glob.glob1(DIRIN,"*.ps.0000????.nc"))
ny=len(glob.glob1(DIRIN,"*.ps.????0000.nc"))

#loading z and time
filename_ps= DIRIN+ "/" + expname + ".ps.00000000.nc"
a=Dataset(filename_ps)
varlist=a.variables.keys()
savefile_ps= DIRIN + "/" + expname + ".py.ps.nc"
if os.path.exists(savefile_ps):
	os.remove(savefile_ps)
ncfile_ps = Dataset(savefile_ps,'w', format='NETCDF4')
ncfile_ps.createDimension('zm', len(a.variables['zm'][:]))
ncfile_ps.createDimension('zt', len(a.variables['zt'][:]))
ncfile_ps.createDimension('time',len(a.variables['time'][:]))
a.close()

ncfile_ps.createDimension('x', 1)
ncfile_ps.createDimension('y', 1)

for var in varlist[0:len(varlist)] :
	
	field=[]
	for i in range(nx) : 
		for j in range(ny) :
			filename_ps=DIRIN+"/"+expname+".ps."+ "%04d" % j +"%04d" % i +".nc"
                	a=Dataset(filename_ps,'r')
			if (i==0 and j==0) :
				units=a.variables[var].units
				longname=a.variables[var].longname
				ndims=len(a.variables[var].dimensions)
				firstdim=a.variables[var].dimensions[ndims-1]
			field.append(a.variables[var][:])
	field=np.array(field)

	if var in sumvars : 
		final=np.sum(field,axis=0)
	else :	
		final=np.mean(field,axis=0)

	if (ndims==1) :
		ncvar=ncfile_ps.createVariable(var,'f4',(firstdim),fill_value=-999,zlib=True,complevel=1)
	if (ndims==2) :
		ncvar=ncfile_ps.createVariable(var,'f4',('time',firstdim,'x','y'),fill_value=-999,zlib=True,complevel=1)
	
	ncvar[:]=final
	ncvar.units=units
	ncvar.longname=longname

#copy generic attributes of NetCDF
for name in a.ncattrs() :
	ncfile_ps.setncattr(name, a.getncattr(name))
ncfile_ps.setncattr("Postprocess","Postprocessed with PULP v0.1")	

#close
ncfile_ps.close()
print "Done!"
