#!/bin/bash

#extra basic bash script that is thought to track down all the relevant 
#experiment names and properties and create and R file to be read

rm -rf core_expdescr.R expdescr.R header.txt
exptypes="dycoms_rf01 dycoms_rf02" 

for exptype in $exptypes ; do

	DIR=$HOME/PULP/jobs/dycoms2_rf01
	files=$(ls $DIR)

	for file in $files ; do
		echo $file
		sed -n '1,100p' < $DIR/$file > header.txt
		#head -n 100 $DIR/$file > header.txt
		. header.txt
		cat >> core_expdescr.R << EOF
	if (expcode=="$expcode") {
	       exptype="${exptype}"
	       reso="${deltax}x${deltay}x${deltaz}"
	       domain="${domain_size}x${domain_size}"
	       lecs="$lecs"
	       iradtyp="$iradtyp"
	       grdtyp="${grdtyp}"
	       execfile="${execfile}"
	}
EOF
	done
done

rm header.txt

cat > expdescr.R << EOF
exp.name<-function(expcode) {
        print(expcode)
EOF
cat core_expdescr.R >> expdescr.R
cat >> expdescr.R << EOF
	if (grdtyp!="1") {reso=paste0(substr(reso,start=1,stop=6),"x1A")}
        name=reso
        if (lecs=="true") {name=paste(name,"ECS")}
        if (iradtyp=="4") {name=paste(name,"FullRad")}
	if (execfile=="uclales2_evcool_nothermo") {name=paste(name,"nothermo")}
	if (execfile=="uclales2_evcool_nocond") {name=paste(name,"CHS")}
	if (execfile=="uclales2_evcool_nolh") {name=paste(name,"Lv=0")}
        out=list(exptype=exptype,expcode=expcode,name=name,reso=reso
	,domain=domain,lecs=lecs,iradtyp=iradtyp,grdtyp=grdtyp)
        return(out)
}
EOF

rm core_expdescr.R
