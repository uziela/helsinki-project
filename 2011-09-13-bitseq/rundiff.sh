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

cdf_file="HGFocus_Hs_ENSG"


echo "rundiff.sh is running..."

if [ ! -d $output_dir ] ; then
	mkdir $output_dir
fi

if [ ! -f $output_dir/rna_table.RData ] ; then
	bit_file1=`ls $input_dir1/*.mean.genes`
	bit_file2=`ls $input_dir2/*.mean.genes`

	Rscript ./scripts/diff.R $bit_file1 $bit_file2 $output_dir/rna_table.RData
fi


if [ ! -f $output_dir/array_table.RData ] ; then
	Rscript ./scripts/runAffyCDFManual.R $cdf_file $cdf_file $output_dir/array_table.RData $input_dir1 $input_dir2
fi


if [ ! -f $output_dir/merged_table.RData ] ; then
	Rscript ./scripts/fixTables.R $output_dir/array_table.RData $output_dir/rna_table.RData $output_dir/merged_table.RData $output_dir/merged.table
fi


if [ ! -f $output_dir/merged.ps ] ; then
	tail -n +2 $output_dir/merged.table | cut -d ' ' -f 2,8 > $output_dir/merged.stat
	./scripts/corrcoef $output_dir/merged.stat 1 2 > $output_dir/merged.corr
	./scripts/plot-corr2.sh $output_dir/merged.stat $output_dir/merged.ps "Microarray logFC" "RNA-seq logFC"
fi



echo "rundiff.sh done."
