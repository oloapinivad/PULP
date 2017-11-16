# Python-based file reconstruction
# P. Davini - Nov 17
# v0.1 (just playing with python)

from netCDF4 import Dataset
import numpy as np
import glob
import os
import sys

print "Rebuilding 3d files for " + str(sys.argv[3]) + "..."

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

# numbero of files to collect
nx=len(glob.glob1(DIRIN,expname + ".0000????.nc"))
ny=len(glob.glob1(DIRIN,expname + ".????0000.nc"))

# output file definition and creation
savefile_3D= DIRIN + "/" + expname + "_" + var + "_py.3d.nc"
if os.path.exists(savefile_3D):
        os.remove(savefile_3D)
ncfile_3D = Dataset(savefile_3D,'w', format='NETCDF4')

# define zt,zt,time and y dimension
y=[]
for i in range(nx) :
        filename=DIRIN+"/"+expname+"."+ "0000" +"%04d" % i +".nc"
        a=Dataset(filename)
	y.append(a.variables['yt'][:])
        if i==0 :
		for dim in ['zt','zm','time'] :
			if (dim=='time') :
				vv=a.variables[dim][:]
			else :
				vv=a.variables[dim][1:]
			ncfile_3D.createDimension(dim, len(vv))
			ncvar=ncfile_3D.createVariable(dim,'f4',dim,fill_value=-999,zlib=False)
			ncvar[:]=vv
			ncvar.units=a.variables[dim].units
			ncvar.longname=a.variables[dim].longname
                z=a.variables['zt'][1:]	
		t=a.variables['time'][:]
                sx=range(len(a.variables['xt'][:]))
                sy=range(len(a.variables['yt'][:]))
		ncfile_3D.createDimension('yt', len(a.variables['yt'][:])*nx)
        a.close()
ncvar=ncfile_3D.createVariable('yt','f4','yt',fill_value=-999,zlib=False)
y=np.hstack(y)
ncvar[:]=y

# define x dimension
x=[]
for j in range(ny) :
	filename=DIRIN+"/"+expname+"." +"%04d" % j +"0000.nc"
        a=Dataset(filename)
        x.append(a.variables['xt'][:])
	if (j==0) :
		ncfile_3D.createDimension('xt', len(a.variables['xt'][:])*ny)
	a.close()
ncvar=ncfile_3D.createVariable('xt','f4','xt',fill_value=-999,zlib=False)
x=np.hstack(x)
ncvar[:]=x

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
ncfile_3D.close()
