#!/bin/bash

output_dir=$1

mkdir -p $output_dir-plots

./scripts/cor-table-plot.R $output_dir-plots/cor-plots-Marioni-abs.pdf prebs_stats.csv "Absolute expression correlations for Marioni dataset" $output_dir/Marioni-basic-*/tables
./scripts/cor-table-plot.R $output_dir-plots/cor-plots-LAML-abs.pdf prebs_stats.csv "Absolute expression correlations for LAML dataset" $output_dir/LAML-basic-*/tables

./scripts/cor-table-plot.R $output_dir-plots/cor-plots-Marioni-log2fc.pdf prebs_log2fc_stats.csv "Differential expression correlations for Marioni dataset" $output_dir/Marioni-basic-*/tables
./scripts/cor-table-plot.R $output_dir-plots/cor-plots-LAML-log2fc.pdf prebs_log2fc_stats.csv "Differential expression correlations for LAML dataset" $output_dir/LAML-basic-*/tables

./scripts/cor-table-plot.R $output_dir-plots/cor-plots-Marioni-cross-diff.pdf prebs_log2fc_stats.csv "Cross-platform differential expression correlations for Marioni dataset" $output_dir/Marioni-cross-diff-*/tables
./scripts/cor-table-plot.R $output_dir-plots/cor-plots-LAML-cross-diff.pdf prebs_log2fc_stats.csv "Cross-platform differential expression correlations for LAML dataset" $output_dir/LAML-cross-diff-*/tables

