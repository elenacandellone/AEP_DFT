set yrange [-10:1]
plot "< awk '{print $1,$2-prev; prev=$2}' energy.dat"

