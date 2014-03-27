#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 2 ] ; then
        echo "
Usage: 

./move-output.sh [Parameters]

Parameters:
<input-dir> 
<output-dir> 

"
        exit 1
fi

input_dir=$1
output_dir=$2

if [ -d $output_dir ] ; then
	echo "Output directory already exists"
	exit 1
fi

mkdir $output_dir

for i in $input_dir/* ; do
	base=`basename $i`
	mkdir $output_dir/$base
	mv $i/*.rLog $i/*.rpkmS* $i/*.map.bowtieLog $i/*.prob $i/*.thetaMeans $i/*.mean* $i/*.rpkm $output_dir/$base
done

echo "Note: .map files were not moved. "

#SRR032240-CS.rLog     SRR032240-CS.rpkmS-1  SRR032240-CS.rpkmS-3     SRR032240.map.bowtieLog  SRR032240.prob
#SRR032240-CS.rpkmS-0  SRR032240-CS.rpkmS-2  SRR032240-CS.thetaMeans  SRR032240.mean           SRR032240.rpkm
