#!/bin/sh

current=`pwd`
mkdir bitseq-transcripts
cd input
for i in * ; do
	mkdir ../bitseq-transcripts/$i
	for j in $i/*.mean.transcripts ; do
		cp $j ../bitseq-transcripts/$i
	done
done
	
cd $current
