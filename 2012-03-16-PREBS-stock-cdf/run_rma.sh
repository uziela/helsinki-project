#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 6 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input dir
<output-dir> - Output dir
<cdf> - cdf name
<dataset-dir> - Dataset directory (processed with stock cdf!!!)
<alpha>
<beta>


Commonly used CDFs:
HGU133Plus2 (Marioni, FIMM)
HGU133A2	(Lungs_C)
HuEx10stv2	(Lungs_S, brain)
HGFocus	(Cheung)
"
	exit 1
fi

input_dir=$1
output_dir=$2
my_cdf=$3
dataset_dir=$4
alpha=$5
beta=$6

cdf_package=`echo $my_cdf"cdf" | awk '{print tolower($0)}' | sed -e 's/_//g'`

if [ ! -d $output_dir ] ; then
	mkdir $output_dir
fi

if [ ! -f $output_dir/PREBS_probe_table.RData ] ; then
	echo "------------------- stage 1 -------------------" 1>&2
	./scripts/PREBS_probe_table.R $output_dir/PREBS_probe_table.RData $cdf_package $input_dir/*/probe_counts.RData
fi

if [ ! -f $output_dir/PREBS_probe_table_corrected.csv ] ; then
	echo "------------------- stage 2 -------------------" 1>&2
	cat $output_dir/PREBS_probe_table.csv | ./scripts/sum_duplicates.pl > $output_dir/PREBS_probe_table_corrected.csv
	./scripts/save_table.R $output_dir/PREBS_probe_table_corrected.csv $output_dir/PREBS_probe_table_corrected.RData
fi

if [ ! -f $output_dir/PREBS_RMA.RData ] ; then
	echo "------------------- stage 3 -------------------" 1>&2
	./scripts/PREBS_RMA_exprs.R $dataset_dir/all-cel $my_cdf $output_dir/PREBS_probe_table_corrected.RData $output_dir/PREBS_RMA.RData $alpha $beta
fi

if [ ! -d $output_dir/plots ] ; then
	mkdir $output_dir/plots
	mkdir $output_dir/plots-diff
	./scripts/plot_stock.R $output_dir/PREBS_RMA.RData $dataset_dir/array_expr_means.RData $output_dir
fi
