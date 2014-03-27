#!/bin/bash

mkdir output/B-cells-0.6-0.3-seq
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.0/ HGFocus_Hs_ENSG 0.6 0.3 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.1/ HGFocus_Hs_ENSG 0.6 0.3 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.2/ HGFocus_Hs_ENSG 0.6 0.3 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.3/ HGFocus_Hs_ENSG 0.6 0.3 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.4/ HGFocus_Hs_ENSG 0.6 0.3 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-seq/B-cells-0.6-0.3-0.5/ HGFocus_Hs_ENSG 0.6 0.3 0.5 FILTER_SEQ

mkdir output/B-cells-0.3-0.3-seq
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.0/ HGFocus_Hs_ENSG 0.3 0.3 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.1/ HGFocus_Hs_ENSG 0.3 0.3 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.2/ HGFocus_Hs_ENSG 0.3 0.3 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.3/ HGFocus_Hs_ENSG 0.3 0.3 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.4/ HGFocus_Hs_ENSG 0.3 0.3 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-seq/B-cells-0.3-0.3-0.5/ HGFocus_Hs_ENSG 0.3 0.3 0.5 FILTER_SEQ

mkdir output/B-cells-0.6-0.6-seq
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.1/ HGFocus_Hs_ENSG 0.6 0.6 0.1 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.2/ HGFocus_Hs_ENSG 0.6 0.6 0.2 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.3/ HGFocus_Hs_ENSG 0.6 0.6 0.3 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.4/ HGFocus_Hs_ENSG 0.6 0.6 0.4 FILTER_SEQ
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-seq/B-cells-0.6-0.6-0.5/ HGFocus_Hs_ENSG 0.6 0.6 0.5 FILTER_SEQ

mkdir output/B-cells-0.6-0.3-arr
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.0/ HGFocus_Hs_ENSG 0.6 0.3 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.1/ HGFocus_Hs_ENSG 0.6 0.3 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.2/ HGFocus_Hs_ENSG 0.6 0.3 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.3/ HGFocus_Hs_ENSG 0.6 0.3 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.4/ HGFocus_Hs_ENSG 0.6 0.3 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.3-arr/B-cells-0.6-0.3-0.5/ HGFocus_Hs_ENSG 0.6 0.3 0.5 FILTER_ARR

mkdir output/B-cells-0.3-0.3-arr
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.0/ HGFocus_Hs_ENSG 0.3 0.3 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.1/ HGFocus_Hs_ENSG 0.3 0.3 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.2/ HGFocus_Hs_ENSG 0.3 0.3 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.3/ HGFocus_Hs_ENSG 0.3 0.3 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.4/ HGFocus_Hs_ENSG 0.3 0.3 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.3-0.3-arr/B-cells-0.3-0.3-0.5/ HGFocus_Hs_ENSG 0.3 0.3 0.5 FILTER_ARR

mkdir output/B-cells-0.6-0.6-arr
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.1/ HGFocus_Hs_ENSG 0.6 0.6 0.1 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.2/ HGFocus_Hs_ENSG 0.6 0.6 0.2 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.3/ HGFocus_Hs_ENSG 0.6 0.6 0.3 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.4/ HGFocus_Hs_ENSG 0.6 0.6 0.4 FILTER_ARR
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-0.6-0.6-arr/B-cells-0.6-0.6-0.5/ HGFocus_Hs_ENSG 0.6 0.6 0.5 FILTER_ARR

mkdir output/B-cells-collapse
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-collapse/B-cells-0.6-0.3-0.0/ HGFocus_Hs_ENSG 0.6 0.3 0.0 COLLAPSE
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-collapse/B-cells-0.3-0.3-0.0/ HGFocus_Hs_ENSG 0.3 0.3 0.0 COLLAPSE
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-collapse/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 COLLAPSE

mkdir output/B-cells-filter
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-filter/B-cells-0.6-0.3-0.0/ HGFocus_Hs_ENSG 0.6 0.3 0.0 FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-filter/B-cells-0.3-0.3-0.0/ HGFocus_Hs_ENSG 0.3 0.3 0.0 FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-filter/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-filter/B-cells-1.0-1.0-0.0/ HGFocus_Hs_ENSG 1.0 1.0 0.0 FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-filter/B-cells-2.0-2.0-0.0/ HGFocus_Hs_ENSG 2.0 2.0 0.0 FILTER

mkdir output/B-cells-separate-q
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 SEPARATE_Q
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q/B-cells-0.6-0.6-0.2/ HGFocus_Hs_ENSG 0.6 0.6 0.2 SEPARATE_Q
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q/B-cells-0.6-0.6-0.4/ HGFocus_Hs_ENSG 0.6 0.6 0.4 SEPARATE_Q
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q/B-cells-0.6-0.6-0.6/ HGFocus_Hs_ENSG 0.6 0.6 0.6 SEPARATE_Q
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q/B-cells-0.6-0.6-0.8/ HGFocus_Hs_ENSG 0.6 0.6 0.8 SEPARATE_Q

mkdir output/B-cells-separate-q-filter
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q-filter/B-cells-0.6-0.6-0.0/ HGFocus_Hs_ENSG 0.6 0.6 0.0 SEPARATE_Q_FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q-filter/B-cells-0.6-0.6-0.2/ HGFocus_Hs_ENSG 0.6 0.6 0.2 SEPARATE_Q_FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q-filter/B-cells-0.6-0.6-0.4/ HGFocus_Hs_ENSG 0.6 0.6 0.4 SEPARATE_Q_FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q-filter/B-cells-0.6-0.6-0.6/ HGFocus_Hs_ENSG 0.6 0.6 0.6 SEPARATE_Q_FILTER
sbatch ./runall_triton.sh input-B-cells ../datasets/B-cells output/B-cells-separate-q-filter/B-cells-0.6-0.6-0.8/ HGFocus_Hs_ENSG 0.6 0.6 0.8 SEPARATE_Q_FILTER

