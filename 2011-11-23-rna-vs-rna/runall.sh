#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 3 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir1>  - input dir1
<input-dir2>  - input dir2
<output-dir> - output directory


"
	exit 1
fi

input_dir1=$1
input_dir2=$2
output_dir=$3

if [ ! -d $output_dir ] ; then
	mkdir $output_dir
fi

for i in $input_dir1/* ; do
	base=`basename $i`
	#ls $input_dir1/$base/rna_table.RData
	#ls $input_dir2/$base/rna_table.RData
	Rscript ./scripts/rna_vs_rna.R $input_dir1/$base/rna_table.RData $input_dir2/$base/rna_table.RData $output_dir/"$base".png
	name1=`echo $base | awk '{print substr($0,1,7)}'`
	name2=`echo $base | awk '{print substr($0,12,7)}'`
	#Rscript ./scripts/rna_vs_rna_exp.R $input_dir1/$base/rna_table.RData $input_dir2/$base/rna_table.RData $output_dir/"$name1".png $output_dir/"$name2".png
done

