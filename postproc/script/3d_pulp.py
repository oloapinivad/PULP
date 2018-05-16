# Python-based file reconstruction
# P. Davini - Nov 17
# v0.1 (just playing with python)

from netCDF4 import Dataset
import numpy as np
import glob
import os
import sys

# to be run from command line with arguments: some defaults
# are provided to run from virtual environment
if (len(sys.argv)>1) : 
	DIRIN=sys.argv[1]
	expname=sys.argv[2]
	var=str(sys.argv[3])
else :	
	expname="dycoms2_rf01_test00"
	DIRIN="/rigel/glab/users/pd2507/uclales2/"+expname+"/run"
	var='u'

# since previous code in NCL change the name of some variable for
# retrocompatibility we kept the same renaming, playing with 'var_in' and 'var_out'
# you can override it setting both var_out=var_in=var 
def rename_var(x):
    return {
        'tl': 't', 'pr': 'p', 'tr': 'tracer', 'tr2': 's01','sc': 's00', 'rf': 'rflx',
	'tr':'cvrx'
    }.get(x, x)

var_out=var
var_in=rename_var(var)

#loading one single file
filename=DIRIN+"/"+expname+"."+ "00000000.nc"
a=Dataset(filename)

# check if variables is there, if not exit
varlist=a.variables.keys()
if any(t==var_in for t in varlist):
        print "Variable found!"
	print "Rebuilding 3d files for " + var + "..."
else :
        print "Variable missing!! Exiting... "
        sys.exit()


# number of files to collect
nx=len(glob.glob1(DIRIN,expname + ".0000????.nc"))
ny=len(glob.glob1(DIRIN,expname + ".????0000.nc"))

# output file definition and creation
savefile_3D= DIRIN + "/" + expname + "_" + var_out + "_py.3d.nc"
if os.path.exists(savefile_3D):
        os.remove(savefile_3D)
ncfile_3D = Dataset(savefile_3D,'w', format='NETCDF4')

# define zt,zm,time yt and xt dimension
# python need to create dimensions and variables 
# xt and yt are deduced from grid spacing and number of files, only one file is opened
#use list and dictionary to loop on it
dim_list=['xt','yt','zt','zm','time']
dim_dict={x: [] for x in dim_list}

# loop on dimensions
for dim in dim_list :
	if (dim=='time') :
		vv=a.variables[dim][:]
	elif (dim=='xt') :
		x=a.variables[dim][:]
		if (hasattr(x,"mask")==True) :
			x.mask=False
		vv=range(int(x[0]),int(x[0])+int(np.diff(x)[0])*len(x)*ny,int(np.diff(x)[0]))
	elif (dim=='yt') :
		y=a.variables[dim][:]
		if (hasattr(y,"mask")==True) :
                        y.mask=False
		vv=range(int(y[0]),int(y[0])+int(np.diff(y)[0])*len(y)*nx,int(np.diff(y)[0]))
	else :
		vv=a.variables[dim][1:]
	dim_dict[dim]=vv
	ncfile_3D.createDimension(dim, len(vv))
	ncvar=ncfile_3D.createVariable(dim,'f4',dim,fill_value=-999,zlib=False)
	ncvar[:]=vv
	ncvar.units=a.variables[dim].units
	ncvar.longname=a.variables[dim].longname
a.close()

#keep in mind dimension of a single file
sx=range(len(dim_dict['xt'])/ny)
sy=range(len(dim_dict['yt'])/nx)

# loop on files, predeclare the array
field=np.zeros((len(dim_dict['time']),len(dim_dict['xt']),len(dim_dict['yt']),len(dim_dict['zt'])+1))
for i in range(nx) :
	for j in range(ny) :
		filename_3D=DIRIN+"/"+expname+"."+ "%04d" % j +"%04d" % i +".nc"
               	a=Dataset(filename_3D,'r')

		#extract attributes
		if (i==0 and j==0) :
			units=a.variables[var_in].units
			longname=a.variables[var_in].longname
			firstdim=a.variables[var_in].dimensions[3]
	
			#copy generic attributes of NetCDF
			for name in a.ncattrs() :
				ncfile_3D.setncattr(name, a.getncattr(name))
	
		#select and place subdomain
		xselect=[xx+(len(sx)*j) for xx in sx]
		yselect=[[len(sy)*i+sy[yy]] for yy in range(len(sy))]
		field[:,yselect,xselect,:]=a.variables[var_in][:]

# transpose to python-valid dimensions (time,zt,yt,xt)
final=np.transpose(field,(0,3,1,2))

# create file
ncvar=ncfile_3D.createVariable(var_out,'f4',('time','zt','yt','xt'),fill_value=-999,zlib=False)

# special u/v case (Arakawa-C grid)
# please note that some issue is still there when compare to original ncl script
if (var_out=='u') :
	print "special u case"
	final2=final[:,1:,:,:]
	final2[:,:,:,1:]=0.5*(final[:,1:,:,:-1] + final[:,1:,:,1:])
        final2[:,:,:,0]=0.5*(final[:,1:,:,0] + final[:,1:,:,-1])
	ncvar[:]=final2	
		
elif (var_out=='v') : 
	print "special v case"
	final2=final[:,1:,:,:]
	final2[:,:,1:,:]=0.5*(final[:,1:,:-1,:] + final[:,1:,1:,])
	final2[:,:,:1,:]=0.5*(final[:,1:,:1,:] + final[:,1:,-1:,:])
	ncvar[:]=final2

# for standard variables on thermo points (distinguis between zt and zm)
else :
	if (firstdim=='zt') :
		ncvar[:]=final[:,1:,:,:]
	if (firstdim=='zm') :
		ncvar[:]=0.5*(final[:,1:,:,:]+final[:,:-1,:,:])

# assign attributes
ncvar.units=units
ncvar.longname=longname
print "Done!!!"
#print final.shape

# close files	
ncfile_3D.setncattr("Postprocess","Postprocessed with PULP v0.2")
ncfile_3D.close()
