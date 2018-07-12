#!/bin/bash

#rename your executable
renamer=evcool_nolh

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
#rm -rf $CODEDIR/build
mkdir -p $CODEDIR/build 
cd $CODEDIR/build

#compile
cmake -D MPI=TRUE $CODEDIR
make -j 4
mv uclales uclales2_${renamer}
cd -
