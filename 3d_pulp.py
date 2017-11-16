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
	expname="dycoms2_rf01_sex00"
	DIRIN="/Users/paolo/Desktop/uclales_post/"+expname+"/run"
	var='u'

print "Rebuilding 3d files for " + var + "..."

# number of files to collect
nx=len(glob.glob1(DIRIN,expname + ".0000????.nc"))
ny=len(glob.glob1(DIRIN,expname + ".????0000.nc"))

# output file definition and creation
savefile_3D= DIRIN + "/" + expname + "_" + var + "_py.3d.nc"
if os.path.exists(savefile_3D):
        os.remove(savefile_3D)
ncfile_3D = Dataset(savefile_3D,'w', format='NETCDF4')

# define zt,zm,time yt and xt dimension
# python need to create dimensions and variables 
# xt and yt are deduced from grid spacing and number of files, only one file is opened
filename=DIRIN+"/"+expname+"."+ "00000000.nc"
a=Dataset(filename)
y=a.variables['yt'][:]; #y.mask=False
x=a.variables['xt'][:]; #x.mask=False
# loop on dimensions
for dim in ['xt','yt','zt','zm','time'] :
	if (dim=='time') :
		vv=a.variables[dim][:]
		t=vv
	elif (dim=='xt') :
		vv=range(int(x[0]),int(x[0])+int(np.diff(x)[0])*len(x)*ny,int(np.diff(x)[0]))
		x=vv
	elif (dim=='yt') :
		vv=range(int(y[0]),int(y[0])+int(np.diff(y)[0])*len(y)*nx,int(np.diff(y)[0]))
		y=vv
	else :
		vv=a.variables[dim][1:]
		z=vv
	ncfile_3D.createDimension(dim, len(vv))
	ncvar=ncfile_3D.createVariable(dim,'f4',dim,fill_value=-999,zlib=False)
	ncvar[:]=vv
	ncvar.units=a.variables[dim].units
	ncvar.longname=a.variables[dim].longname
a.close()

#keep in mind dimension of a single file
sx=range(len(x)/ny); sy=range(len(y)/nx)

# loop on variable
field=np.zeros((len(t),len(x),len(y),len(z)+1))
for i in range(nx) :
	for j in range(ny) :
		filename_3D=DIRIN+"/"+expname+"."+ "%04d" % j +"%04d" % i +".nc"
               	a=Dataset(filename_3D,'r')

		#extract attributes
		if (i==0 and j==0) :
			units=a.variables[var].units
			longname=a.variables[var].longname
			firstdim=a.variables[var].dimensions[3]
	
			#copy generic attributes of NetCDF
			for name in a.ncattrs() :
				ncfile_3D.setncattr(name, a.getncattr(name))
	
		#select and place subdomain
		xselect=[xx+(len(sx)*j) for xx in sx]
		yselect=[[len(sy)*i+sy[yy]] for yy in range(len(sy))]
		field[:,yselect,xselect,:]=a.variables[var][:]

# transpose to python-valid dimensions (time,zt,yt,xt)
final=np.transpose(field,(0,3,1,2))

# create file
ncvar=ncfile_3D.createVariable(var,'f4',('time','zt','yt','xt'),fill_value=-999,zlib=False)

# special u/v case (Arakawa-C grid)
# please note that some issue is still there when compare to original ncl script
if (var=='u') :
	print "special u case"
	final2=final[:,1:,:,:]
	final2[:,:,:,1:]=0.5*(final[:,1:,:,:-1] + final[:,1:,:,1:])
        final2[:,:,:,0]=0.5*(final[:,1:,:,0] + final[:,1:,:,-1])
	ncvar[:]=final2	
		
elif (var=='v') : 
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
ncfile_3D.setncattr("Postprocess","Postprocessed with PULP v0.1")
ncfile_3D.close()
