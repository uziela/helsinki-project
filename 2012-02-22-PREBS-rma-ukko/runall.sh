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
<input-dir> - Input directory (soft link to mmseq input directory)
<dataset-dir> - Dataset directory
<output-dir> - Output directory
<cdf-name> - cdf name
<mode> - BASIC, REPLACE or NEW_DIFF
<percentage> - what percentage of the most expressed genes should we take?

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
#alpha=$5
#beta=$6
#quantile=$7
#mode=$8
mode=$5
percentage=$6

#collapse="0.3"

cdf_package=`echo $my_cdf"cdf" | awk '{print tolower($0)}' | sed -e 's/_//g'`


if [ ! -d $output_dir ] ; then
	mkdir $output_dir
fi

if [ ! -f $output_dir/PREBS_probe_table.RData ] ; then
	./scripts/PREBS_probe_table.R $output_dir/PREBS_probe_table.RData $cdf_package $input_dir/*/probe_counts.RData
fi

if [ ! -f $output_dir/PREBS_RMA.RData ] ; then
	./scripts/PREBS_RMA_exprs.R $dataset_dir/all-cel $my_cdf $output_dir/PREBS_probe_table.RData $output_dir/PREBS_RMA.RData
fi

if [ ! -d $output_dir/plots ] ; then
	mkdir $output_dir/plots
	mkdir $output_dir/tables
	mkdir $output_dir/plots-diff
	#abs_path=`readlink -f $input_dir`
	#ln -s $abs_path/*/plots/* $output_dir/plots
	#cp $input_dir/*/plots/* $output_dir/plots
	./scripts/PREBS_RMA_save.R $output_dir $input_dir/*
	
	./scripts/PREBS_stats.R $output_dir $mode $percentage $output_dir/*_merged.RData
	./scripts/csv_to_html.py $output_dir/tables/prebs_stats.csv $output_dir/tables/prebs_stats.html "," "Absolute expression correlations"
	./scripts/csv_to_html.py $output_dir/tables/prebs_improve.csv $output_dir/tables/prebs_improve.html "," "Absolute expression correlation improvements"
	
	./scripts/csv_to_html.py $output_dir/tables/prebs_log2fc_stats.csv $output_dir/tables/prebs_log2fc_stats.html "," "Differential expression correlations"
	./scripts/csv_to_html.py $output_dir/tables/prebs_log2fc_improve.csv $output_dir/tables/prebs_log2fc_improve.html "," "Differential expression correlation improvements"	
	cat $output_dir/tables/prebs_stats.html $output_dir/tables/prebs_improve.html $output_dir/tables/prebs_log2fc_stats.html $output_dir/tables/prebs_log2fc_improve.html > $output_dir/all_tables.html
	echo "<html>
<b>Parameters</b><br>
	<b>Input directory:</b> $input_dir <br>
	<b>Run mode:</b> $mode <br>
	<b>Percentage of genes taken:</b> $percentage<br>
</html>"	>> $output_dir/all_tables.html	
	
fi


echo "runall.sh done."
