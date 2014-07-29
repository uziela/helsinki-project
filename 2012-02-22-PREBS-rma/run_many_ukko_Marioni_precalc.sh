#!/bin/bash
mkdir output_Marioni_precalc
nh logs/basic60_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 60 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"
nh logs/basic50_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 50 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"
nh logs/basic40_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 40 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"
nh logs/basic30_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 30 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"
nh logs/basic20_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-20 HGU133Plus2_Hs_ENSG BASIC 20 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"
nh logs/basic10_Marioni_precalc "./runall_precalc.sh input-Marioni ../datasets/Marioni output_Marioni_precalc/output_Marioni-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 10 0 ../2012-02-10-PREBS/prebs_marioni_2014-07-24.txt"

