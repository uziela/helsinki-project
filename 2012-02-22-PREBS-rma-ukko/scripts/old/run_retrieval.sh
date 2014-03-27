#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland


echo "PREBS"
./scripts/retrieval.R ../datasets/LAML/array_expr_means_all.RData PREBS_RMA ./output/LAML-7-60/*_merged.RData
#./scripts/retrieval.R ../datasets/MILES/array_expr_means_with_MILES_5000.RData PREBS_RMA ./output/LAML-7-60/*_merged.RData

echo "MMSEQ"
./scripts/retrieval.R ../datasets/LAML/array_expr_means_all.RData mmseq_expr ./output/LAML-7-60/*_merged.RData
#./scripts/retrieval.R ../datasets/MILES/array_expr_means_with_MILES_5000.RData mmseq_expr ./output/LAML-7-60/*_merged.RData

echo "RPKM"
./scripts/retrieval.R ../datasets/LAML/array_expr_means_all.RData RPKM ./output/LAML-7-60/*_merged.RData
#./scripts/retrieval.R ../datasets/MILES/array_expr_means_with_MILES_5000.RData RPKM ./output/LAML-7-60/*_merged.RData
