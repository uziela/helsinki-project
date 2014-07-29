#!/bin/bash
mkdir output_LAML_all_precalc
nh logs/basic60_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 60 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"
nh logs/basic50_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 50 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"
nh logs/basic40_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 40 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"
nh logs/basic30_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 30 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"
nh logs/basic20_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-20 HGU133Plus2_Hs_ENSG BASIC 20 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"
nh logs/basic10_precalc "./runall_precalc.sh input-LAML-all ../datasets/LAML output_LAML_all_precalc/output_LAML_all-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 10 0 ../2012-02-10-PREBS/prebs_LAML_2014-06-18_with_names.txt"

