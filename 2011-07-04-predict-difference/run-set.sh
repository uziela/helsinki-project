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
<input-file> - Input file has to be merged table with "$run_name"-seq and microarray data (output from R)
<target-id>  - Name of the target column (for ex. adj.P.Val)
<run-name> - Name of the run. It will be used to name output files (for example 'predict1')

Example runs:
./run-set.sh ./input/merged_fixed.table adj.P.Val array_p
"
	exit 1
fi

input_file=$1;
target=$2;
run_name=$3;


# print parameters
echo "run-set.sh has started with parameters: $*"

# Add difference of P-value column and randomize input file
if [ ! -f $input_file.rand ] ; then
	tail -n +2 $input_file > $input_file.noindex
	./scripts/difference-column.pl $input_file.noindex $input_file.diff
	paste -d ' ' $input_file.noindex $input_file.diff > $input_file.noindex2
	mv $input_file.noindex2 $input_file.noindex
	echo `head -n 1 $input_file`" pval_difference" > $input_file.rand
	cat $input_file.noindex | sort --random-sort >> $input_file.rand		# random sort all lines except the first (index) line
fi

if [ $target = "adj.P.Val" ] || [ "$target" = "logFC" ] ; then
	./runall.sh $input_file ./output/"$run_name"01 "$run_name"01 0 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"01.log 2>logs/"$run_name"01.err &
	./runall.sh $input_file ./output/"$run_name"02 "$run_name"02 0 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"02.log 2>logs/"$run_name"02.err &
	./runall.sh $input_file ./output/"$run_name"03 "$run_name"03 0 $target baseMean+log2FoldChange+padj >logs/"$run_name"03.log 2>logs/"$run_name"03.err &
	./runall.sh $input_file ./output/"$run_name"04 "$run_name"04 0 $target baseMean+padj+GeneLengthKB >logs/"$run_name"04.log 2>logs/"$run_name"04.err &
	./runall.sh $input_file ./output/"$run_name"05 "$run_name"05 0 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"05.log 2>logs/"$run_name"05.err &
	./runall.sh $input_file ./output/"$run_name"06 "$run_name"06 2 $target baseMean+log2FoldChange+padj+GeneLengthKB >logs/"$run_name"06.log 2>logs/"$run_name"06.err &
	./runall.sh $input_file ./output/"$run_name"07 "$run_name"07 2 $target log2FoldChange+padj+GeneLengthKB >logs/"$run_name"07.log 2>logs/"$run_name"07.err &
	./runall.sh $input_file ./output/"$run_name"08 "$run_name"08 2 $target baseMean+log2FoldChange+padj >logs/"$run_name"08.log 2>logs/"$run_name"08.err &
	./runall.sh $input_file ./output/"$run_name"09 "$run_name"09 2 $target baseMean+padj+GeneLengthKB >logs/"$run_name"09.log 2>logs/"$run_name"09.err &
	./runall.sh $input_file ./output/"$run_name"10 "$run_name"10 2 $target baseMean+log2FoldChange+GeneLengthKB >logs/"$run_name"10.log 2>logs/"$run_name"10.err &
fi

if [ $target = "padj" ] || [ "$target" = "log2FoldChange" ] ; then
	./runall.sh $input_file ./output/"$run_name"01 "$run_name"01 0 $target logFC+AveExpr+adj.P.Val+GeneLengthKB >logs/"$run_name"01.log 2>logs/"$run_name"01.err &
	./runall.sh $input_file ./output/"$run_name"02 "$run_name"02 0 $target logFC+adj.P.Val+GeneLengthKB >logs/"$run_name"02.log 2>logs/"$run_name"02.err &
	./runall.sh $input_file ./output/"$run_name"03 "$run_name"03 0 $target logFC+AveExpr+adj.P.Val >logs/"$run_name"03.log 2>logs/"$run_name"03.err &
	./runall.sh $input_file ./output/"$run_name"04 "$run_name"04 0 $target AveExpr+adj.P.Val+GeneLengthKB >logs/"$run_name"04.log 2>logs/"$run_name"04.err &
	./runall.sh $input_file ./output/"$run_name"05 "$run_name"05 0 $target logFC+AveExpr+GeneLengthKB >logs/"$run_name"05.log 2>logs/"$run_name"05.err &
	./runall.sh $input_file ./output/"$run_name"06 "$run_name"06 2 $target logFC+AveExpr+adj.P.Val+GeneLengthKB >logs/"$run_name"06.log 2>logs/"$run_name"06.err &
	./runall.sh $input_file ./output/"$run_name"07 "$run_name"07 2 $target logFC+adj.P.Val+GeneLengthKB >logs/"$run_name"07.log 2>logs/"$run_name"07.err &
	./runall.sh $input_file ./output/"$run_name"08 "$run_name"08 2 $target logFC+AveExpr+adj.P.Val >logs/"$run_name"08.log 2>logs/"$run_name"08.err &
	./runall.sh $input_file ./output/"$run_name"09 "$run_name"09 2 $target AveExpr+adj.P.Val+GeneLengthKB >logs/"$run_name"09.log 2>logs/"$run_name"09.err &
	./runall.sh $input_file ./output/"$run_name"10 "$run_name"10 2 $target logFC+AveExpr+GeneLengthKB >logs/"$run_name"10.log 2>logs/"$run_name"10.err &
fi


if [ ! -d ./output-set/"$run_name" ] ; then
	mkdir ./output-set/"$run_name"
else
	echo "Warning: ./output-set/$run_name already exists... Please, delete it before summarizing new results"
fi

echo "run-set.sh done."


