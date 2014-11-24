#!/bin/bash

sample_n=$1
input_dir=$2

base_dir="/cs/hiit/wfa/uziela/2012-02-10-PREBS"
#input_dir="input-LAML-17-nogap"
dataset_dir="/cs/hiit/wfa/uziela/datasets/LAML"
cdf="HGU133Plus2_Hs_ENSG"

cd $base_dir

SAMPLE=`ls -1 $input_dir | sed -n "$sample_n"p`

#GAP=`cat $dataset_dir/gaps.txt | grep $SAMPLE | cut -f 2 -d " "`

./runall_precalc.sh $input_dir/$SAMPLE $cdf $input_dir/$SAMPLE/$SAMPLE.gene.mmseq $dataset_dir PAIRED

