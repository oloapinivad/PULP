# create a zaxis for UCLA-LES which is finer in the inversion and coarser elsewhere using a sine function
# dz is the maximum resolution, zi the inversion height and top the maximum grid height
# np_* control the number of points in the inversion, in the pbl and in the free troposphere
zaxis.creator.sin <- function(dz, zi = 840, top = 1500, np_inv = 75, np_pbl = 100, np_ft = 20) {

  # this is the extension of the inversion
  range <- (np_inv / 2) * dz

  factor_pbl <- (zi - range - dz*np_pbl)/sum(sin(seq(0, pi, , np_pbl)))
  levels_pbl <- cumsum(sin(seq(0,pi,,np_pbl))*factor_pbl + dz)

  factor_ft <- (top - (zi+range) - dz*np_ft)/sum(rev(1-sin(seq(0,pi/2,,np_ft))))
  levels_ft <-  cumsum(rev(1-sin(seq(0,pi/2,,np_ft)))*factor_ft + dz) + zi + range

  inversion <- rep(dz, np_inv)

  levels=c(firstlevel, levels_pbl ,cumsum(inversion) + zi - range, levels_ft)

  print(paste("Total number of points:", length(levels)))
  print(paste("Maximum pbl delta:", max(diff(levels_pbl))))
  print(paste("Inversion range is from", zi - range, "to", zi + range, "meters"))
  
  return(levels)
  
}

axis_fine <- zaxis.creator.sin(0.2, np_inv = 500, np_pbl = 100, np_ft = 30)
axis_base <- zaxis.creator.sin(1, np_inv = 150, np_pbl = 80, np_ft = 25)


plot(diff(axis_fine), levels[2:length(axis_fine)], xlim=c(0,30),
     main="Vertical grid",xlab="Delta-X",ylab="Height", col = "navy")
points(diff(axis_base), axis_base[2:length(axis_base)], col="darkviolet")
#abline(h=c(highrange,zi,zi-range))
text(0,1200,paste("Sin-levels 0.2m:",length(axis_fine)),col="navy",pos=4)
text(0,1100,paste("Sin-levels 1m:",length(axis_base)),col="darkviolet",pos=4)

#write(round(axis_fine,1),file="/Users/paolo/Dropbox/Work/LES/dycoms_rf01_zaxis_02m_631.txt",ncolumns=1)
 


