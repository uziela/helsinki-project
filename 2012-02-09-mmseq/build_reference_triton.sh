#! /bin/sh
#SBATCH --time=0-04:00:00 --mem-per-cpu=4000
#SBATCH -p short

cd /triton/ics/scratch/uzielak1/2012-02-09-mmseq
srun ./build_reference.sh ./ref_transcriptome/Homo_sapiens.GRCh37.65.cdna.all.fa FALSE
