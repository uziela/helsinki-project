#!/bin/sh

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 2 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<src-dir> 
<dest-dir> 


"
	exit 1
fi

source=$1
dest=$2

current=`pwd`

mkdir $dest

ln -s $current/$source/all-cel $current/$dest
ln -s $current/$source/all-sra $current/$dest
ln -s $current/$source/array_dict.txt $current/$dest
ln -s $current/$source/rna_dict.txt $current/$dest

echo "runall.sh done."
