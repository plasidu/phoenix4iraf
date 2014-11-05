set term png
set xtics 0.1
set output 'V-C.png'
plot 'output.dat' u 1:($3-$4) title 'V-C'
set output 'V-K1.png'
plot 'output.dat' u 1:($3-$5) title 'V-K1'
