from netCDF4 import Dataset
import numpy as np
import glob
import os
import sys

print "Rebuilding ts files..."

# to be run from command line with arguments: some defaults
# are provided to run from virtual environment
if (len(sys.argv)>1) :
        DIRIN=sys.argv[1]
        expname=sys.argv[2]
else :
        expname="dycoms2_rf01_sex00"
        DIRIN="/Users/paolo/Desktop/uclales_post/"+expname+"/run"

maxvars=["cfl","maxdiv","wmax","rlmax","bflxmx","bflxrmx","precip_m"]
minvars=["bflxmn","bflxrmn"]

savefile_ts= DIRIN + "/" + expname + ".py.ts.nc"
ncfile_ts = Dataset(savefile_ts,'w', format='NETCDF4')
time = ncfile_ts.createDimension('time', None)
times = ncfile_ts.createVariable('time', 'f4', ('time',)) 
times.units = 'seconds since 2000-01-01 00:00:00"'

nx=len(glob.glob1(DIRIN,"*.ts.0000????.nc"))
ny=len(glob.glob1(DIRIN,"*.ts.????0000.nc"))

filename_ts= DIRIN+ "/" + expname + ".ts.00000000.nc"
a=Dataset(filename_ts)
T=a.variables['time'][:]
varlist=a.variables.keys()
a.close()

#for var in varlist[7:len(varlist)]:
for var in varlist[1:len(varlist)] :
	
	field=[]
	for i in range(nx) : 
		for j in range(ny) :
			filename_ts=DIRIN+"/"+expname+".ts."+ "%04d" % j +"%04d" % i +".nc"
                	a=Dataset(filename_ts,'r')
			if (i==0 and j==0) :
				units=a.variables[var].units
				longname=a.variables[var].longname
			field.append(a.variables[var][:])
	field=np.array(field)
	if var in maxvars :
		final=field.max(axis=0)
	elif var in minvars : 
		final=field.min(axis=0)
	else :
		final=np.mean(field,axis=0)
	ncvar=ncfile_ts.createVariable(var,'f4',('time'),fill_value=-999,zlib=True,complevel=1)
	ncvar[:]=final
	times[:]=T

#copy generic attributes of NetCDF
for name in a.ncattrs() :
        ncfile_ts.setncattr(name, a.getncattr(name))
ncfile_ts.setncattr("Postprocess","Postprocessed with PULP v0.2")

#close
ncfile_ts.close()
print "Done!"
