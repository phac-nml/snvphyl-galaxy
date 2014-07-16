#/bin/bash


#determine if we were given 1 or 2 fastq files
if [ $# -eq 3 ] || [ $# -eq 2 ]; then
    #get the output file name
    output=$1
    
    #remove it from the arguments list
    shift

    $SMALT/smalt check $@ > $output

    #remove header file
    sed -i -e "1d" $output
    
else
    #unknown arguments given
    exit 1
fi



exit 0
