gnuplot <<EOF
set size 1.0, 0.7
set size square
set terminal postscript portrait lw 3 "Helvetica" 14 
set output "$2"
set xrange [ 0.00 : 1.00 ]
#set yrange [ 0.00 : 1.00 ]
set xlabel "S-score"
set ylabel "Count"
plot "$1" with steps
exit
EOF

