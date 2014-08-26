#!/bin/sh

output_dir="output_LAML_all_precalc_count_multiple"
output_Marioni_dir="output_Marioni_precalc_count_multiple"
Marioni_dir="plot-data-precalc/output_Marioni-basic-0-60-paper-precalc"
LAML_dir="plot-data-precalc/output_LAML_all-basic-0-60-paper-precalc"

for i in $output_dir/output_LAML_all-basic-* ; do
  ./scripts/stderr.R $i/tables/prebs_data.csv $i/tables/prebs_stderr.csv
done

for i in $output_dir/output_LAML_all-basic-* ; do
  ./scripts/stderr.R $i/tables/prebs_log2fc_data.csv $i/tables/prebs_log2fc_stderr.csv
done

for i in $output_dir/output_LAML_all-cross-diff-* ; do
  ./scripts/stderr.R $i/tables/prebs_log2fc_data.csv $i/tables/prebs_log2fc_stderr.csv
done

for i in $output_Marioni_dir/output_Marioni-basic-* ; do
  ./scripts/stderr.R $i/tables/prebs_data.csv $i/tables/prebs_stderr.csv
done

for i in $output_Marioni_dir/output_Marioni-basic-* ; do
  ./scripts/stderr.R $i/tables/prebs_log2fc_data.csv $i/tables/prebs_log2fc_stderr.csv
done

for i in $output_Marioni_dir/output_Marioni-cross-diff-* ; do
  ./scripts/stderr.R $i/tables/prebs_log2fc_data.csv $i/tables/prebs_log2fc_stderr.csv
done



./scripts/combine-stats.R prebs_stderr.csv $LAML_dir/plot-data/absolute_stderr.RData $output_dir/output_LAML_all-basic-*/tables
./scripts/combine-stats.R prebs_stderr.csv $Marioni_dir/plot-data/absolute_stderr.RData $output_Marioni_dir/output_Marioni-basic-*/tables

./scripts/combine-stats.R prebs_log2fc_stderr.csv $LAML_dir/plot-data/diff_stderr.RData $output_dir/output_LAML_all-basic-*/tables
./scripts/combine-stats.R prebs_log2fc_stderr.csv $Marioni_dir/plot-data/diff_stderr.RData $output_Marioni_dir/output_Marioni-basic-*/tables

./scripts/combine-stats.R prebs_log2fc_stderr.csv $LAML_dir/plot-data/cross_diff_stderr.RData $output_dir/output_LAML_all-cross-diff-*/tables
./scripts/combine-stats.R prebs_log2fc_stderr.csv $Marioni_dir/plot-data/cross_diff_stderr.RData $output_Marioni_dir/output_Marioni-cross-diff-*/tables

