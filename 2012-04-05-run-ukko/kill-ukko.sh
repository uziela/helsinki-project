#!/bin/bash

for i in `cat logs_missed/PREBS.txt | cut -f 1 -d " " | uniq` ; do
	ssh $i killall -u uziela
  #ssh $i kill -9 `ps awxu | grep uziela | grep -v sshd | grep -v "\-bash" | grep -v "ps awxu" | grep -v "grep" | grep -v "awk" | awk '{print $2}'`
  #ssh $i kill -9 `ps awxu | grep uziela | grep fastq-dump | awk '{print $2}'`
done
