exp.name<-function(expcode) {
        print(expcode)
	if (expcode=="becs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becs01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becx00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becx01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="frad00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="frad10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="fsss00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="fsss10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="mrad01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales_EVScumdt_NOrad"
	}
	if (expcode=="recs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs03") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs04") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs05") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs03") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nosgsm"
	}
	if (expcode=="tecs04") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nothermo"
	}
	if (expcode=="tecs05") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nocond"
	}
	if (expcode=="tecs06") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nolh"
	}
	if (expcode=="tecs07") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nolh"
	}
	if (expcode=="test00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_standard"
	}
	if (expcode=="test01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_scalars"
	}
	if (expcode=="test02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies00"
	}
	if (expcode=="test03") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies01"
	}
	if (expcode=="test04") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies01"
	}
	if (expcode=="test10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool00"
	}
	if (expcode=="test11") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool01"
	}
	if (expcode=="test12") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool01"
	}
	if (expcode=="testxx") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales_EVScumdt"
	}
	if (expcode=="becs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becs01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becx00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="becx01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="frad00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="frad10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="fsss00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="fsss10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="mrad01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="256x256"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales_EVScumdt_NOrad"
	}
	if (expcode=="recs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs03") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs04") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="false"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="recs05") {
	       exptype="dycoms2_rf01"
	       reso="80x80x10"
	       domain="64x64"
	       lecs="true"
	       iradtyp="4"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool"
	}
	if (expcode=="tecs03") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nosgsm"
	}
	if (expcode=="tecs04") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nothermo"
	}
	if (expcode=="tecs05") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nocond"
	}
	if (expcode=="tecs06") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nolh"
	}
	if (expcode=="tecs07") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool_nolh"
	}
	if (expcode=="test00") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_standard"
	}
	if (expcode=="test01") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_scalars"
	}
	if (expcode=="test02") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies00"
	}
	if (expcode=="test03") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies01"
	}
	if (expcode=="test04") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_tendencies01"
	}
	if (expcode=="test10") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool00"
	}
	if (expcode=="test11") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="true"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool01"
	}
	if (expcode=="test12") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="64x64"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales2_evcool01"
	}
	if (expcode=="testxx") {
	       exptype="dycoms2_rf01"
	       reso="20x20x5"
	       domain="128x128"
	       lecs="false"
	       iradtyp="2"
	       grdtyp="1"
	       execfile="uclales_EVScumdt"
	}
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
