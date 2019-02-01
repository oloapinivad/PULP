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
		sed -n '20,100p' < $DIR/$file > header.txt
		#head -n 100 $DIR/$file > header.txt
		. header.txt
		[ -z $lchs ] && lchs=false
		[ -z $lecs ] && lecs=false
		[ -z $casename ] && casename="dycoms"
		cat >> core_expdescr.R << EOF
	if (expcode=="$expcode") {
	       exptype="${exptype}"
	       reso="${deltax}x${deltay}x${deltaz}"
	       domain="${domain_size}x${domain_size}"
	       lecs="$lecs"
	       lchs="$lchs"
	       iradtyp="$iradtyp"
	       grdtyp="${grdtyp}"
	       execfile="${execfile}"
	       casename="${casename}"
	       dt="${dtlong}"
	}
EOF
unset lchs
unset lecs
unset casename
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
        name=paste0(reso," dt=",dt)
        if (lecs=="true") {name=paste(name,"ECS")}
	if (lchs=="true") {name=paste(name,"CHS")}
        if (iradtyp=="4") {name=paste(name,"FullRad")}
	if (casename=="norad") {name=paste(name,"NoRad")}
	if (execfile=="uclales2_evcool_nothermo") {name=paste(name,"nothermo")}
	if (execfile=="uclales2_evcool_nocond") {name=paste(name,"CHS")}
	if (execfile=="uclales2_evcool_nolh") {name=paste(name,"Lv=0")}
	if (execfile=="uclales2_evcool_cumECS") {name=paste(name,"cumECS")}
	if (execfile=="uclales2_evcool_noliquid") {name=paste(name,"cumECS+CHS")}
	if (lecs=="true" & execfile=="uclales2_evcool_cumECStest2") {name=paste(name,"cum")}
        out=list(exptype=exptype,expcode=expcode,name=name,reso=reso
	,domain=domain,lchs=lchs,lecs=lecs,iradtyp=iradtyp,grdtyp=grdtyp)
        return(out)
}
EOF

rm core_expdescr.R
