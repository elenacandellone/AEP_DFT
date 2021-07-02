#!/bin/sh
kgrid="8 10 12 14 16 18 20 22 24"

# Perform the SCF computation
cat > pb.scf.in << EOF
 &CONTROL
                       title = 'Lead' ,
                 calculation = 'scf' ,
                restart_mode = 'from_scratch' ,
                      outdir = '/home/elena/AEP_DFT/DFT/tmp/bands' ,
                  pseudo_dir = '/home/elena/qe-6.7/pseudo/' ,
                      prefix = 'Pb',
                      wf_collect = .true.
 /
 &SYSTEM
                       ibrav = 2,
                   celldm(1) = 9.2225583816,
                         nat = 1,
                        ntyp = 1,
                     ecutwfc = 70 ,
                     ecutrho = 560 ,
                 occupations = 'smearing' ,
                     degauss = 0.02 ,
		    smearing ='mp',
 /
 &ELECTRONS
                    conv_thr = 1.0d-9,
 /
ATOMIC_SPECIES
   Pb  207.20000  Pb.pbe-dn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal 
   Pb      0.000000000    0.000000000    0.000000000    
K_POINTS automatic 
  10 10 10   0 0 0 
EOF
~/qe-6.7/bin/pw.x < pb.scf.in > pb.scf.out

# Perform convergence of DOS
for k in $kgrid
do
# Perform the nscf computation
cat > pb_${k}.nscf.in << EOF
&CONTROL
 calculation = 'nscf',
 restart_mode='from_scratch',
 prefix = 'Pb',
 pseudo_dir = '/home/elena/qe-6.7/pseudo/',
 outdir = '/home/elena/AEP_DFT/DFT/tmp/bands' ,
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 2,
 celldm(1) = 9.2225583816,
 nat = 1,
 ntyp = 1,
 ecutwfc = 70 ,
 ecutrho = 560 ,
 occupations = 'tetrahedra',
 nbnd = 8
/
&ELECTRONS
 conv_thr =   1.0d-9
 diago_full_acc = .true.
/
ATOMIC_SPECIES
Pb  207.20000  Pb.pbe-dn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal
   Pb      0.000000000    0.000000000    0.000000000    
K_POINTS automatic 
 ${k} ${k} ${k} 0 0 0
EOF
~/qe-6.7/bin/pw.x < pb_${k}.nscf.in > pb_${k}.nscf.out

# Perform the DOS computation
cat > dos_${k}.in << EOF
&DOS
outdir = '/home/elena/AEP_DFT/DFT/tmp/bands'
prefix = 'Pb'
fildos = 'pb_${k}.dos'
/
EOF
~/qe-6.7/bin/dos.x < dos_${k}.in > dos_${k}.out
done
