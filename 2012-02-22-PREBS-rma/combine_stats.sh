#!/bin/sh

output_dir="output_LAML_all"
#Marioni_dir="Marioni-basic-0-60-paper"
LAML_dir="output_LAML_all-basic-0-60-paper"

#./scripts/combine-stats.R prebs_stats.csv $Marioni_dir/plot-data/absolute_stats.RData $output_dir/Marioni-basic-*/tables
./scripts/combine-stats.R prebs_stats.csv $LAML_dir/plot-data/absolute_stats.RData $output_dir/output_LAML_all-basic-*/tables

#./scripts/combine-stats.R prebs_log2fc_stats.csv $Marioni_dir/plot-data/diff_stats.RData $output_dir/Marioni-basic-*/tables
./scripts/combine-stats.R prebs_log2fc_stats.csv $LAML_dir/plot-data/diff_stats.RData $output_dir/output_LAML_all-basic-*/tables

#./scripts/combine-stats.R prebs_log2fc_stats.csv $Marioni_dir/plot-data/cross_diff_stats.RData $output_dir/Marioni-cross-diff-*/tables
./scripts/combine-stats.R prebs_log2fc_stats.csv $LAML_dir/plot-data/cross_diff_stats.RData $output_dir/output_LAML_all-cross-diff-*/tables

mkdir $LAML_dir/correlation-scatter-plot

cp output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv $LAML_dir/correlation-scatter-plot/prebs_data_0-10.csv
cp output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_log2fc_data.csv $LAML_dir/correlation-scatter-plot/prebs_log2fc_data_0-10.csv

cp output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_data.csv $LAML_dir/correlation-scatter-plot/prebs_data_0-60.csv
cp output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_data.csv $LAML_dir/correlation-scatter-plot/prebs_log2fc_data_0-60.csv
