# name of the job
#$ -N sampler
# ... for error logs
#$ -e /share/work/uziela/2011-09-13-sampler/logs/sampler.err
# ... and for standard output
#$ -o /share/work/uziela/2011-09-13-sampler/logs/sampler.log

current='/share/work/uziela/2011-09-13-sampler'
$current/runall.sh $current/input/GM06985/SRR032238.sra $current/input/GM06993/SRR032239.sra $current/human_genome/human_1.fa output
