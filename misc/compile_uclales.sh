#!/bin/bash

#rename your executable
renamer=thetav
mode=Release

#set general folders
CODEDIR=$HOME/uclales2
compiler=ifort
arch=habanero

# modules (if you need them)
#module load intel-parallel-studio/2017 netcdf-fortran/4.4.4 netcdf/gcc/64/4.4.0
#module load mpich/ge/gcc/64/3.2rc2  gcc/4.8.5 netcdf-fortran/4.4.4
#module load netcdf-fortran/4.4.4 openmpi/mlnx/gcc/64/1.10.3rc4


CONFIGDIR=$CODEDIR/config

#set folders
if [[ $compiler == "ifort" ]] ; then
        export I_MPI_F90=ifort
        export FC="ifort"
        export OMPI_MPIF90=ifort
fi

if [[ $compiler == "gfortran" ]] ; then
        export I_MPI_F90=gfortran
        export FC="gfortran"
fi

cp $CONFIGDIR/${arch}.${compiler}.cmake  $CONFIGDIR/default.cmake

if [[ $mode == "Default" ]] ; then
	mkdir -p $CODEDIR/build 
	cd $CODEDIR/build
else 
	mkdir -p $CODEDIR/${mode}
        cd $CODEDIR/${mode}
fi

#make it
cmake -DCMAKE_BUILD_TYPE=${mode} -D MPI=TRUE $CODEDIR
make -j 4
mv uclales uclales2_${renamer}
if [[ $mode != "Default" ]] ; then
	rm -f ../build/${mode}_uclales2_${renamer}
	ln -s ../${mode}/uclales2_${renamer} ../build/${mode}_uclales2_${renamer}
fi
cd -
