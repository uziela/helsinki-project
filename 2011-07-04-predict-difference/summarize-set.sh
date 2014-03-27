#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 2 ] ; then
	echo "
Usage: 

./summarize-set.sh [Parameters]

Parameters:
<run-name> - run name which was used in run-set.sh
<target> - what was the target feature?

"
	exit 1
fi

run_name=$1;
target=$2;


# print parameters
echo "summarize-set.sh has started with parameters: $*"

if [ -d ./output-set/"$run_name" ] ; then
rm -r ./output-set/"$run_name"
fi

out_dir="./output-set/$run_name";
mkdir $out_dir

# calculate original pval correlation ("correlation to improve")
if [ $target = 'adj.P.Val' ] || [ $target = 'padj' ] ; then
	cut -d ' ' -f 1 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/targetp.stat
	cut -d ' ' -f 4 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/trainp1.stat
	cut -d ':' -f 2 $out_dir/trainp1.stat > $out_dir/trainp2.stat
	./scripts/corrcoef $out_dir/targetp.stat $out_dir/trainp2.stat > $out_dir/pval.corr
	corr_to_improve=`cat $out_dir/pval.corr | grep Correlation | perl -pe 's/Correlation: //'`
	corr_to_improve_sp=`cat $out_dir/pval.corr | grep "Spearman correlation:" | perl -pe 's/Spearman correlation: //'`
fi

if [ $target = 'logFC' ] ; then
	cut -d ' ' -f 1 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/targetlog.stat
	cut -d ' ' -f 3 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/trainlog1.stat
	cut -d ':' -f 2 $out_dir/trainlog1.stat > $out_dir/trainlog2.stat
	./scripts/corrcoef $out_dir/targetlog.stat $out_dir/trainlog2.stat > $out_dir/log.corr
	corr_to_improve=`cat $out_dir/log.corr | grep Correlation | perl -pe 's/Correlation: //'`
	corr_to_improve_sp=`cat $out_dir/log.corr | grep "Spearman correlation:" | perl -pe 's/Spearman correlation: //'`
fi

if [ $target = 'log2FoldChange' ] ; then
	cut -d ' ' -f 1 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/targetlog.stat
	cut -d ' ' -f 2 ./output/"$run_name"01/"$run_name"01.svm > $out_dir/trainlog1.stat
	cut -d ':' -f 2 $out_dir/trainlog1.stat > $out_dir/trainlog2.stat
	./scripts/corrcoef $out_dir/targetlog.stat $out_dir/trainlog2.stat > $out_dir/log.corr
	corr_to_improve=`cat $out_dir/log.corr | grep Correlation | perl -pe 's/Correlation: //'`
	corr_to_improve_sp=`cat $out_dir/log.corr | grep "Spearman correlation:" | perl -pe 's/Spearman correlation: //'`
fi

# create html table
cat ./output/"$run_name"[0-9]*/"$run_name"*.sum > $out_dir/"$run_name".sum
./scripts/create-table.pl $out_dir/"$run_name".sum $out_dir/"$run_name".html 5 $corr_to_improve 0
./scripts/create-table.pl $out_dir/"$run_name".sum $out_dir/"$run_name"_spearman.html 5 $corr_to_improve_sp 1

# convert .ps files to .png
for i in ./output/"$run_name"[0-9]*/"$run_name"*.ps ; do
	convert $i $out_dir/`basename $i .ps`.png
done

echo "summarize-set.sh done."


