#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 1 ] ; then
	echo "
The script will prepare directory structure with microarray/rna-seq folders and phen1/phen2 subfolders. Use it before running runall.sh

Usage: 

./prepare.sh [Parameters]

Parameters:
<dir-name> - dir name which you want to prepare

"
	exit 1
fi

input_dir=$1;



mkdir $input_dir

mkdir $input_dir/rna-seq
mkdir $input_dir/rna-seq/phen1
mkdir $input_dir/rna-seq/phen2

mkdir $input_dir/microarray
mkdir $input_dir/microarray/phen1
mkdir $input_dir/microarray/phen2


