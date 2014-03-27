#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 3 ] ; then
	echo "
Usage: 

./summarize-set.sh [Parameters]

Parameters:
<input-dir> - what was the input dir?
<features> - what was the combination of features?
<run-name> - run name which was used in run-set.sh

"
	exit 1
fi

input_dir=$1;
feat=$2;
run_name=$3;
target="logFC"

# print parameters
echo "summarize-set.sh has started with parameters: $*"

if [ -d ./output-set/"$run_name" ] ; then
rm -r ./output-set/"$run_name"
fi

out_dir="./output-set/$run_name";
mkdir $out_dir

if [ "$feat" = "1" ] ; then
	featn=5
elif [ "$feat" = "2" ] ; then
	featn=8
elif [ "$feat" = "3" ] ; then
	featn=3
fi


for input_file in $input_dir/*.table ; do
	base=`basename $input_file .table`
	mkdir $out_dir/$base
	
	# calculate corr_to_improve
	if [ $target = 'logFC' ] ; then
		cut -d ' ' -f 1 ./output/"$run_name"/"$base"01/"$base"01.test > $out_dir/$base/targetlog.stat
		cut -d ' ' -f 3 ./output/"$run_name"/"$base"01/"$base"01.test > $out_dir/$base/trainlog1.stat
		cut -d ':' -f 2 $out_dir/$base/trainlog1.stat > $out_dir/$base/trainlog2.stat
		./scripts/corrcoef $out_dir/$base/targetlog.stat $out_dir/$base/trainlog2.stat > $out_dir/$base/log.corr
		corr_to_improve=`cat $out_dir/$base/log.corr | grep Correlation | perl -pe 's/Correlation: //'`
		corr_to_improve_sp=`cat $out_dir/$base/log.corr | grep "Spearman correlation:" | perl -pe 's/Spearman correlation: //'`
	fi
	
	# create html table
	cat ./output/"$run_name"/"$base"[0-9]*/"$base"*.sum > $out_dir/$base/"$base".sum
	./scripts/create-table.pl $out_dir/$base/"$base".sum $out_dir/$base/"$base".html $featn $corr_to_improve 0
	./scripts/create-table.pl $out_dir/$base/"$base".sum $out_dir/$base/"$base"_spearman.html $featn $corr_to_improve_sp 1
	
	# make plots
	for i in ./output/"$run_name"/"$base"[0-9]*/"$base"*.ps ; do
		convert $i $out_dir/$base/`basename $i .ps`.png
	done
	
	if [ $target = 'logFC' ] ; then
		paste $out_dir/$base/targetlog.stat $out_dir/$base/trainlog2.stat > $out_dir/$base/array-rna.stat
		./scripts/plot-corr2.sh $out_dir/$base/array-rna.stat $out_dir/$base/array-rna.ps "Microarray log2 fold change" "RNA-seq log2 fold change"
		convert $out_dir/$base/array-rna.ps $out_dir/$base/array-rna.png
	fi
	
done


echo "summarize-set.sh done."


