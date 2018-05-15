# PULP v0.1
## Postprocessing for Ucla-Les with Python

Nov 2017

by P. Davini (ISAC-CNR, p.davini@isac.cnr.it)

*PULP* is thought as a basic tool for handling UCLA-LES runs.

It combines a series of tools:
1. compiler, to speed up compilation procedure
2. namelists, used for simulations
3. jobscripts, which includes automatic resubmission, autopostrocessing and flag setup
4. initfiles, i.e. initial conditions or special zaxis
5. postproc, i.e. the original PULP tool. It recombines the output from different processors into single files in NETCDF4 Zip format. It is based on Python and it is an update of the original NCL routines, being at least ~2x faster.

Be aware, I used it as a playground to learn Python so that it is for sure not the most efficient 
or correct code ever. 
You will need  to install some of the most common Python packages, as numpy and netCDF4.

CDO is used for joining 3d variables.

Empty

