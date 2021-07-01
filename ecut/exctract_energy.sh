#!/bin/sh
Ecut="10 15 20 25 30 35 40 50 60 70 80 90 100"

for ec in $Ecut
do
printf "${ec}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' pb_${ec}.scf.out 
done > energy.dat
