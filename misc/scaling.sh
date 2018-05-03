#!/bin/bash
DIR=/rigel/glab/users/pd2507/log/uclales
filein=$(ls -tr $DIR/*.out | tail -1)
back=5000
#filein=$DIR/ucla_dycoms_dssa_6137237.out
#cat  $filein | grep "step"
#lines=$(cat  $filein | grep "Timestep" | wc -l)
#total=$(cat  $filein | grep "Timestep" | awk '{ SUM += $11} END { print SUM }')
#tstep=$(cat  $filein | grep "Timestep" | awk '{ SUM += $8} END { print SUM }')
lines=$(tail -$back  $filein | grep "Timestep" | wc -l)
total=$(tail -$back $filein | grep "Timestep" | awk '{ SUM += $11} END { print SUM }')
tstep=$(tail -$back  $filein | grep "Timestep" | awk '{ SUM += $8} END { print SUM }')

#echo $lines $total
last=$(cat  $filein | grep "step" | tail -1 )
echo $last
avgtime=$(echo  $total $lines | awk '{print $1/$2}' )
avgtstep=$(echo  $tstep $lines | awk '{print $1/$2}' )
ratio=$(echo  $avgtime $avgtstep | awk '{print $1/$2}' )
echo "Avg timestep of $avgtstep sec is run in $avgtime over last $lines timesteps"
echo "Avg time for 1-h simulation is $ratio h"
