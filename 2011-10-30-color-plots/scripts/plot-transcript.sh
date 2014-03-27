output_file=$1

gnuplot <<EOF
set size 1.0, 0.7
set size square
set terminal postscript portrait lw 6 color "Helvetica" 14 
set key below box
#set nokey
set output "$output_file"
#set xrange [ -11.00 : 1.00 ]
#set yrange [ -11.00 : 1.00 ]
set xlabel "Microarray logfc"
set ylabel "RNA-seq logfc"
plot "./me.txt" using 2:3 with dots title ">10 transcripts", "./me10.txt" using 2:3 with dots title "6-10 transcripts", \
"./me5.txt" using 2:3 with dots title "3-5 transcripts", "./me2.txt" using 2:3 with dots title "2 transcripts", \
"./me1.txt" using 2:3 with dots title "1 transcript"
exit
EOF
