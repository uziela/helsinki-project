#!/bin/sh

if [ $# != 3 ] ; then
	echo "
Usage: 

./make-soft-links.sh [Parameters]

Parameters:
<input_dir>
<dataset_dir> 
<rna-dict>
"
	exit 1
fi

input_dir=$1
dataset_dir=`readlink -f $2`

#rna_dict=$dataset_dir/rna_dict.txt
rna_dict=`readlink -f $3`
sra_dir=$dataset_dir/all-sra

mkdir $input_dir
cd $input_dir
for i in `cat $rna_dict` ; do
	SAMPLE=`echo $i | cut -f 1 -d ":"`
	SRA_FILES=`echo $i | cut -f 2 -d ":"`
	SRA_FILES=`echo $SRA_FILES | sed -e "s/,/ /g"`
	
	if [ ! -d $SAMPLE ] ; then
		mkdir $SAMPLE
	fi
	
	cd $SAMPLE
	for SRA in $SRA_FILES ; do
    base_sra=`basename $SRA .sra`
		ln -s "$sra_dir/$base_sra"* .
	done
	cd ..
done
