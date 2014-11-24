#!/bin/bash
mkdir output_LAML_all_precalc_rpa
nh logs/cross-diff60_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"
nh logs/cross-diff50_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"
nh logs/cross-diff40_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"
nh logs/cross-diff30_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"
nh logs/cross-diff20_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 20 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"
nh logs/cross-diff10_precalc_rpa "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc_rpa/output_LAML_all-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 0 ../2012-02-10-PREBS/rpa_laml_2014-11-12_a_with_names.txt rpa"

