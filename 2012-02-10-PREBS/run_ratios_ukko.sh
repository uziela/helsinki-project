#!/bin/bash

sample_n=$1
input_dir=$2
output_dir=$3

base_dir="/cs/hiit/wfa/uziela/2012-02-10-PREBS"

cd $base_dir

SAMPLE=`ls -1 $input_dir | sed -n "$sample_n"p`

mkdir -p $output_dir

nohup ./scripts/count_ratios.R $input_dir/$SAMPLE/accepted_hits.RData cdf/HGU133Plus2_Hs_ENSG_mapping.txt > $output_dir/${SAMPLE}_ratios.csv
