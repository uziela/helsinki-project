#!/bin/bash

./runall.sh input-Marioni-filtered-only-R ../datasets/Marioni output/Marioni-basic-0-25 HGU133Plus2_Hs_ENSG BASIC 0 25
./runall.sh input-Marioni-filtered-only-R ../datasets/Marioni output/Marioni-basic-25-50 HGU133Plus2_Hs_ENSG BASIC 25 50
./runall.sh input-Marioni-filtered-only-R ../datasets/Marioni output/Marioni-basic-50-75 HGU133Plus2_Hs_ENSG BASIC 50 75
./runall.sh input-Marioni-filtered-only-R ../datasets/Marioni output/Marioni-basic-0-75 HGU133Plus2_Hs_ENSG BASIC 0 75

./runall.sh input-B-cells ../datasets/B-cells output/B-cells-basic-0-25 HGFocus_Hs_ENSG BASIC 0 25
./runall.sh input-B-cells ../datasets/B-cells output/B-cells-basic-25-50 HGFocus_Hs_ENSG BASIC 25 50
./runall.sh input-B-cells ../datasets/B-cells output/B-cells-basic-50-75 HGFocus_Hs_ENSG BASIC 50 75
./runall.sh input-B-cells ../datasets/B-cells output/B-cells-basic-0-75 HGFocus_Hs_ENSG BASIC 0 75
