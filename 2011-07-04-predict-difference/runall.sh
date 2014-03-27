#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 6 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-file> - Input file has to be merged table with rna-seq and microarray data (output from R)
<out-dir> - output directory
<run-name> - Name of the run. It will be used to name output files (for example 'predict1')
<kernel> - kernel number (0 - linear, 1 - polynomial, 2 - radial, 3 - sigmoid)
<target-id>  - Name of the target column (for ex. adj.P.Val)
<feature-list> - List of training features delimited by '+' (for ex. baseMean+log2FoldChange+padj+GeneLengthKB)

Example runs:
./runall.sh ./input/merged_fixed.table ./output/predict1 predict1 0 adj.P.Val baseMean+log2FoldChange+padj+GeneLengthKB >logs/predict1.log 2>logs/predict1.err &
./runall.sh ./input/test.table ./output/test1 test1 0 adj.P.Val baseMean+log2FoldChange+padj+GeneLengthKB >logs/test1.log 2>logs/test1.err &
./runall.sh ./input/merged_fixed.table ./output/array1 array1 0 padj logFC+AveExpr+adj.P.Val+GeneLengthKB >logs/array1.log 2>logs/array1.err &
"
	exit 1
fi

input_file=$1;
out_dir=$2;
run_name=$3;
kernel=$4;
target=$5;
features=$6;


# print parameters
echo "runall.sh has started with parameters: $*"

# Create output dir
if [ ! -d $out_dir ] ; then
	mkdir $out_dir
fi

# Add difference of P-value column and randomize input file
if [ ! -f $input_file.rand ] ; then
	tail -n +2 $input_file > $input_file.noindex
	./scripts/difference-column.pl $input_file.noindex $input_file.diff
	paste -d ' ' $input_file.noindex $input_file.diff > $input_file.noindex2
	mv $input_file.noindex2 $input_file.noindex
	echo `head -n 1 $input_file`" pval_difference" > $input_file.rand
	cat $input_file.noindex | sort --random-sort >> $input_file.rand		# random sort all lines except the first (index) line
fi

# Create svm input file
if [ ! -f $out_dir/$run_name.svm ] ; then
	./scripts/generate_svm_input_rna_seq.pl -in $input_file.rand -svm $out_dir/$run_name.svm -index $out_dir/$run_name.index -target $target -features $features
fi

# Split svm input into 5 (almost) equal sized files
if [ ! -f $out_dir/"$run_name""_group_00.test" ] ; then
	lines=`cat $out_dir/$run_name.svm | wc -l`
	split_size=$(($lines/5))
	if [ $(($split_size*5)) -ne $lines ] ; then
		split_size=$(($split_size+1))
	fi
	
	split -l $split_size -d $out_dir/$run_name.svm $out_dir/"$run_name""_group_" 
	
	for i in $out_dir/"$run_name""_group_"* ; do
		mv $i $i.test
	done
fi

# Create training files which contain all data except for one group (4/5 groups)
if [ ! -f $out_dir/"$run_name""_group_00.train" ] ; then
	for i in $out_dir/*.test ; do 
		for j in $out_dir/*.test ; do 
			if [ $i != $j ] ; then 
				base=`basename $i .test`
				cat $j >> $out_dir/$base.train 
			fi 
		done 
	done 
fi

# Train svm
if [ ! -f $out_dir/"$run_name""_group_00.mod" ] ; then
	for i in $out_dir/*.train ; do
		base=`basename $i .train`
		svm_learn -z r -t $kernel $out_dir/$base.train $out_dir/$base.mod
	done
fi

# Make predictions
if [ ! -f $out_dir/"$run_name""_group_00.pred" ] ; then
	for i in $out_dir/*.test ; do
		base=`basename $i .test`
		svm_classify $out_dir/$base.test $out_dir/$base.mod $out_dir/$base.pred
	done
fi

# Join the files
if [ ! -f $out_dir/$run_name.pred ] ; then
	cat $out_dir/*.pred > $out_dir/$run_name.pred
fi

# Prepare the file (.stat) for calculating correlations. First column of .stat file will be correct values, second column - predicted values
if [ ! -f $out_dir/$run_name.stat ] ; then
	cut -f 1 -d " " $out_dir/$run_name.svm > $out_dir/$run_name.val
	#if [ "$target" = "pval_difference" ] ; then
	#	perl -ni -e 'if ($_ > 10) { print "10\n" } elsif ($_ < 0) { print "0\n" } else { print "$_" }' $out_dir/$run_name.pred		# correct predictions which are less than 0 or more than 10
	#elif [ "$target" = "logFC" ] || [ "$target" = "log2FoldChange" ] ; then
	#	perl -ni -e 'if ($_ > 10) { print "10\n" } elsif ($_ < -10) { print "-10\n" } else { print "$_" }' $out_dir/$run_name.pred		# correct predictions which are less than -10 or more than 10
	#else
	#	perl -ni -e 'if ($_ < -10) { print "-10\n" } elsif ($_ > 0) { print "0\n" } else { print "$_" }' $out_dir/$run_name.pred		# correct predictions which are less than -10 or more than 0
	#fi 
	paste $out_dir/$run_name.val $out_dir/$run_name.pred > $out_dir/$run_name.stat
fi

# Calculate correlation
if [ ! -f $out_dir/$run_name.corr ] ; then
	./scripts/corrcoef $out_dir/$run_name.stat 1 2 > $out_dir/$run_name.corr
fi

# Make a plot "True vs Predicted" 
if [ ! -f $out_dir/$run_name.ps ] ; then
	if [ "$target" = "pval_difference" ] ; then
		./scripts/plot-corr4.sh $out_dir/$run_name.stat $out_dir/$run_name.ps "True value" "Predicted value"		# plot-corr.sh, plot-corr2.sh and plot-corr4.sh have different value ranges
	elif [ "$target" = "logFC" ] || [ "$target" = "log2FoldChange" ] ; then
		./scripts/plot-corr2.sh $out_dir/$run_name.stat $out_dir/$run_name.ps "True value" "Predicted value"
	else
		./scripts/plot-corr.sh $out_dir/$run_name.stat $out_dir/$run_name.ps "True value" "Predicted value"
	fi 
fi 

# Make a summary
if [ ! -f $out_dir/$run_name.sum ] ; then
	echo "
Name: $run_name
Kernel: $kernel
Target: $target
Features: $features" > $out_dir/$run_name.sum
	cat $out_dir/$run_name.corr | grep 'Correlation:' >> $out_dir/$run_name.sum
	cat $out_dir/$run_name.corr | grep 'Spearman correlation:' >> $out_dir/$run_name.sum
fi 

# Prepare file with two columns <gene_id> <prediction> (for further usage in gsea)
if [ ! -f $out_dir/$run_name.rnk ] ; then
	./scripts/format-rankings.sh $input_file.rand $out_dir $run_name $target
fi
