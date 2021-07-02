#!/bin/sh

cat > pb_20.scf.in << EOF
 &CONTROL
                       title = 'Lead' ,
                 calculation = 'scf' ,
                restart_mode = 'from_scratch' ,
                      outdir = '/home/elena/AEP_DFT/DFT/tmp/fermi' ,
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
  20 20 20   0 0 0 
EOF
~/qe-6.7/bin/pw.x < pb_20.scf.in > pb_20.scf.out

cat > pb_20.nscf.in << EOF
&CONTROL
 calculation = 'nscf',
 restart_mode='from_scratch',
 prefix = 'Pb',
 pseudo_dir = '/home/elena/qe-6.7/pseudo/',
 outdir = '/home/elena/AEP_DFT/DFT/tmp/fermi' ,
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
 20 20 20 0 0 0
EOF
~/qe-6.7/bin/pw.x < pb_20.nscf.in > pb_20.nscf.out

cat > fs.in << EOF
&FERMI
outdir= '/home/elena/AEP_DFT/DFT/tmp/fermi'
prefix= 'Pb'
&end
EOF
~/qe-6.7/bin/fs.x < fs.in > fs.out
