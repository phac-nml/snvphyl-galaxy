#/bin/bash


smi=$1
shift
sma=$1
shift

#get working directory so we can find the output files 
CUR_DIR=`pwd`


cp "$smi" "$CUR_DIR/temp.smi"
cp "$sma" "$CUR_DIR/temp.sma"

#determine if we have 1 or 2
num_inputs=$1
shift

inputs=()

#determine how many fasta/fastq were given. Needs to be provided by user
if [ $num_inputs -eq 1 ]; then
    inputs+=$1
    shift
elif [ $num_inputs -eq 2 ]; then
    inputs+=$1
    shift
    inputs+=' '
    inputs+=$1
    shift    
else
    exit 1
fi
$SMALT/smalt map $@ 'temp' $inputs

#remove index files
rm "$CUR_DIR/temp.smi"
rm "$CUR_DIR/temp.sma"


exit 0
