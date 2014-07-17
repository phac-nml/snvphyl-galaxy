#!/bin/bash


positions=$1 
shift
phylip=$1
shift
fasta=$1
shift

#get working directory so we can find the output files 
CUR_DIR=`pwd`
mkdir $CUR_DIR/pseudoalign

#run vcf2pseudoalignment
$VCF2PSEUDO/vcf2pseudoalignment.pl $@ -o $CUR_DIR/pseudoalign 

#mv output files to where galaxy can use them
mv $CUR_DIR/pseudoalign-positions.tsv $positions
mv $CUR_DIR/pseudoalign.fasta $fasta
mv $CUR_DIR/pseudoalign.phy $phylip

exit 0
