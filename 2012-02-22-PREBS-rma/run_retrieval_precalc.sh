#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

filter_n=$1

my_path="/cs/hiit/wfa/uziela/2012-02-22-PREBS-rma"

mkdir -p $my_path/output_retrieval_LAML_all_precalc

for my_method in mmseq_expr RPKM PREBS_RMA ; do
	echo $my_method
	$my_path/scripts/retrieval.R $my_path/../datasets/LAML/array_expr_means_all.RData $my_method $filter_n $my_path/output_retrieval_LAML_all_precalc/$my_method-$filter_n.csv $my_path/output_LAML_all_precalc_count_multiple/output_LAML_all-basic-0-10/*_merged.RData
done
