#!/bin/bash

sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 0 10
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-10-20 HGU133Plus2_Hs_ENSG BASIC 10 20
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-20-30 HGU133Plus2_Hs_ENSG BASIC 20 30
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-30-40 HGU133Plus2_Hs_ENSG BASIC 30 40
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-40-50 HGU133Plus2_Hs_ENSG BASIC 40 50
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-50-60 HGU133Plus2_Hs_ENSG BASIC 50 60
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-basic-60-70 HGU133Plus2_Hs_ENSG BASIC 60 70

sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 0 10
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-10-20 HGU133Plus2_Hs_ENSG BASIC 10 20
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-20-30 HGU133Plus2_Hs_ENSG BASIC 20 30
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-30-40 HGU133Plus2_Hs_ENSG BASIC 30 40
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-40-50 HGU133Plus2_Hs_ENSG BASIC 40 50
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-50-60 HGU133Plus2_Hs_ENSG BASIC 50 60
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-basic-60-70 HGU133Plus2_Hs_ENSG BASIC 60 70

sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 10
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-10-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 20
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-20-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 20 30
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-30-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 40
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-40-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 50
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-50-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 60
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output2/Marioni-cross-diff-60-70 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 70

sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 10
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-10-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 20
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-20-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 20 30
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-30-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 40
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-40-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 50
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-50-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 60
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output2/LAML-cross-diff-60-70 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 70

