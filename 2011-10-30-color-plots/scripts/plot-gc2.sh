output_file=$1

gnuplot <<EOF
set size 1.0, 0.7
set size square
set terminal postscript portrait lw 3 color "Helvetica" 14 
set key below box
#set nokey
set output "$output_file"
#set xrange [ -11.00 : 1.00 ]
#set yrange [ -11.00 : 1.00 ]
set xlabel "Microarray logfc"
set ylabel "RNA-seq logfc"
plot "./gct.txt" using 2:3 with dots title "GC content 0%-25% quantile", "./gctmore25.txt" using 2:3 with dots title "GC content 25%-50% quantile", \
"./gctmore50.txt" using 2:3 with dots title "GC content 50%-75% quantile", "./gctmore75.txt" using 2:3 with dots title "GC content 75%-100% quantile"
exit
EOF
