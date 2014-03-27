#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 1 ] ; then
        echo "
Usage: 

./move-output.sh [Parameters]

Parameters:
<input-dir> 

"
        exit 1
fi

input_dir=$1


for i in $input_dir/* ; do
	rm $i/*.rLog $i/*.rpkmS* $i/*.prob $i/*.thetaMeans $i/*.mean* $i/*.rpkm 
done

echo "Note: .map and .bowtieLog files were not deleted. "

#SRR032240-CS.rLog     SRR032240-CS.rpkmS-1  SRR032240-CS.rpkmS-3     SRR032240.map.bowtieLog  SRR032240.prob
#SRR032240-CS.rpkmS-0  SRR032240-CS.rpkmS-2  SRR032240-CS.thetaMeans  SRR032240.mean           SRR032240.rpkm
