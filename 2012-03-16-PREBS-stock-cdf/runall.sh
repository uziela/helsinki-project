#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 3 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input directory (will also be used for output). Must have .CEL and .fastq files
<cdf> - cdf name
<dataset-dir> - Dataset directory

Commonly used CDFs:
HGU133Plus2 (Marioni, FIMM)
HGU133A2	(Lungs_C)
HuEx10stv2	(Lungs_S, brain)
HGFocus	(Cheung)
"
	exit 1
fi

input_dir=$1
my_cdf=$2
dataset_dir=$3
array_expr_means="dataset_dir/array_expr_means.RData"

run_name=`basename $input_dir`

# Get counts for probe regions
if [ ! -f $input_dir/probe_counts.RData ] ; then
	echo "------------------- stage 1 -------------------"
	echo "------------------- stage 1 -------------------" 1>&2
	probe_mapping="stock-cdf/$my_cdf/$my_cdf""_mapping.txt"
	Rscript scripts/count_overlaps.R $input_dir/accepted_hits.RData $input_dir/probe_counts.RData $probe_mapping
fi

# Calculate PREBS
if [ ! -f $input_dir/$run_name"_PREBS.RData" ] ; then
	echo "------------------- stage 2 -------------------"
	echo "------------------- stage 2 -------------------" 1>&2
	Rscript scripts/gene_expressions.R $input_dir/probe_counts.RData $input_dir/$run_name"_PREBS.RData"
fi

echo "runall.sh done."
