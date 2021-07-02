#!/bin/sh
kgrid="8 10 12 14 16 18"
smearing=" 0.04 0.03 0.02 0.01 0.009"

for k in $kgrid 
do
for sigma in $smearing
do 
printf "${k}"
printf "	"
printf "${sigma}"
printf "        "
awk 'BEGIN{FS=" *= *"} /freq (    1)/{split($2,a," +");print "  " a[1]}' dynq_G_${k}_${sigma}
done
done > frequencies.dat

