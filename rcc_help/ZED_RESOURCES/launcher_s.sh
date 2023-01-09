#!/bin/bash

PROG=""
RSTR=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20  | head -n 1 | cut -c 1-6`
JOBN=IXC"$RSTR"
TIME=10
NCOR=28
MEMR=10
NODE=1
EXECUTE=0
DEPEND=""
CDIR=`pwd`
DRY_RUN=0
ANYDEPEND=""
PART='sandyb'
PROGFILE=0
CREATEDEPFILE=1
FORWARD_DEP=''

afterok='afterok'

while getopts ":P:J:T:N:C:M:D:A:d:p:X:Y:hF" opt
do
    case $opt in
	h)
	    echo '===> SLURM LAUNCHER <=== copyright ishanu@uchicago.edu 2017'
	    echo OPTIONS:
	    echo -P : program string: use single or  quoates
	    echo -F : interpret program as file
	    echo -X : log dependency graphviz style in filename jobid.depx
	    echo -p : partition to target
	    echo -J : jobname
	    echo -C : number of cores on 1 node
	    echo -T : time in hours
	    echo -N : Number of nodes
	    echo -M : memory gb allocated
	    echo -D : string of job dependecies: ids sep by space: use single or double quotes 
	    echo -A : string of afterany job dependecies: ids sep by space: use single or double quotes 
	    echo -d : dry-run
	    echo -Y : forward dep string sep by space
	    echo '============================'
	    exit 1;;
	F)
	    PROGFILE=1;;
	X)
	    CREATEDEPFILE=$OPTARG;;
	P)
	    PROG=$OPTARG;;
	p)
	    PART=$OPTARG;;
	J)
	    JOBN=$OPTARG;;
	T)
	    TIME=$OPTARG;;
	N)
	    NODE=$OPTARG;;
	C)
	    NCOR=$OPTARG;;
	M)
	    MEMR=$OPTARG;;
	D)
	    DEPEND=$OPTARG;;
	A)
	    DEPEND=$OPTARG
	    afterok='afterany';;
	d)
	    DRY_RUN=$OPTARG;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    exit 1;;
	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    exit 1;;
    esac
done
if [ "$PROG" == "" ] ; then
    echo "NO PROG" >&2
    exit
fi

SBC="$CDIR"/"$JOBN"'_.sbc'

echo '#!/bin/bash' > $SBC

echo '#SBATCH --job-name='$JOBN >> $SBC
#echo '#PBS -N' $JOBN >> $PBS
#echo '#PBS -S /bin/bash' >> $PBS
echo '#SBATCH --output='"$CDIR"/"$JOBN"'O.out' >> $SBC
echo '#SBATCH --error='"$CDIR"/"$JOBN"'E.err' >> $SBC
echo '#SBATCH --time='"$TIME"':00:00' >> $SBC
echo '#SBATCH --qos=normal' >> $SBC
echo '#SBATCH --mem='"$MEMR"000 >> $SBC
echo '#SBATCH --nodes='$NODE >> $SBC
echo '#SBATCH --ntasks-per-node='"$NCOR" >> $SBC
echo '#SBATCH --partition='"$PART" >> $SBC
#echo 'module load gcc/4.9' >> $SBC
#echo 'module load boost/1.51' >> $SBC
#echo 'module load openmpi' >> $SBC
#echo 'module load gsl' >> $SBC


if [ $PROGFILE -eq 0 ] ; then
    echo 'date;' "$PROG" ' ; date' >> $SBC
else
#    echo 'date' >> $SBC
    cat $PROG >> $SBC
#    echo 'date' >> $SBC
fi

if [ "$DEPEND" == "" ] ; then
    if [ $DRY_RUN -eq 1 ] ; then
	echo sbatch $SBC
    else
	JOBID=`sbatch $SBC`
    fi
else
    for i in `echo $DEPEND`
    do
	F="$F":"$i"
    done
    if [ $DRY_RUN -eq 1 ] ; then
	echo sbatch --dependency="$afterok"$F $SBC
    else
	JOBID=`sbatch --dependency="$afterok"$F $SBC`
    fi
fi
JOBID=`echo $JOBID | awk '{print $NF}'`


if [ $CREATEDEPFILE -eq 1 ] ; then
    DEPFILE="$JOBID"'.depx'
    echo $JOBID > $DEPFILE
    for i in `echo $DEPEND`
    do
	echo "$i" '->' $JOBID >> $DEPFILE
    done
    for j in `echo $FORWARD_DEP`
    do
	echo $JOBID '->' $j >> $DEPFILE
    done
fi
echo $JOBID

