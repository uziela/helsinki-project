#!/bin/bash

mkdir output/Marioni-0.6-0.3-seq
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.1/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.2/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.3/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.4/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-seq/Marioni-0.6-0.3-0.5/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.5 FILTER_SEQ

mkdir output/Marioni-0.3-0.3-seq
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.1/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.2/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.3/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.4/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-seq/Marioni-0.3-0.3-0.5/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.5 FILTER_SEQ

mkdir output/Marioni-0.6-0.6-seq
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.1/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.2/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.3/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.4/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-seq/Marioni-0.6-0.6-0.5/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.5 FILTER_SEQ

mkdir output/Marioni-0.6-0.3-arr
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.1/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.2/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.3/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.4/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.3-arr/Marioni-0.6-0.3-0.5/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.5 FILTER_ARR

mkdir output/Marioni-0.3-0.3-arr
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.1/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.2/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.3/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.4/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.3-0.3-arr/Marioni-0.3-0.3-0.5/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.5 FILTER_ARR

mkdir output/Marioni-0.6-0.6-arr
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.1/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.2/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.3/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.4/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-0.6-0.6-arr/Marioni-0.6-0.6-0.5/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.5 FILTER_ARR

mkdir output/Marioni-collapse
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-collapse/Marioni-0.6-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.0 COLLAPSE
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-collapse/Marioni-0.3-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.0 COLLAPSE
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-collapse/Marioni-0.6-0.6-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.0 COLLAPSE

mkdir output/Marioni-filter
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-filter/Marioni-0.6-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.3 0.0 FILTER
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-filter/Marioni-0.3-0.3-0.0/ HGU133Plus2_Hs_ENSG 0.3 0.3 0.0 FILTER
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-filter/Marioni-0.6-0.6-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.0 FILTER
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-filter/Marioni-1.0-1.0-0.0/ HGU133Plus2_Hs_ENSG 1.0 1.0 0.0 FILTER
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-filter/Marioni-2.0-2.0-0.0/ HGU133Plus2_Hs_ENSG 2.0 2.0 0.0 FILTER

mkdir output/Marioni-separate-q
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-separate-q/Marioni-0.6-0.6-0.0/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.0 SEPARATE_Q
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-separate-q/Marioni-0.6-0.6-0.2/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.2 SEPARATE_Q
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-separate-q/Marioni-0.6-0.6-0.4/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.4 SEPARATE_Q
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-separate-q/Marioni-0.6-0.6-0.6/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.6 SEPARATE_Q
sbatch ./runall_triton.sh input-Marioni ../datasets/Marioni output/Marioni-separate-q/Marioni-0.6-0.6-0.8/ HGU133Plus2_Hs_ENSG 0.6 0.6 0.8 SEPARATE_Q



