#!/bin/bash
mkdir output_LAML_all
nh logs/basic60 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 60 0"
nh logs/basic50 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 50 0"
nh logs/basic40 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 40 0"
nh logs/basic30 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 30 0"
nh logs/basic20 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-20 HGU133Plus2_Hs_ENSG BASIC 20 0"
nh logs/basic10 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 10 0"

