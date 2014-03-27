ls all-cel/*.CEL* | wc -l
cd all-cel/
for i in `ls -1` ; do name=`echo $i | awk '{print substr($0,1,12)}'`; echo $name; done
ls
for i in `ls *.README -1` ; do name=`echo $i | awk '{print substr($0,1,12)}'`; echo $name; done
ls
ll ../all-sra/ | head
for i in `ls *.README -1` ; do name=`echo $i | awk '{print substr($0,1,12)}'`; echo $name ; ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/$name ; echo "-----------------" ; done
cd ..
ls
ls regexp2/
less regexp2/commands.txt 
less regexp2/laml4 
less regexp2/laml3
less regexp2/laml4 
less regexp2/laml3
cat regexp2/laml3 | cut -f 1 -d " " |less
cat regexp2/laml3 | cut -f 1 -d " " | sort | uniq |less
cat regexp2/laml3 | cut -f 1 -d " " | sort | uniq | wc -l
cat regexp2/laml4 | cut -f 1 -d " " | sort | uniq | wc -l
less regexp2/laml3 
vim regexp2/commands.txt 
less regexp2/laml3 
less regexp2/laml3 
ll all-sra/SRR329700.sra
ll /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2819/unknown_sample_type/TCGA-AB-2819-03A-01T-0734-13/SRX090837/SRR329700/SRR329700.sra
du -hs /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2819/unknown_sample_type/TCGA-AB-2819-03A-01T-0734-13/SRX090837/SRR329700/SRR329700.sra
ls
less unpaired_rnaseq.txt 
ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2845/unknown_sample_type/TCGA-AB-2845-03B-01T-0748-13/SRX0*/*
du -hs /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2845/unknown_sample_type/TCGA-AB-2845-03B-01T-0748-13/SRX046047/SRR122809/SRR122809.sra
ls
cd regexp2
ls
less laml3 
vim commands.txt 
cat laml3 | grep SRR1
cat laml3 | grep SRR2
cat laml3 | grep SRR3
cd ..
ls all-sra/ | head
du -h all-sra/SRR049797.sra
du -h `readlink -f all-sra/SRR049797.sra`
cd all-
cd all-sra/
for i in SRR1 ; do du -h `readlink -f $i`; done
for i in SRR1* ; do du -h `readlink -f $i`; done
for i in SRR3* ; do du -h `readlink -f $i`; done
for i in SRR3* ; do du -h `readlink -f $i`; done | cut -f 1 |less
for i in SRR3* ; do du -h `readlink -f $i`; done | cut -f 1 | grep -v "M" 
for i in SRR0* ; do du -h `readlink -f $i`; done | cut -f 1 | grep -v "G" 
for i in SRR0* ; do du -h `readlink -f $i`; done | cut -f 1 | less
cd ..
ls
cd regexp2/
ls
cat laml4 | grep SRR1 | less
cat laml3 | grep SRR1 | less
cat laml3 | grep SRR1 | cut -f 1 -d " " | less

