#!/bin/bash

# PULP v0.1
# Postprocessing Ucla Les with Python
# P. Davini - Nov 17
# master script
# based on python and cdo (just to merge and compress 3d data)

expname="dycoms2_rf01_sev02"
DIRIN=/rigel/glab/users/pd2507/uclales/$expname/run
POSTDIR=/rigel/glab/users/pd2507/uclales/$expname/post
PULPDIR=$(pwd)

python=python
cdozip="cdo -f nc4 -z zip"

#varlist="p t u v l q w"
#varlist="u"
varlist="l q w sc tr2 dwdt dwdtbuo dwdtdif hevc wtdif wtpre pr tl u v rf tr dwdtadv wtbuo wt wtadv"


# reconstuct ps and ts files, already NetCDF4 zip
python $PULPDIR/ts_pulp.py $DIRIN $expname
python $PULPDIR/ps_pulp.py $DIRIN $expname
mv $DIRIN/${expname}*py*nc $POSTDIR

#loop on 3d variables: this is divided in order to exploit of parallel cores if available
for var in $varlist ; do
	echo $var
	python $PULPDIR/3d_pulp.py $DIRIN $expname $var
done

#merge into a unique file using cdo and compress in NetCDF4 zip
rm -f $POSTDIR/${expname}.py.3d.nc
$cdozip merge  $DIRIN/${expname}_*_py.3d.nc $POSTDIR/${expname}.py.3d.nc
rm $DIRIN/${expname}_*_py.3d.nc
	
