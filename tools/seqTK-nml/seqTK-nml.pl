#!/usr/bin/env perl

use strict;
use Bio::SeqIO;

my ($fastaref, $type, $coverage, $outfile, $outfile_rev, $length, $subsample_size, @fastqs, $rv);

$fastaref = $ARGV[0];
shift(@ARGV);
$type = $ARGV[0];
shift(@ARGV);
if ($type eq "single"){
	$fastqs[0] = $ARGV[0];
	shift(@ARGV);
}else{
	$fastqs[0] = $ARGV[0];
	shift(@ARGV);
	$fastqs[1] = $ARGV[0];
	shift(@ARGV);	
}
$coverage = $ARGV[0];
shift(@ARGV);
$outfile = $ARGV[0];
shift(@ARGV);
if ($type ne "single"){
	$outfile_rev = $ARGV[0];
	shift(@ARGV);
}
	
if (!($coverage)){
	$coverage = 50;
}

my $seq_in  = Bio::SeqIO->new(
  -format => 'fasta',
  -file   => $fastaref,
);

while ( my $seq = $seq_in->next_seq()) {
    $length += $seq->length();
}

my $all_fastq = join (' ' , map { "\"$_\"" } @fastqs);

#one liner from : http://onetipperday.blogspot.ca/2012/05/simple-way-to-get-reads-length.html with some modification by Philip Mabon
my $total=`cat $all_fastq | perl -ne '\$s=<>;<>;<>;chomp(\$s);print length(\$s)."\n";' | sort | uniq -c | perl -e 'while(my \$line=<>){chomp \$line; \$line =~s/^\\s+//;(\$l,\$n)=split/\\s+/,\$line; \$t+= \$l*\$n;} print "\$t\n"'`;

print "Total number of Basepairs: $total\n";
print "Length of Reference: $length\n";

my $rawcoverage = $total/$length;
printf "Raw Coverage: %.3f\n",$rawcoverage;

my $out = $outfile;
my $i = 0;
if($rawcoverage > $coverage){
	#need to downsample
	#calculate $subsample_size
	$subsample_size = $coverage/$rawcoverage;
	printf("subsample: %.3f",$subsample_size);
	#printf()
	my $out = $outfile;
	my $i = 0;
	foreach my $fastq (@fastqs){
		if($i > 0){
			$out = $outfile_rev;
		}
		#seed always set to 42 for reproducibility 
		my $seqCommand = "seqtk sample -s42 $fastq $subsample_size > $out";
		$rv = system($seqCommand);
		$i ++;
	}	
} else {
	#no sampling needed, just copy the fastq's to the output
	print "Subsampling not required\n";
	foreach my $fastq (@fastqs){
		if($i > 0){
			$out = $outfile_rev;
		}
		my $copyCommand = "scp $fastq $out";
		$rv = system($copyCommand);
		$i ++;
	}
}


exit $rv >> 8 if $rv >>8;

#return $rv >> 8;
