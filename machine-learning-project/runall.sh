#!/bin/sh

if [ $# != 3 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-file> - input file (for example, T-61_3050_full_data_set.txt)
<output-dir> - output directory
<kernel> - 0:linear, 1:polynomial, 2:radial, 3:sigmoid

"
	exit 1
fi

input_file=$1
#dirn=`dirname $input_file`
output_dir=$2
kernel=$3

# remove columns which contain only 0 or only 1 training values
if [ ! -f $output_dir/data_clean.txt ] ; then
	./scripts/remove.sh $input_file $output_dir/data_clean.txt
fi

# randomize lines of data file
if [ ! -f $output_dir/data_random.txt ] ; then
	cat $output_dir/data_clean.txt | sort --random-sort > $output_dir/data_random.txt
fi

# convert file to svm light input format
if [ ! -f $output_dir/data.svm ] ; then
	./scripts/generate-svm-input.py $output_dir/data_random.txt $output_dir/data.svm
fi


# Split svm input into 10 (almost) equal sized files
if [ ! -f "$output_dir""/group_00.test" ] ; then
	lines=`cat $output_dir/data.svm | wc -l`
	split_size=$(($lines/10))
	
	if [ $(($split_size*10)) -ne $lines ] ; then
		split_size=$(($split_size+1))
	fi
	
	split -l $split_size -d $output_dir/data.svm "$output_dir""/group_" 
	
	for i in $output_dir/group* ; do
		mv $i $i.test
	done
	
fi

# Create training files which contain all data except for one group (9/10 groups)
if [ ! -f "$output_dir""/group_00.train" ] ; then
	for i in $output_dir/*.test ; do 
		for j in $output_dir/*.test ; do 
			if [ $i != $j ] ; then 
				base=`basename $i .test`
				cat $j >> $output_dir/$base.train 
			fi 
		done 
	done 
fi

# Train svm
if [ ! -f $output_dir"/group_00.mod" ] ; then
	for i in $output_dir/*.train ; do
		base=`basename $i .train`
		svm_learn -z c -t $kernel $output_dir/$base.train $output_dir/$base.mod
	done
fi

# Make predictions
if [ ! -f $output_dir/"group_00.pred" ] ; then
	for i in $output_dir/*.test ; do
		base=`basename $i .test`
		svm_classify $output_dir/$base.test $output_dir/$base.mod $output_dir/$base.pred
	done
fi

# Join prediction files
if [ ! -f $output_dir/data.pred ] ; then
	cat $output_dir/*.pred > $output_dir/data.pred
fi

# Calculate statistics
if [ ! -f $output_dir/statistics.txt ] ; then
	cut -d " " -f 1 $output_dir/data.svm > $output_dir/data.classes
	paste $output_dir/data.classes $output_dir/data.pred > $output_dir/data.stat
	cat $output_dir/data.stat | ./scripts/statistics.pl > $output_dir/statistics.txt
fi
