#! /bin/sh

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/logs/pol2rnaseq_dic.$MYDATE.$MYHOST.$$"

cd $HOME/mlprojects/pol2rnaseq/matlab

unset DISPLAY

echo run_dic.sh $* > ${LOGSTEM}.out
date >> ${LOGSTEM}.out

matlab -nodisplay -singleCompThread -r "myI = $1; compute_dics; quit" >> ${LOGSTEM}.out 2> ${LOGSTEM}.err

date >> ${LOGSTEM}.out

echo "run_dic.sh $* done" | cat - ${LOGSTEM}.err | mail -s 'Ukko report (run_dic)' ahonkela@cs.helsinki.fi
