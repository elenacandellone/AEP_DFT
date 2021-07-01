gnuplot
set size 0.9, 0.9

set xlabel "Smearing" font "Times New Roman, 33" offset 0,-1
set ylabel "Energy/atom (Ryd)" font "Times New Roman, 33" offset -3,0

set tics font "Times New Roman, 25" 


plot "energy.dat" using 2:3 index 0 with lines title "k=2",\
"energy.dat" using 2:3 index 1 with lines title "k=4",\
"energy.dat" using 2:3 index 2 with lines title "k=6",\
"energy.dat" using 2:3 index 3 with lines title "k=8",\
"energy.dat" using 2:3 index 4 with lines title "k=10",\
"energy.dat" using 2:3 index 5 with lines title "k=12",\
"energy.dat" using 2:3 index 6 with lines title "k=14"

