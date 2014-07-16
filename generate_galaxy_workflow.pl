#!/usr/bin/env perl

use warnings;
use strict;

use Template;
use Pod::Usage;
use Getopt::Long;

my $pod_sections = "SYNOPSIS|EXAMPLE";

my $local_toolshed;
my $galaxy_template_file;
if (!GetOptions('l|local-toolshed=s' => \$local_toolshed)) {
	pod2usage(-verbose => 99, -sections => $pod_sections, -exitval => 1);
}

if (not defined $local_toolshed) {
	pod2usage(-message => "no galaxy local toolshed location defined", -sections => $pod_sections, -verbose => 99, -exitval => 1);
}

($galaxy_template_file) = @ARGV;
if (not defined $galaxy_template_file) {
	pod2usage(-message=> "no galaxy template file defined", -sections => $pod_sections, -verbose => 99, -exitval => 1);
} elsif (not -e $galaxy_template_file) {
	pod2usage(-message=> "galaxy template file $galaxy_template_file does not exist",
		  -sections => $pod_sections, -verbose => 99, -exitval => 1);
}

my $template = Template->new();
$template->process($galaxy_template_file, { 'LOCAL_REPOSITORY' => $local_toolshed });

=pod

=head1 NAME

generate_galaxy_workflow.pl: Script to generate a Galaxy workflow given the template workflow file.

=head1 SYNOPSIS

=over

=item generate_galaxy_workflow.pl --local-toolshed [local toolshed] [galaxy_workflow_template.ga.tt] > [galaxy_workflow.ga]

=back

=head1 EXAMPLE

=item generate_galaxy_workflow.pl --local-toolshed localhost:9009/repos/aaron Galaxy-Workflow-Core_SNP_Pipeline.ga > workflows/core_phylogenomics_pipeline_workflow/Galaxy-Workflow-Core_SNP_Pipeline.ga.tt

=back

=head1 DESCRIPTION

=over

=item -l|--local-toolshed: A URL to a local toolshed where the local tools will be installed.

=item [galaxy_workflow_template.ga.tt]: The Galaxy workflow template.

=item [galaxy_workflow.ga]: The output Galaxy workflow.

=back

=head1 AUTHORS

Aaron Petkau <aaron.petkau@phac-aspc.gc.ca>

=cut
