#!/bin/sh

if [ $# != 2 ] ; then
        echo "
Usage: 

./all-triton.sh [Parameters]

Parameters:
<input-dir> - input dir
<transcriptome> - Location of bowtie index for transriptome (without .fa extension)
"
        exit 1
fi

input_dir=$1
transcript=$2

for i in $input_dir/* ; do
	SAMPLE=`basename $i`
	sbatch -o logs/$SAMPLE.log -e logs/$SAMPLE.err run_mmseq_new_triton.sh $i $transcript
done
