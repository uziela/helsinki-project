#!/bin/bash
mkdir output_LAML_all
nh logs/cross-diff60 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 0"
nh logs/cross-diff50 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 0"
nh logs/cross-diff40 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 0"
nh logs/cross-diff30 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 0"
nh logs/cross-diff20 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 20 0"
nh logs/cross-diff10 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 0"

