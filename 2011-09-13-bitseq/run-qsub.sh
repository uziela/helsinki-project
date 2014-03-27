#!/bin/sh

current='/share/work/uziela/2011-09-13-sampler'
#for i in $current/input-marioni/*/*.sra ; do
#	base=`basename $i`
#	qsub -N mmseq -e $current/logs/$base.log -o $current/logs/$base.err -l mem=8G,t=24:0:0 $current/run-mmseq.sh $i $current/human_genome/Homo_sapiens.GRCh37.63.cdna.all.fa
	
#done

i="$current/input/GM06985/SRR032238.sra"
base=`basename $i`
qsub -N sampler -e $current/logs/$base.log -o $current/logs/$base.err -l mem=8G,t=24:0:0 $current/run-sampler.sh $i $current/human_genome/human_1.fa
