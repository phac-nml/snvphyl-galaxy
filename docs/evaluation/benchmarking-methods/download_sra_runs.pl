#!/usr/bin/env perl

use Parallel::ForkManager;
use FindBin;

my $script_dir = $FindBin::Bin;

use warnings;
use strict;

# given a list of files in format (name, SRA URL, layout), downloads and renames the runs
# downloads files ot [fastq-dir] using [cores] of fastq-dump in parallel
my $usage = "Usage: $0 [fastq-dir] [cores] < files.txt";

if (@ARGV != 2) {
    die "$usage";
}

my $outdir = $ARGV[0];
my $cores = $ARGV[1];

my $pm = new Parallel::ForkManager($cores);

while(my $line = <STDIN>)
{
        $pm->start and next;

	chomp $line;
	my @parts = split(/\t/,$line);

	my $files_dir = "$script_dir/$outdir";
	my $name = $parts[0];
	my $sra_run = $parts[1];
	my $layout = $parts[2];
	chdir $files_dir;

	my $command = "fastq-dump -F --defline-qual + -A $name ";
	$command .= ($layout eq 'PAIRED') ? '--split-files' : '';
	$command .= " $sra_run";

	print $command."\n";
	if (system($command) != 0)
	{
		print "Failed for $name\n";
	}
	else
	{
		print "Success for $name\n";
	}

        $pm->finish;
}
