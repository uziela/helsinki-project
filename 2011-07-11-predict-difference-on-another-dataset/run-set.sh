#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 3 ] ; then
	echo "
Usage: 

./run-set.sh [Parameters]

Parameters:
<input-dir> - input directory with merged tables (.table)
<features> 	- combination of features which we should try. See the code for details.
<run-name>	- name of the run
"
	exit 1
fi

input_dir=$1;
feat=$2;
run_name=$3;
target="logFC"

if [ ! -f $input_dir/input.done ] ; then
	# remove index
	for i in $input_dir/*.table ; do
		tail -n +2 $i > $i.noindex
		if [ ! -f $input_dir/index.txt ] ; then
			head -n 1 $i > $input_dir/index.txt
		fi
	done
	
	# cat all but one files contents to train files
	for i in $input_dir/*.noindex ; do
		for j in $input_dir/*.noindex ; do
			if [ $i != $j ] ; then
				base=`basename $i .noindex`
				cat $j >> $input_dir/$base.rawtrain
			fi
		done
	done
	
	# randomize train files, add index
	for i in $input_dir/*.rawtrain ; do
		base=`basename $i .rawtrain`
		cp $input_dir/index.txt $input_dir/$base.rand
		cat $i | sort --random-sort >> $input_dir/$base.rand
	done
	
	touch $input_dir/input.done
fi

if [ -d ./output/"$run_name" ] ; then
	echo "ERROR: ./output/$run_name already exists. Delete directory or use different run_name"
	exit 1
else
	mkdir ./output/"$run_name"
	mkdir ./logs/"$run_name"
fi



if [ "$feat" = "1" ] ; then
	for test_file in $input_dir/*.table ; do
		train_file="$test_file.rand"
		base=`basename $test_file .table`
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"01 "$base"01 0 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"01.log 2>logs/"$run_name"/"$base"01.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"02 "$base"02 0 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"02.log 2>logs/"$run_name"/"$base"02.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"03 "$base"03 0 $target baseMean+log2FoldChange+padj >logs/"$run_name"/"$base"03.log 2>logs/"$run_name"/"$base"03.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"04 "$base"04 0 $target baseMean+padj+GeneLengthKB >logs/"$run_name"/"$base"04.log 2>logs/"$run_name"/"$base"04.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"05 "$base"05 0 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"05.log 2>logs/"$run_name"/"$base"05.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"06 "$base"06 2 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"06.log 2>logs/"$run_name"/"$base"06.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"07 "$base"07 2 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"07.log 2>logs/"$run_name"/"$base"07.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"08 "$base"08 2 $target baseMean+log2FoldChange+padj >logs/"$run_name"/"$base"08.log 2>logs/"$run_name"/"$base"08.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"09 "$base"09 2 $target baseMean+padj+GeneLengthKB >logs/"$run_name"/"$base"09.log 2>logs/"$run_name"/"$base"09.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"10 "$base"10 2 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"10.log 2>logs/"$run_name"/"$base"10.err &
	done
elif [ "$feat" = "2" ] ; then
	for test_file in $input_dir/*.table ; do
		train_file="$test_file.rand"
		base=`basename $test_file .table`
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"01 "$base"01 0 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"01.log 2>logs/"$run_name"/"$base"01.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"02 "$base"02 0 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"02.log 2>logs/"$run_name"/"$base"02.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"03 "$base"03 0 $target baseMean+log2FoldChange+padj >logs/"$run_name"/"$base"03.log 2>logs/"$run_name"/"$base"03.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"04 "$base"04 0 $target baseMean+padj+GeneLengthKB >logs/"$run_name"/"$base"04.log 2>logs/"$run_name"/"$base"04.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"05 "$base"05 0 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"05.log 2>logs/"$run_name"/"$base"05.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"06 "$base"06 0 $target baseMean+log2FoldChange >logs/"$run_name"/"$base"06.log 2>logs/"$run_name"/"$base"06.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"07 "$base"07 0 $target log2FoldChange+padj >logs/"$run_name"/"$base"07.log 2>logs/"$run_name"/"$base"07.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"08 "$base"08 0 $target log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"08.log 2>logs/"$run_name"/"$base"08.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"09 "$base"09 2 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"09.log 2>logs/"$run_name"/"$base"09.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"10 "$base"10 2 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"/"$base"10.log 2>logs/"$run_name"/"$base"10.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"11 "$base"11 2 $target baseMean+log2FoldChange+padj >logs/"$run_name"/"$base"11.log 2>logs/"$run_name"/"$base"11.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"12 "$base"12 2 $target baseMean+padj+GeneLengthKB >logs/"$run_name"/"$base"12.log 2>logs/"$run_name"/"$base"12.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"13 "$base"13 2 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"13.log 2>logs/"$run_name"/"$base"13.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"14 "$base"14 2 $target baseMean+log2FoldChange >logs/"$run_name"/"$base"14.log 2>logs/"$run_name"/"$base"14.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"15 "$base"15 2 $target log2FoldChange+padj >logs/"$run_name"/"$base"15.log 2>logs/"$run_name"/"$base"15.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"16 "$base"16 2 $target log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"16.log 2>logs/"$run_name"/"$base"16.err &
	done
elif [ "$feat" = "3" ] ; then
	for test_file in $input_dir/*.table ; do
		train_file="$test_file.rand"
		base=`basename $test_file .table`
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"01 "$base"01 0 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"01.log 2>logs/"$run_name"/"$base"01.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"02 "$base"02 0 $target baseMean+log2FoldChange >logs/"$run_name"/"$base"02.log 2>logs/"$run_name"/"$base"02.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"03 "$base"03 0 $target log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"03.log 2>logs/"$run_name"/"$base"03.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"04 "$base"04 2 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"04.log 2>logs/"$run_name"/"$base"04.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"05 "$base"05 2 $target baseMean+log2FoldChange >logs/"$run_name"/"$base"05.log 2>logs/"$run_name"/"$base"05.err &
		./runall.sh $train_file $test_file ./output/"$run_name"/"$base"06 "$base"06 2 $target log2FoldChange+GeneLengthKB >logs/"$run_name"/"$base"06.log 2>logs/"$run_name"/"$base"06.err &
	done
fi

if [ ! -d ./output-set/"$run_name" ] ; then
	mkdir ./output-set/"$run_name"
else
	echo "Warning: ./output-set/$run_name already exists... Please, delete it before summarizing new results"
fi

