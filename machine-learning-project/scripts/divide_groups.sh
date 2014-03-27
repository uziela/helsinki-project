#!/bin/sh

if [ $# != 1 ] ; then
	echo "
Usage: 

./divide_groups.sh [Parameters]

Parameters:
<input-file> - input directory (will also be used as an output directory)

"
	exit 1
fi

input_file=$1;
dirn=`dirname $input_file`


# Split svm input into 5 (almost) equal sized files
if [ ! -f "$dirn""/group_00.test" ] ; then
	lines=`cat $input_file | wc -l`
	split_size=$(($lines/5))
	
	if [ $(($split_size*5)) -ne $lines ] ; then
		split_size=$(($split_size+1))
	fi
	
	split -l $split_size -d $input_file $dirn"/group_" 
	
	for i in $dirn/group* ; do
		mv $i $i.test
	done
	
fi
