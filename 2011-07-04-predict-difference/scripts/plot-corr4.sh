gnuplot <<EOF
set size 1.0, 0.7
set size square
set terminal postscript portrait lw 3 "Helvetica" 14 
set key below box
set output "$2"
set xrange [ -1.00 : 11.00 ]
set yrange [ -1.00 : 11.00 ]
set xlabel "$3"
set ylabel "$4"
plot "$1" with dots
exit
EOF
