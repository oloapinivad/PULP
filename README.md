# PULP v0.1
## Postprocessing for Ucla-Les with Python

Nov 2017

by P. Davini (ISAC-CNR, p.davini@isac.cnr.it)

*PULP* is thought as a basic tool for postprocessing output from UCLA-LES runs.
It recombines the output from different processors into single files in NETCDF4 Zip format.

It is based on Python and it is an update of the original NCL routines, being at least ~2x faster.

Be aware, I used it as a playground to learn python so that it is for sure not the most efficient 
or correct code ever. 
You will need  to install some of the most common python packages, as numpy and netCDF4.

