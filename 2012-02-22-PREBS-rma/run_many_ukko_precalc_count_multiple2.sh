#!/bin/bash
mkdir output_LAML_all_precalc_count_multiple
nh logs/cross-diff60_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"
nh logs/cross-diff50_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"
nh logs/cross-diff40_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"
nh logs/cross-diff30_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"
nh logs/cross-diff20_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 20 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"
nh logs/cross-diff10_precalc_count_multiple "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_count_multiple/output_LAML_all-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 0 ../2012-02-10-PREBS/prebs_LAML_2014-07-25_count_multiple_with_names.txt"

