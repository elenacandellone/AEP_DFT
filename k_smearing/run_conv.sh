#!/bin/sh
kgrid="2 4 6 8 10 12 14 16 18 20"
smearing="0.10 0.09 0.08 0.07 0.06 0.05 0.04 0.03 0.02 0.01"
for k in $kgrid 
do
for sigma in $smearing
do 
cat > pb_${k}_${sigma}.scf.in  <<EOF
 &CONTROL
                       title = 'Lead' ,
                 calculation = 'scf' ,
                restart_mode = 'from_scratch' ,
                      outdir = '/home/elena/AEP_DFT/DFT/tmp/k_smearing' ,
                  pseudo_dir = '/home/elena/qe-6.7/pseudo/' ,
                      prefix = 'Pb',
                      wf_collect = .true.
 /
 &SYSTEM
                       ibrav = 2,
                   celldm(1) = 9.297451,
                         nat = 1,
                        ntyp = 1,
                     ecutwfc = 70 ,
                     ecutrho = 560,
                 occupations = 'smearing' ,
                     degauss = ${sigma},
		    smearing ='mp',
 /
 &ELECTRONS
                    conv_thr = 1.0d-9
 /
ATOMIC_SPECIES
   Pb  207.20000  Pb.pbe-dn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal 
   Pb      0.000000000    0.000000000    0.000000000    
K_POINTS automatic 
  ${k} ${k} ${k}   0 0 0 
EOF
~/qe-6.7/bin/pw.x <pb_${k}_${sigma}.scf.in> /home/elena/AEP_DFT/DFT/k_smearing/pb_${k}_${sigma}.scf.out
done
done
