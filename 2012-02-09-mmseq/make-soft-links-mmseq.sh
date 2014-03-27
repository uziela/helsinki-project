#!/bin/sh

if [ $# != 2 ] ; then
	echo "
Usage: 

./make-soft-links.sh [Parameters]

Parameters:
<source_dir>
<dest_dir>
"
	exit 1
fi

source=$1
dest=$2
current=`pwd`

for i in $source/* ; do
	SAMPLE=`basename $i`
	ln -s $current/$source/$SAMPLE/*.mmseq $current/$dest/$SAMPLE/
done
