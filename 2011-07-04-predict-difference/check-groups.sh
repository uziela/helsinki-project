#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 4 ] ; then
	echo "
Usage: 

./check-groups.sh <input-file.noindex> <input-file.pred> <out-dir> <threshold-predicted-value>

"
	exit 1
fi

input_file=$1;
pred_file=$2;
out_dir=$3;
threshold=$4;

if [ ! -d $out_dir ] ; then
	mkdir $out_dir
fi

cut -d ' ' -f 2 $input_file > $out_dir/gene_ids.txt
paste $out_dir/gene_ids.txt $pred_file > $out_dir/combined.txt

gawk -v thresh=$threshold '{ if ($2 >= thresh) print "\""$1"\"" }' $out_dir/combined.txt > $out_dir/above.csv
gawk -v thresh=$threshold '{ if ($2 < thresh) print "\""$1"\"" }' $out_dir/combined.txt > $out_dir/below.csv

