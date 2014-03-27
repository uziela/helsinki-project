#!/bin/bash

input_file=$1
output_file=$2

nonuniq=""
for i in `seq 3 450` ; do
	#echo "$i processing"
	lines=`cut -f $i -d " " $input_file | sort | uniq | wc -l`
	
	if [ $lines -eq "2" ] ; then
		nonuniq="$nonuniq,$i"
	fi
done

#echo $nonuniq

cut -d " " -f "1,2$nonuniq" $input_file > $output_file

