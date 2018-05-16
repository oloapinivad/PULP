# PULP v0.2
## Postprocessing for Ucla-Les with Python

Nov 2017

by P. Davini (ISAC-CNR, p.davini@isac.cnr.it)

*PULP* is thought as a basic tool for handling UCLA-LES runs.

It combines a series of tools:
1. **compiler** : a simple script  to speed up compilation procedure.
2. **namelist** : a basic namelist used for UCLA-LES simulations.
3. **jobs** : includes a powerful automatic job script equipped with resubmission, autopostrocessing and namelist setup.
4. **initfiles** : initial conditions and special vertical axis coordinates.
5. **postproc** : the original PULP tool. A series of script aimed at recombining the output from different processors into single files in NETCDF4 Zip format. It is based on Python and it is an update of the original NCL routines, being at least ~2x faster. It includes a correct handling of thermo and speed points. Be aware, I used it as a playground to learn Python so that it is for sure not the most efficient  or correct code ever. You will need  to install some of the most common Python packages, as numpy and netCDF4. CDO is used for joining 3d variables.

