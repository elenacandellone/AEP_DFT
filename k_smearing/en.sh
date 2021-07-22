#!/bin/sh
kgrid="2 4 6 8 10 12 14 16 18 20"
smearing="0.10 0.09 0.08 0.07 0.06 0.05 0.04 0.03 0.02 0.01"

for k in $kgrid 
do
for sigma in $smearing
do 
printf "${k}"
printf "	"
printf "${sigma}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' pb_${k}_${sigma}.scf.out 
done
done > energy.dat