less ../unpaired_rnaseq.txt 
cat laml3 | grep SRR1 | cut -f 1 -d " " | sort | uniq >missed-SRR1.txt
less missed-SRR1.txt 
less missed-SRR1.txt 
vim commands.txt 
ls
cp missed-SRR1.txt ..
cd ..
ls
less missed-SRR1.txt 
cd regexp2/
vim commands.txt 
rm missed-SRR1.txt 
mv ../missed-SRR1.txt .
mv ../unpaired_rnaseq.txt .
vim commands.txt 
ls
exit
ssh -Y ukko140.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
cd ..
ls
cd 2012-02-10-PREBS
ls
ls ~
ls ~/2012-04-05-run-ukko
ls ~/2012-04-05-run-ukko/logs
ls ~/2012-04-05-run-ukko/logs2
ls
ls input-LAML
ls ..
ls ../2012-02-09-mmseq
cd ../2012-02-09-mmseq
less tophat-failed.txt 
man grep
cd ..
ls
cd datasets/
ls
cd LAML
ls
less unpaired_rnaseq.txt 
ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2922/*
ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2922/*/*
ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2922/*/*/*
ls /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2922/*/*/*/*
du -hs /cs/hiit/wfa/tcga_data/LAML/23959/reads/sra/LAML/TCGA-AB-2922/*/*/*/*
ls all-cel/TCGA-AB-2922-03A-01R-0757-21.CEL 
cd regexp2/
exit
ssh -Y ukko140.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
cd ../datasets/
ls
cd LAML
ls
ls regexp2/
cd regexp2/
ls
less missed-SRR1.txt 
vim missed-SRR1.txt 
vim missed-SRR1.txt 
less laml3 
vim missed-SRR1.txt 
cat laml3 | grep -f missed-SRR1.txt | less
cat laml3 | grep "SRR1" > missed1
cat missed1 | cut -f 1 -d " " | wc -l
cat missed1 | cut -f 1 -d " " | sort | uniq | wc -l
less missed1 
cat missed1 | ./reformat.pl > missed2
less missed2 
vim missed2 
cp missed2 ../rna_dict_missed.txt
man tr
exit
top
ls
cd /cs/hiit/wfa/uziela
cd datasets/LAML/all-sra/
ls
for i in `sed -n 3p ../sra_ids_missed.temp` ; do fastq-dump --split-3 $i ; done &>../logs/fastq-dump3.log &
for i in `sed -n 4p ../sra_ids_missed.temp` ; do fastq-dump --split-3 $i ; done &>../logs/fastq-dump4.log &
ls
less ../sra_ids_missed.temp
ps awxu | grep fastq
ps awxu | grep fastq
exit
ps awxu | grep uziela
exit
ps awxu | grep uziela
exit
ps awxu | grep uziela
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
ls input-LAML-all
cd ..
cd datasets/LAML
ls
cd regexp2/
ls
vim commands.txt 
cd ..
ls
less array_dict.txt 
less array_dict_all.txt 
cat array_dict_all.txt | grep -f regexp2/missed-SRR1.txt | less
cat array_dict_all.txt | grep -f regexp2/missed-SRR1.txt > array_dict_missed.txt
less array_dict_missed.txt 
vim array_dict_missed.txt 
cd ..
ls
df -h
ls
ls scripts/
ls
ls LAML
cd LAML
R
ls
cd ..
cd ..
ls
cd 2012-02-22-PREBS-rma
ls
vim runall.sh 
cd ..
ls
cd 2012-02-10-PREBS
ls
vim runall.sh 
cd ..
ls
cd 2012-02-09-mmseq
ls
vim run_mmseq_new.sh 
cd ..
ls
cd 2012-02-10-PREBS
vim runall.sh 
cd ..
ls
cd 2012-02-22-PREBS-rma
ls
vim runall.sh 
vim scripts/PREBS_RMA_save.R 
cd ..
ls
cd 2012-02-09-mmseq
ls
vim make-soft-links.sh 
./make-soft-links.sh 
./make-soft-links.sh input-LAML-missed ../datasets/LAML ../datasets/LAML/rna_dict_missed.txt 
ls
ls input-LAML-missed/
ls input-LAML-missed/ | wc -l
ls input-LAML-missed/*
cd ..
ls
cd datasets/
ls
cd LAML
ls
cd ..
ls
vim fastq-dump.sh 
cd LAML
ls
ls regexp2/
ls regexp2/missed-SRR1.txt 
less regexp2/missed1 
less sra_ids.temp 
less sra_ids.temp 
cut -f 2 -d " " regexp2/missed1 | less
cut -f 2 -d " " regexp2/missed1 | tr "\n" " " | less
cut -f 2 -d " " regexp2/missed1 | tr "\n" " " > ./sra_ids_missed.temp 
vim sra_ids_missed.temp 
ls logs/
cd logs/
mkdir old-fastqdump
mv fastq-dump* old-fastqdump/
cd ..
ls
ca all-sra/
cd all-sra/
ls *.fastq
ls *.fastq*
for i in `sed -n 1p ../sra_ids_missed.temp` ; do fastq-dump --split-3 $i ; done &>../logs/fastq-dump1.log &
for i in `sed -n 2p ../sra_ids_missed.temp` ; do fastq-dump --split-3 $i ; done &>../logs/fastq-dump2.log &
top
ls
ps awxu | grep fastq
ps awxu | grep fastq
cd ..
cd ..
cd ..
ls
cd 2012-02-09-mmseq
ls
rm -r input-LAML-missed
./make-soft-links.sh input-LAML-missed ../datasets/LAML ../datasets/LAML/rna_dict_missed.txt 
ls input-LAML-missed/*
ls
vim run_LAML_ukko.sh 
cd ..
ls
cd 2012-02-10-PREBS
ls
vim run_LAML_nogap_ukko.sh 
ln -s ../2012-02-09-mmseq/input-LAML-missed .
ls
ssh -Y ukko066.hpc.cs.helsinki.fi
ssh -Y ukko075.hpc.cs.helsinki.fi
ls
cd ..
ls
cd 2012-02-09-mmseq
ls
ssh -Y ukko066.hpc.cs.helsinki.fi
exit
ssh -Y ukko140.hpc.cs.helsinki.fi
exit
ssh -Y ukko140.hpc.cs.helsinki.fi
ssh -Y ukko190.hpc.cs.helsinki.fi
ls
cd 2012-04-05-run-ukko
ls
ls
vim run_stuff_on_ukko.py 
ls
vim LAML_MMSEQ_and_PREBS_ukko.sh 
vim LAML_MMSEQ_and_PREBS_ukko.sh 
ls
vim run_stuff_on_ukko.py 
./run_stuff_on_ukko.py 
ls
vim run_stuff_on_ukko.py 
vim run_stuff_on_ukko.py 
vim logs_ratios/PREBS.txt
vim kill-ukko.sh 
ls
vim LAML_MMSEQ_and_PREBS_ukko.sh 
vim run_stuff_on_ukko.py 
vim LAML_MMSEQ_and_PREBS_ukko.sh 
ls ~
ls ~/logs-missed/
rm -r ~/logs-missed/
ls
mkdir logs-missed
ls
vim LAML_MMSEQ_and_PREBS_ukko.sh 
vim run_stuff_on_ukko.py 
./run_stuff_on_ukko.py 
vim logs-missed/logs-missed.txt
exit
ps awxu | grep fastq
exit
ps awxu | grep uziela
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
cd ..
ls
cd 2012-02-09-mmseq
ls
vim run_mmseq_new.sh
ls input-LAML-missed/TCGA-AB-2949
ls input-LAML-missed/TCGA-AB-2909
ssh -Y ukko066.hpc.cs.helsinki.fi
ssh -Y ukko180.hpc.cs.helsinki.fi
exit
ssh -Y ukko190.hpc.cs.helsinki.fi
exit
ls
cd 2012-04-05-run-ukko
ls logs
ls
ls logs-missed/
less logsLAML-MMSEQ.2013-09-03.ukko066.8610.err
less logs/LAML-MMSEQ.2013-09-03.ukko066.8610.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko066.8610.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko066.8610.log 
less logs-missed/LAML-MMSEQ.2013-09-03.ukko066.8610.log 
cat logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err |less
cat logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err | grep -v "Exhausted" |less
ls logs-missed/*.err | wc -l
ls logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err | wc -l
cat logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err | grep -v "Exhausted" |less
cat logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err | grep -v "Exhausted" | grep "Now run" | wc -l
ls logs-missed/LAML-MMSEQ.2013-09-03.ukko*.err
ls logs-missed/LAML-PREBS.2013-09-03.ukko*.err
ls logs-missed/*21056*
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.log 
kess logs-missed/LAML-MMSEQ.2013-09-03.ukko145.16265.log
less logs-missed/LAML-MMSEQ.2013-09-03.ukko145.16265.log
less logs-missed/LAML-MMSEQ.2013-09-03.ukko145.16265.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.err
ls
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.log 
ls logs-missed/
less logs-missed/LAML-PREBS.2013-09-03.ukko179.9299.err
cat logs-missed/LAML-PREBS.2013-09-03.ukko*.err
cat logs-missed/LAML-PREBS.2013-09-03.ukko*.err | grep -v "Encountered reference" | less
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.log 
ls
ls
ls logs-missed/
less logs-missed/LAML-MMSEQ.2013-09-03.ukko075.21056.log 
vim run_stuff_on_ukko.py 
./run_stuff_on_ukko.py 
vim logs-missed/logs-missed.txt 
ls logs-missed/
less logs-missed/LAML-MMSEQ.2013-09-04.ukko180.394.err
less logs-missed/LAML-MMSEQ.2013-09-04.ukko180.394.log 
exit
ls
cd 2012-04-05-run-ukko
ls
ls logs-missed/
ls logs-missed/LAML-PREBS.2013-09-0*.log | wc -l
cat logs-missed/LAML-PREBS.2013-09-0*.err | less
cat logs-missed/LAML-PREBS.2013-09-0*.err | grep -v "Encountered" |less
cat logs-missed/LAML-PREBS.2013-09-0*.log | grep "done." |less
cat logs-missed/LAML-PREBS.2013-09-0*.log | grep "done." |wc -l
exit
ps awxu | grep uziela
exit
ls
ls
cd 2012-04-05-run-ukko
ls
cat logs-missed/LAML-PREBS.2013-09-0*.log | grep "done."
cat logs-missed/LAML-PREBS.2013-09-0*.log | grep "done." | wc -l
for i in logs-missed/LAML-PREBS.2013-09-0*.log ; do cat $i | grep "done."; done
for i in logs-missed/LAML-PREBS.2013-09-0*.log ; do echo $i ; cat $i | grep "done."; done
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ssh -Y ukko087.hpc.cs.helsinki.fi
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
ls
ls
cd ..
ls
cd 2012-02-09-mmseq
ls
cat tophat-failed.txt 
cd
ls
cd 2012-04-05-run-ukko
ls
for i in logs-missed/*.err ; do echo $i; cat $i | grep -i "err"; done
less logs-missed/LAML-PREBS.2013-09-03.ukko170.6706.err
less logs-missed/LAML-PREBS.2013-09-03.ukko170.6706.log 
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
cd ..
ls
cd 2012-02-09-mmseq
ls
vim tophat-failed.txt 
exit
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ssh -Y ukko087.hpc.cs.helsinki.fi
ssh -Y ukko190.hpc.cs.helsinki.fi
exit
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
exit
ps awxu | grep uziela
exit
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ssh -Y ukko087.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
ls
vim run_cor_table_plot.sh 
vim combine_stats.sh 
ls
ps awxu | grep uziela
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
vim combine_stats.sh 
vim scripts/combine-stats.R 
ls
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-60
ls output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_stats.csv
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_stats.csv
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_stats.csv
ls scripts/
vim scripts/PREBS_stats.R
ls output_LAML_all/output_LAML_all-basic-0-60/tables/
ls output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_data.csv
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_data.csv
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_data.csv 
less output_LAML_all/output_LAML_all-basic-0-60/tables/prebs_log2fc_data.csv 
exit
ssh -Y ukko190.hpc.cs.helsinki.fi
exit
ssh -Y ukko190.hpc.cs.helsinki.fi
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
exit
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
exit
ls
ps awxu | grep uziela
exit
ssh -Y ukko087.hpc.cs.helsinki.fi
exit
exit
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ssh -Y ukko087.hpc.cs.helsinki.fi
ls
cd
exit
top
top
exit
ls
cd 2012-04-05-run-ukko
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
ssh -Y ukko087.hpc.cs.helsinki.fi
exit
ls
exit
ls
ls karolis_uziela/
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ssh -Y ukko087.hpc.cs.helsinki.fi
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
cd ..
ls
cd 2012-02-10-PREBS
ls
ls input-LAML-all
ll input-LAML-all
cd ..
ls
cd 2012-02-09-mmseq
l;s
ls
ls input-LAML-all/
ll input-LAML-all/TCGA-AB-2803
ls input-LAML-81-153
ls input-LAML-22-80
ls
vim tophat-failed.txt 
:wq
ls input-LAML-missed/TCGA-AB-2982
mkdir LAML-missed-failed
mv input-LAML-missed/TCGA-AB-2982 LAML-missed-failed
mv LAML-missed-failed input-LAML-missed-failed
mv input-LAML-missed/TCGA-AB-2988 input-LAML-missed-failed
ls input-LAML-missed-failed
ls
ll input-LAML-all/TCGA-AB-2877
cd input-LAML-all/
for i in ../input-LAML-missed/* ; do echo ln -s $i .; done
for i in ../input-LAML-missed/* ; do ln -s $i .; done
ls TCGA-AB-2845
ll TCGA-AB-2845
cd ..
ls
cd ..
ls
cd 2012-02-10-PREBS
cd ..
ls
ls 2012-02-22-PREBS-rma
ls 2012-02-22-PREBS-rma-ukko
ls 2012-02-22-PREBS-rma-ukko/scripts/PREBS_stats.R
vim 2012-02-22-PREBS-rma-ukko/scripts/PREBS_stats.R
diff 2012-02-22-PREBS-rma-ukko/scripts/PREBS_stats.R 2012-02-22-PREBS-rma/scripts/PREBS_stats.R
vim 2012-02-22-PREBS-rma-ukko/scripts/PREBS_stats.R
ls
ls 2012-02-22-PREBS-rma
vim 2012-02-22-PREBS-rma/runall.sh 
vim 2012-02-22-PREBS-rma-ukko/runall.sh 
vim 2012-02-22-PREBS-rma-ukko/runall.sh 
vim 2012-02-22-PREBS-rma/runall.sh 
ls 2012-02-22-PREBS-rma
ls 2012-02-22-PREBS-rma-ukko
ls 2012-02-22-PREBS-rma/combine_stats.sh 
vim 2012-02-22-PREBS-rma/combine_stats.sh 
ls
ls
cd 2012-02-22-PREBS-rma
ls
vim combine_stats.sh 
ls output_LAML_all/output_LAML_all-basic/
vim combine_stats.sh 
ls
vim run_many_ukko.sh 
vim run_many_ukko2.sh 
mv output_LAML_all output_LAML_all_without_missed
exit
ls
cd /cs/hiit/wfa/uziela/
vim 2012-02-22-PREBS-rma/scripts/PREBS_stats.R
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
./run_many_ukko2.sh 
vim run_retrieval.sh 
ls
vim scripts/PREBS_stats.R
ls output_LAML_all
ls output_LAML_all/output_LAML_all-cross-diff-0-60
R
ls
ls input-LAML-all/*/probe_counts.RData | wc -l
for i in input-LAML-all/* ; do ls $i/probe_counts.RData; done
ls input-LAML-all/TCGA-AB-2888
cd ..
ls
cd 2012-02-09-mmseq
ls
ls input-LAML-missed-failed/
ls input-LAML-missed-failed/TCGA-AB-2988
mv input-LAML-missed-failed/TCGA-AB-2988 input-LAML-missed
mv input-LAML-missed/TCGA-AB-2888 input-LAML-missed-failed/
ls input-LAML-missed-failed/
ls input-LAML-missed-failed/TCGA-AB-2982
ls input-LAML-missed-failed/TCGA-AB-2888
ls input-LAML-all/
rm input-LAML-all/TCGA-AB-2888
cd input-LAML-all/
ln -s ../input-LAML-missed/TCGA-AB-2988 .
ls | wc -l
cd ..
top
ls
cd ..
ls
cd 2012-02-22-PREBS-rma
ls
ls output_LAML_all
rm -r output_LAML_all
rm logs/*.err logs/*.log
ls
exit
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
vim run_many_ukko.sh 
ls logs/
cd logs/
mkdir old
mv * old
cd ..
ls
./run_many_ukko.sh 
less logs/basic60.err 
less logs/basic60.log 
less logs/basic60.err 
ls input-LAML-all
ls input-LAML-all | wc -l
less logs/basic60.err 
less logs/basic60.log 
ps awxu | grep uziela
ls
ls ..
less ../2012-02-09-mmseq/tophat-failed.txt 
less logs/basic60.log 
less logs/basic60.log 
less logs/basic60.err 
less logs/basic60.err 
less logs/basic60.err 
less logs/basic50.err 
less logs/basic40.err 
less logs/basic30.err 
less logs/basic20.err 
less logs/basic10.err 
ls
ls input-LAML-all/ | wc -l
vim runall.sh 
top
exit
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
./run_many_ukko.sh
ps awxu | grep uziela
less logs/basic60.err 
exit
ls
ssh -Y ukko087.hpc.cs.helsinki.fi
ssh -Y ukko087.hpc.cs.helsinki.fi
ssh -Y ukko073.hpc.cs.helsinki.fi
ssh -Y ukko066.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
./run_many_ukko2.sh
exit
ssh -Y ukko190.hpc.cs.helsinki.fi
ssh -Y ukko026.hpc.cs.helsinki.fi
ssh -Y ukko081.hpc.cs.helsinki.fi
exit
ls
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
ls scripts/
vim runall.sh 
vim ./scripts/PREBS_RMA_save.R
exit
ls
cd 2012-04-05-run-ukko
ls
for i in logs-missed/*.err ; do echo $i; cat $i | grep -i "err"; done
less logs-missed/LAML-MMSEQ.2013-09-03.ukko087.26599.err
less logs-missed/LAML-MMSEQ.2013-09-03.ukko087.26599.log 
for i in logs-missed/LAML-PREBS.2013-09-0*.log ; do echo $i ; cat $i | grep "done."; done
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.log
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.log
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.err 
less logs-missed/LAML-PREBS.2013-09-03.ukko087.26599.log 
ssh -Y ukko180.hpc.cs.helsinki.fi
ls
vim retrieval_ukko.sh 
vim run_stuff_on_ukko.py 
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls output_LAML_all
nh logs/basic50 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-50 HGU133Plus2_Hs_ENSG BASIC 50 0"
nh logs/basic60 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-60 HGU133Plus2_Hs_ENSG BASIC 60 0"
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
nh logs/cross-diff10 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-10 HGU133Plus2_Hs_ENSG CROSS_DIFF 10 0"
nh logs/cross-diff30 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-30 HGU133Plus2_Hs_ENSG CROSS_DIFF 30 0"
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
nh logs/cross-diff40 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-40 HGU133Plus2_Hs_ENSG CROSS_DIFF 40 0"
nh logs/cross-diff50 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-50 HGU133Plus2_Hs_ENSG CROSS_DIFF 50 0"
exit
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
nh logs/cross-diff60 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-cross-diff-0-60 HGU133Plus2_Hs_ENSG CROSS_DIFF 60 0"
exit
ls
cd /cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/
ls
ls output_retrieval_LAML_all
ls output_retrieval_LAML_all | wc -l
ls output_retrieval_LAML_all_bak2/ | wc -l
ls output_retrieval_LAML_all_bak2/ | wc -l
ls output_retrieval_LAML_all | wc -l
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
ssh -Y ukko057.hpc.cs.helsinki.fi
ssh -Y ukko157.hpc.cs.helsinki.fi
ssh -Y ukko192.hpc.cs.helsinki.fi
ssh -Y ukko086.hpc.cs.helsinki.fi
ls
cd 2012-04-05-run-ukko
vim run_stuff_on_ukko.py 
vim retrieval_ukko.sh 
./run_stuff_on_ukko.py 
ls logs
less logs/retrieval.2013-06-28.ukko014.12238.err
less logs/retrieval.2013-06-28.ukko014.12238.log 
less logs/retrieval.2013-10-01.ukko192.17736.log
less logs/retrieval.2013-10-01.ukko192.17736.log
less logs/retrieval.2013-10-01.ukko137.20702.log
less logs/retrieval.2013-06-28.ukko032.11422.log 
less logs/retrieval.2013-10-01.ukko192.17736.log
less logs/retrieval.2013-10-01.ukko061.28589.log 
less logs/retrieval.2013-10-01.ukko109.10089.log
exit
ls
ps awxu | grep uziela
cd 2012-04-05-run-ukko
ls
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
less logs/basic60.err 
less logs/basic50.err 
less logs/basic40.err 
less logs/basic30.err 
less logs/basic20.err 
less logs/basic10.err 
less logs/basic10.log 
ls
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10
ls output_LAML_all/output_LAML_all-basic-0-10
ls output_LAML_all/output_LAML_all-basic-0-10/plots
eog output_LAML_all/output_LAML_all-basic-0-10/plots/TCGA-AB-2830_RPKM_vs_array
eog output_LAML_all/output_LAML_all-basic-0-10/tables/
ls output_LAML_all/output_LAML_all-basic-0-10/tables/
ls output_LAML_all/output_LAML_all-basic-0-10/
w3m output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_stats.html 
lynx output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_stats.html 
lynx output_LAML_all_without_missed/output_LAML_all-basic-0-10/tables/
ls output_LAML_all_without_missed/output_LAML_all-basic-0-10/tables/
ls output_LAML_all_without_missed/output_LAML_all-basic-0-10/
lynx output_LAML_all/output_LAML_all-basic-0-10/all_tables.html 
ls
for i in logs/*.err ; do grep -i "err" $i; done
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
ls
ls output_LAML_all
ls
cd output_LAML_all
ls
rm -r output_LAML_all-basic-0-30 output_LAML_all-basic-0-40 output_LAML_all-basic-0-50 output_LAML_all-basic-0-60 output_LAML_all-cross-diff-0-10 output_LAML_all-cross-diff-0-30 output_LAML_all-cross-diff-0-40 output_LAML_all-cross-diff-0-50 output_LAML_all-cross-diff-0-60
ls
cd ..
ls
top
ls
vim run_many_ukko.sh 
nh logs/basic30 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-30 HGU133Plus2_Hs_ENSG BASIC 30 0"
vim run_many_ukko.sh 
ls output_LAML_all
nh logs/basic40 "./runall.sh input-LAML-all ../datasets/LAML output_LAML_all/output_LAML_all-basic-0-40 HGU133Plus2_Hs_ENSG BASIC 40 0"
vim run_many_ukko.sh 
vim run_many_ukko2.sh 
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
vim run_retrieval.sh 
ls
ls output_LAML_all-basic-0-60-paper
vim run_retrieval.sh 
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10
vim run_retrieval.sh 
vim run_retrieval.sh 
ls
mv output_retrieval_LAML_all output_retrieval_LAML_all_bak2
mkdir output_retrieval_LAML_all
vim run_retrieval.sh 
ls logs/
vim run_retrieval.sh 
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
less logs/cross-diff40.err
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
exit
ls
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
ls output_LAML_all
ls
ls output_LAML_all-basic-0-60-paper
ls output_LAML_all-basic-0-60-paper/plot-data/
l;s
ls
cp output_retrieval_LAML_all/retrieval/retrieval.csv ~/copy/
ls
mv output_LAML_all-basic-0-60-paper output_LAML_all-basic-0-60-paper_bak
ls output_LAML_all-basic-0-60-paper_bak
cp -r output_LAML_all/output_LAML_all-basic-0-60 LAML-basic-0-60-paper
ls
mv LAML-basic-0-60-paper output_LAML_all-basic-0-60-paper
vim combine_stats.sh 
./combine_stats.sh 
ls output_LAML_all-basic-0-60-paper/plot-data/
ls output_LAML_all-basic-0-60-paper/
ls scripts/
ls
ls input-LAML-all
ls input-LAML-all/TCGA-AB-2803
ls output_LAML_all-basic-0-60-paper
ls output_LAML_all-basic-0-60-paper/tables/
ls
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10
ls output_LAML_all/output_LAML_all-basic-0-10/tables/
./combine_stats.sh 
ls
ls ~/copy/
ls
cp output_LAML_all-basic-0-60-paper/correlation-scatter-plot/ ~/copy/
cp -r output_LAML_all-basic-0-60-paper/correlation-scatter-plot/ ~/copy/
ls ~/copy/
ls
ls ~/copy
ls
scp output_LAML_all-basic-0-60-paper/plot-data/ /cs/fs2/home/uziela/copy/
scp -r output_LAML_all-basic-0-60-paper/plot-data/ /cs/fs2/home/uziela/copy/
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
ls
cd /cs/hiit/wfa/uziela/
ls
ls
cd 2012-02-22-PREBS-rma-ukko
cd ..
cd 2012-02-22-PREBS-rma
for i in logs/*.log ; do echo $i ; grep -i "done." $i; echo "===============================" ; done
for i in logs/*.err ; do echo $i ; grep -i "err" $i; echo "===============================" ; done
ls
ls output_retrieval_LAML_all | wc -l
ls output_retrieval_LAML_all_bak | wc -l
ls output_retrieval_LAML_all_bak 
ls output_retrieval_LAML_all_bak/retrieval/
less output_retrieval_LAML_all_bak/retrieval/retrieval.csv 
ls
cd output_retrieval_LAML_all
mkdir retrieval
cat *.csv > retrieval/retrieval.csv
less retrieval/retrieval.csv 
cd ..
vim combine_stats.sh 
vim combine_stats.sh 
exit
ls
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
ls
ls
cd /cs/hiit/wfa/uziela/
ssh -Y ukko089.hpc.cs.helsinki.fi
ls
ls .ssh/
less .ssh/authorized_keys 
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
ls
exit
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
ls
cd 2012-04-05-run-ukko
ls
vim LAML_MMSEQ_ukko.sh
exit
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
vim runall.sh 
vim run_cor_table_plot.sh 
ls scripts/
vim scripts/PREBS_stats.R
cd scripts/
grep -r "absolute_stats.RData" .
cd ..
grep -r "absolute_stats.RData" .
grep -r "absolute_stats.RData" ./*.sh
vim scripts/combine-stats.R 
ls output_retrieval_LAML_all
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10/
ls output_LAML_all/output_LAML_all-basic-0-10/plot-data/
ls output_LAML_all/output_LAML_all-basic-0-10/tables
less output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv
less output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv
less output_LAML_all/
ls output_LAML_all/
ls
vim combine_stats.sh 
vim scripts/combine-stats.R 
vim scripts/stderr.R
vim ~/.screenrc
screen
exit
ls
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
ls
ssh -Y ukko089.hpc.cs.helsinki.fi
ls
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10/tables/
ls output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv 
vim test.table 
vim test.table 
./scripts/stderr.R output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv test.table 
less test.table 
less test.table 
./scripts/stderr.R output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv test.table 
less test.table 
./scripts/stderr.R output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv test.table 
less test.table 
ls
cp combine_stats.sh combine_stderr.sh 
vim combine_stderr.sh 
./combine_stats.sh 
./combine_stderr.sh 
ls
ls output_LAML_all-basic-0-60-paper/plot-data/
R
vim combine_stderr.sh 
screen
vim combine_stderr.sh 
vim combine_stderr.sh 
./combine_stderr.sh 
ls plot-data/Marioni-basic-0-60-paper/
ls plot-data/Marioni-basic-0-60-paper/plot-data/
R
ls ~/copy/
mv ~/copy/plot-data/ ~/copy/plot-data-old
mkdir ~/copy/plot-data/
ls
cp -r output_LAML_all-basic-0-60-paper/ ~/copy/plot-data
du -hs output_LAML_all-basic-0-60-paper
du -hs plot-data/Marioni-basic-0-60-paper/
cp -r plot-data/Marioni-basic-0-60-paper/ ~/copy/plot-data
exit
vim combine_stats.sh 
./combine_stderr.sh 
ls
ls output_LAML_all-basic-0-60-paper/
ls output_LAML_all-basic-0-60-paper/plot-data/
R
ls
ls output-intersect/
ls
ls plot-data/
ls plot-data/Marioni-basic-0-60-paper/
exit
screen
R
vim scripts/combine-stats.R 
vim scripts/stderr.R 
vim scripts/stderr.R 
./combine_stderr.sh 
ls output_LAML_all/output_LAML_all-basic-0-10/tables/
cat output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_stderr.csv 
cat test.table 
exit
screen
vim scripts/stderr.R 
chmod a+x scripts/stderr.R 
./scripts/stderr.R "output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv" test.table
vim scripts/stderr.R 
./scripts/stderr.R "output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv" test.table
vim scripts/stderr.R 
./scripts/stderr.R "output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv" test.table
vim scripts/stderr.R 
./scripts/stderr.R "output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_data.csv" test.table
less test.table 
vim scripts/stderr.R 
vim scripts/stderr.R 
vim combine_stats.sh 
vim scripts/combine-stats.R 
less "output_LAML_all/output_LAML_all-basic-0-10/tables/prebs_stats.csv"
ls
ls ..
ls ../2012-02-22-PREBS-rma-ukko
ls
ls ../2012-02-22-PREBS-rma-ukko/output
ls output_LAML_all
vim combine_stderr.sh 
exit
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
ls output_LAML_all
ls output_LAML_all/output_LAML_all-basic-0-10/plot-data
vim runall.sh 
vim scripts/PREBS_stats
vim scripts/PREBS_stats.R
ls output_LAML_all-basic-0-60-paper/plot-data/
ls output_LAML_all-basic-0-60-paper/tables
ls output_LAML_all-basic-0-60-paper/tables/prebs_log2fc_data.csv 
ls output-intersect/Marioni-basic-0-10/tables/prebs_log2fc_data.csv 
ls output-intersect/Marioni-basic-0-10/tables/
vim combine_stderr.sh 
screen -ls
screen -r
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
ls
cd /cs/hiit/wfa/uziela/
ls
cd datasets/
ls
cd LAML
ls
ls all-sra/ | head
ls all-cel/ | head
ls all-cel/*.CEL* | wc -l
ls all-cel/*.CEL | wc -l
exit
ssh -Y ukko089.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/
ls
exit
ls
less string3-20140312 
less string3-20140312 
ssh -Y ukko089.hpc.cs.helsinki.fi
ssh -Y ukko192.hpc.cs.helsinki.fi
ls
less string3-20140312 
ssh -Y ukko192.hpc.cs.helsinki.fi
less string3-20140312 
ssh -Y ukko192.hpc.cs.helsinki.fi
cd /cs/hiit/wfa/uziela/
ssh ukko167.hpc.cs.helsinki.fi
exit
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
ls scripts/
vim scripts/figure1.R 
exit
ssh ukko167.hpc.cs.helsinki.fi
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk '{print $4,$8}'
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk '{print $4,$8}' |less
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($4-$8)}'
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($4-$8)}' |less
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {if (abs($4-$8)<25) }' |less
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($4-$8) }' |less
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {if (abs($4-$8) - 51 < 25){print $0} }' |less
samtools view input-LAML-all/TCGA-AB-2835/tophat/accepted_hits.bam | awk 'function abs(x){return ((x < 0.0) ? -x : x)} {if (abs($4-$8) - 51 < 25){print $0} }' > test-manuela/TCGA-AB-2835-close-mapped.sam
du -hs test-manuela/TCGA-AB-2835-close-mapped.sam
samtools -view -H input-LAML-all/TCGA-AB-2835/tophat/accepted_hits.bam > test-manuela/TCGA-AB-2835-head.sam
samtools view -H input-LAML-all/TCGA-AB-2835/tophat/accepted_hits.bam > test-manuela/TCGA-AB-2835-head.sam
less ~/.inputrc 
less ~/.inputrc 
exit
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
ls input-LAML-all
ls input-LAML-all/TCGA-AB-2803
ls input-LAML-all/*/*.bam
ls input-LAML-all/TCGA-AB-2835/tophat/
samtools view input-LAML-all/TCGA-AB-2835/tophat/accepted_hits.bam 
samtools view input-LAML-all/TCGA-AB-2835/tophat/accepted_hits.bam |less
screen
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam |less
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam |less
ls
samtools view input-LAML-all/TCGA-AB-2835/TCGA-AB-2835.namesorted.bam |less
exit
exit
ls
screen
screen
exit
ssh ukko167.hpc.cs.helsinki.fi
exit
screen -r
exit
ssh ukko167.hpc.cs.helsinki.fi
exit
ls
cd /cs/hiit/wfa/uziela/
ls
cd 2012-02-22-PREBS-rma
ls
screen
R
cd test-manuela/
R
exit
exit
screen -ls
screen
exit
ssh ukko154.hpc.cs.helsinki.fi
exit
cd ..
cd ..
ls
cd datasets/
ls
cd Marioni
ls
ls all-cel/
mkdir test-cel
cp all-cel/GSM279060.CEL test-cel
ls
screen
R
exit
ls
ls ..
ls ../scripts/
vim ../scripts/array_expr.R
ls
vim ../runall.sh 
vim ../runall.sh 
vim ../scripts/array_expr.R
exit
screen -r
exit
ls
ssh ukko167.hpc.cs.helsinki.fi
exit
ls
ls ~/.ssh/
vim ~/.ssh/authorized_keys 
exit
exit
screen -r
exot
exit
ssh ukko167.hpc.cs.helsinki.fi
exit
cd /cs/hiit/wfa/uziela/
ls
ls
screen -r
exit
ssh ukko167.hpc.cs.helsinki.fi
exit
