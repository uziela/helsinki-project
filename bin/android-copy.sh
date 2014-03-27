#!/bin/bash

# Written by Karolis Uziela in 2013

if [ $# != 2 ] ; then
    echo "
Usage: 

$0 <input-file> <target-dir>

<input-file> must contain files and directories on local PC to be copied to Android (one per line). 
<target-dir> is the target directory on Android

"
    exit 1
fi

input_file=$1
target_dir=$2

#dirs=`cat $input_file`

#scp -r -P 2222 $dirs root@192.168.1.5:/mnt/sdcard/$target_dir

while read p; do
    scp -r -P 2222 "$p" root@192.168.1.5:/mnt/sdcard/$target_dir
done < $input_file

