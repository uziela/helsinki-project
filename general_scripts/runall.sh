#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 1 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - input directory (will also be used as an output directory)

Example run:
./runall.sh input/final-dataset >logs/final-dataset.log 2>logs/final-dataset.err &
"
	exit 1
fi

input_dir=$1;


