#!/bin/sh

if [ $# != 3 ] ; then
        echo "
Usage: 

./all-triton.sh <input-dir> <dataset-dir> <cdf-name>

Commonly used CDFs:
HGU133Plus2_Hs_ENSG (Marioni, FIMM)
HGU133A2_Hs_ENSG	(Lungs_C)
HuEx10stv2_Hs_ENSG	(Lungs_S, brain)
HGFocus_Hs_ENSG		(Cheung)
"
        exit 1
fi


input_dir=$1
dataset_dir=$2
cdf=$3

for i in `cat $dataset_dir/array-dict/dict_array_short.txt` ; do
	SAMPLE=`echo $i | cut -f 1 -d ":"`
	indexes=`echo $i | cut -f 2 -d ":"`
	sbatch -o ./logs/$SAMPLE.log -e ./logs/$SAMPLE.err ./run_triton.sh $input_dir/$SAMPLE $cdf $input_dir/$SAMPLE/$SAMPLE.gene.mmseq $indexes $dataset_dir/array_expr.RData
done
