#!/bin/sh

output_dir="output_LAML_all_precalc_count_multiple"
output_dir2="output_Marioni_precalc_count_multiple"
Marioni_dir="plot-data-precalc/output_Marioni-basic-0-60-paper-precalc"
LAML_dir="plot-data-precalc/output_LAML_all-basic-0-60-paper-precalc"

./scripts/combine-stats.R prebs_stats.csv $Marioni_dir/plot-data/absolute_stats.RData $output_dir2/output_Marioni-basic-*/tables
./scripts/combine-stats.R prebs_stats.csv $LAML_dir/plot-data/absolute_stats.RData $output_dir/output_LAML_all-basic-*/tables

./scripts/combine-stats.R prebs_log2fc_stats.csv $Marioni_dir/plot-data/diff_stats.RData $output_dir2/output_Marioni-basic-*/tables
./scripts/combine-stats.R prebs_log2fc_stats.csv $LAML_dir/plot-data/diff_stats.RData $output_dir/output_LAML_all-basic-*/tables

./scripts/combine-stats.R prebs_log2fc_stats.csv $Marioni_dir/plot-data/cross_diff_stats.RData $output_dir2/output_Marioni-cross-diff-*/tables
./scripts/combine-stats.R prebs_log2fc_stats.csv $LAML_dir/plot-data/cross_diff_stats.RData $output_dir/output_LAML_all-cross-diff-*/tables

mkdir $LAML_dir/correlation-scatter-plot

cp $output_dir/output_LAML_all-basic-0-10/tables/prebs_data.csv $LAML_dir/correlation-scatter-plot/prebs_data_0-10.csv
cp $output_dir/output_LAML_all-basic-0-10/tables/prebs_log2fc_data.csv $LAML_dir/correlation-scatter-plot/prebs_log2fc_data_0-10.csv
cp $output_dir/output_LAML_all-basic-0-60/tables/prebs_data.csv $LAML_dir/correlation-scatter-plot/prebs_data_0-60.csv
cp $output_dir/output_LAML_all-basic-0-60/tables/prebs_log2fc_data.csv $LAML_dir/correlation-scatter-plot/prebs_log2fc_data_0-60.csv
