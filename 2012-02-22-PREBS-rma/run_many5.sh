#!/bin/bash

sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 0 10
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-20 HGU133Plus2_Hs_ENSG BASIC 0 20
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 0 30
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 0 40
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 0 50
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 0 60
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-basic-0-70 HGU133Plus2_Hs_ENSG BASIC 0 70

sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-10 HGU133Plus2_Hs_ENSG BASIC 0 10
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-20 HGU133Plus2_Hs_ENSG BASIC 0 20
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 0 30
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 0 40
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 0 50
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 0 60
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-basic-0-70 HGU133Plus2_Hs_ENSG BASIC 0 70

sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 10
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 20
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 30
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 40
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 50
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 60
sbatch ./runall_triton.sh input-Marioni-filtered-only-R ../datasets/Marioni output-intersect/Marioni-cross-diff-0-70 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 70

sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 10
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-20 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 20
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 30
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 40
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 50
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 60
sbatch ./runall_triton.sh input-LAML-7-only-R ../datasets/LAML output-intersect/LAML-cross-diff-0-70 HGU133Plus2_Hs_ENSG CROSS_DIFF 0 70

