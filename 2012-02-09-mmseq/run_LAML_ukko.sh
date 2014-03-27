#!/bin/bash

sample_n=$1
input_dir=$2

base_dir="/cs/hiit/wfa/uziela/2012-02-09-mmseq"
#input_dir="input-LAML-1-30"
dataset_dir="/cs/hiit/wfa/uziela/datasets/LAML"
genome="ref_transcriptome_65_corrected/Homo_sapiens.GRCh37.65.ref_transcripts"

cd $base_dir

SAMPLE=`ls -1 $input_dir | sed -n "$sample_n"p`

./run_mmseq_new.sh $input_dir/$SAMPLE $genome

