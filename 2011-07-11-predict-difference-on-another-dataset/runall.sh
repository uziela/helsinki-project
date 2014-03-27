#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 7 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<train-file> - merged table which will be used for training
<test-file> - merged table which will be used for testing
<out-dir> - output directory
<run-name> - Name of the run. It will be used to name output files (for example 'rna_logfc1')
<kernel> - kernel number (0 - linear, 1 - polynomial, 2 - radial, 3 - sigmoid)
<target-id>  - Name of the target column (for ex. adj.P.Val)
<feature-list> - List of training features delimited by '+' (for ex. baseMean+log2FoldChange+padj+GeneLengthKB)

Example runs:
./runall.sh ./input/marioni.table ./input/fimm.table ./output/rna_logfc1 rna_logfc1 0 logFC baseMean+log2FoldChange+padj+GeneLengthKB >logs/rna_logfc1.log 2>logs/rna_logfc1.err &
./runall.sh ./input/test.table ./input/fimm.table ./output/test1 test1 0 logFC baseMean+log2FoldChange+padj+GeneLengthKB >logs/test1.log 2>logs/test1.err &
"
	exit 1
fi

train_file=$1;
test_file=$2;
out_dir=$3;
run_name=$4;
kernel=$5;
target=$6;
features=$7;


# print parameters
echo "runall.sh has started with parameters: $*"

# Create output dir
if [ ! -d $out_dir ] ; then
	mkdir $out_dir
fi

# Randomize input file
#if [ ! -f $train_file.rand ] ; then
#	tail -n +2 $train_file > $train_file.noindex
#	echo `head -n 1 $train_file` > $train_file.rand
#	cat $train_file.noindex | sort --random-sort >> $train_file.rand		# random sort all lines except the first (index) line
#fi

# Create svm input file
if [ ! -f $out_dir/$run_name.test ] ; then
	./scripts/generate_svm_input_rna_seq.pl -in $train_file -svm $out_dir/$run_name.train -index $out_dir/$run_name.index -target $target -features $features
	./scripts/generate_svm_input_rna_seq.pl -in $test_file -svm $out_dir/$run_name.test -index $out_dir/$run_name.index -target $target -features $features
fi

# Train svm
if [ ! -f $out_dir/"$run_name.mod" ] ; then
	svm_learn -z r -t $kernel $out_dir/$run_name.train $out_dir/$run_name.mod
fi



# Make predictions
if [ ! -f $out_dir/"$run_name.pred" ] ; then
	svm_classify $out_dir/$run_name.test $out_dir/$run_name.mod $out_dir/$run_name.pred
fi

# Prepare the file (.stat) for calculating correlations. First column of .stat file will be correct values, second column - predicted values
if [ ! -f $out_dir/$run_name.stat ] ; then
	cut -f 1 -d " " $out_dir/$run_name.test > $out_dir/$run_name.val
	
	#if [ "$target" = "logFC" ] || [ "$target" = "log2FoldChange" ] ; then
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
	if [ "$target" = "logFC" ] || [ "$target" = "log2FoldChange" ] ; then
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

