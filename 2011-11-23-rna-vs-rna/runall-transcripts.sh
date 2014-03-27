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
<input-dir1>  - input dir1 (bitseq)
<input-dir2>  - input dir2 (mmseq)
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
	tail -n +2 $input_dir2/$base/*.mmseq > $input_dir2/$base/mmseq.noheader
	Rscript ./scripts/rna_vs_rna_transcripts.R $input_dir1/$base/*.mean.transcripts $input_dir2/$base/mmseq.noheader $output_dir/$base.png
done

