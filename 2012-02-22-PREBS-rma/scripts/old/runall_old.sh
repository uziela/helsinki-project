#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 8 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input directory (soft link to mmseq input directory)
<dataset-dir> - Dataset directory
<output-dir> - Output directory
<cdf-name> - cdf name
<alpha>
<collapse>
<quantile> - which microarray quantile to filter?
<mode> - FILTER, COLLAPSE or SEPARATE_Q

Commonly used CDFs:
HGU133Plus2_Hs_ENSG (Marioni, FIMM)
HGU133A2_Hs_ENSG	(Lungs_C)
HuEx10stv2_Hs_ENSG	(Lungs_S, brain)
HGFocus_Hs_ENSG		(Cheung)

"
	exit 1
fi

input_dir=$1
dataset_dir=$2
output_dir=$3
my_cdf=$4
alpha=$5
collapse=$6
quantile=$7
mode=$8

cdf_package=`echo $my_cdf"cdf" | awk '{print tolower($0)}' | sed -e 's/_//g'`


if [ ! -d $output_dir ] ; then
	mkdir $output_dir
fi

if [ ! -f $output_dir/PREBS_probe_table.RData ] ; then
	./scripts/PREBS_probe_table.R $output_dir/PREBS_probe_table.RData $cdf_package $input_dir/*/probe_counts.RData
fi

if [ ! -f $output_dir/PREBS_RMA.RData ] ; then
	./scripts/PREBS_RMA_exprs.R $dataset_dir/all-cel $my_cdf $output_dir/PREBS_probe_table.RData $output_dir/PREBS_RMA.RData $alpha
fi

if [ ! -d $output_dir/plots ] ; then
	mkdir $output_dir/plots
	mkdir $output_dir/tables
	#abs_path=`readlink -f $input_dir`
	#ln -s $abs_path/*/plots/* $output_dir/plots
	#cp $input_dir/*/plots/* $output_dir/plots
	./scripts/PREBS_RMA_save.R $output_dir $input_dir/*
	
	./scripts/PREBS_stats.R $output_dir $collapse $alpha $quantile $mode $output_dir/*_merged.RData
	./scripts/csv_to_html.py $output_dir/tables/prebs_stats.csv $output_dir/tables/prebs_stats.html "," "Absolute expression correlations"
	./scripts/csv_to_html.py $output_dir/tables/prebs_improve.csv $output_dir/tables/prebs_improve.html "," "Absolute expression correlation improvements"
fi

############ Differential expression ############

if [ ! -f $output_dir/RPKM_table.RData ] ; then
	./scripts/RPKM_table.R $output_dir/RPKM_table.RData $input_dir/*/accepted_hits_counts.RData
fi

if [ ! -d $output_dir/plots-diff ] ; then
	mkdir $output_dir/plots-diff
	./scripts/log2FC.R $dataset_dir/array_expr_means.RData $dataset_dir/rna_expr_means.RData $output_dir/PREBS_RMA.RData $output_dir/RPKM_table.RData $output_dir $collapse $alpha $quantile $mode
	./scripts/csv_to_html.py $output_dir/tables/prebs_log2fc_stats.csv $output_dir/tables/prebs_log2fc_stats.html "," "Differential expression correlations"
	./scripts/csv_to_html.py $output_dir/tables/prebs_log2fc_improve.csv $output_dir/tables/prebs_log2fc_improve.html "," "Differential expression correlation improvements"
	cat $output_dir/tables/prebs_stats.html $output_dir/tables/prebs_improve.html $output_dir/tables/prebs_log2fc_stats.html $output_dir/tables/prebs_log2fc_improve.html > $output_dir/all_tables.html
	echo "<html>
<b>Parameters:</b><br>
	<b>Input directory:</b> $input_dir <br>
	<b>Alpha:</b> $alpha <br>
	<b>Collapse point:</b> $collapse <br>
	<b>Quantile filter:</b> $quantile <br>
</html>"	>> $output_dir/all_tables.html
fi

echo "runall.sh done."
