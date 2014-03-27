#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 1 ] ; then
	echo "
Usage: 

./clean-set.sh [Parameters]

Parameters:
<run-name> - Name of the run in run-set.sh

Example runs:
./clean-set.sh array_p
"
	exit 1
fi

run_name=$1;



# print parameters
echo "clean-set.sh has started with parameters: $*"

rm -r ./output/"$run_name"[0-9]*

rm logs/"$run_name"[0-9]*

if [ -d ./output-set/"$run_name" ] ; then
rm -r ./output-set/"$run_name"
fi

echo "clean-set.sh done."


