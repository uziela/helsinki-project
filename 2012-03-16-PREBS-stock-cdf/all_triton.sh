#!/bin/bash

if [ $# != 3 ] ; then
        echo "
Usage: 

./all-triton.sh <input-dir> <dataset-dir> <cdf-name>

Commonly used CDFs:
HGU133Plus2 (Marioni, FIMM)
HGU133A2	(Lungs_C)
HuEx10stv2	(Lungs_S, brain)
HGFocus	(Cheung)
"
        exit 1
fi


input_dir=$1
dataset_dir=$2
cdf=$3

for i in $input_dir/* ; do
	SAMPLE=`basename $i`
	sbatch -o ./logs/$SAMPLE.log -e ./logs/$SAMPLE.err ./run_triton.sh $input_dir/$SAMPLE $cdf $dataset_dir
done
