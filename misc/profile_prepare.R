# R script to modify the profile of the initial conditions
# the script simply opens a default sounding file for UCLA-LES
# and rewrites with a new name (appending $modname) in the same format
# You can modify the dataframe produced by read.table in order to create 
# your personal initial conditions

# Directories and names
DIR="/Users/paolo/Desktop"
filename="sound_in_dycm01"
modname="dry00"

# define names
infile=file.path(DIR,filename)
outfile=file.path(DIR,paste0(filename,"_",modname))

#read table as data.frame
newtable=table=read.table(infile)
ll=length(table$V1)
lev=table$V1; lev[1]=0

#modnames (use this syntax if you want to keep track of different changes)
if (modname=="dry00") {
	newtable$V3[3:ll]=0
	newtable$V2[3:ll]=newtable$V2[3:ll]-5
}

#write table copying the original format (10 characters, 3 decimals)
table_format=lapply(lapply(newtable, sprintf, fmt = "%.3f"), sprintf, fmt = "%10s")
write.table(table_format,file=outfile,quote=F,row.names=F,col.names=F,sep="")

#small loop to plot original and modified profiles (it can be commented)
varlist=c("lev","theta_l")
for (k in 2:length(varlist)) {
	plot(table[,k],lev,type="l")
	points(newtable[,k],lev,type="l",col="red")

}

