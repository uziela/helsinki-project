#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

# Script description:
# N/A


use strict;

if ($#ARGV != 2) {
	die "
Usage:

$0 [Parameters]

Parameters:
  <input-file1> - input file with rankings
  <input-file2> - input file with converted ids from ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene2ensembl.gz
  <output-file> - output file with replaced ids
\n";
}

# input files/directories	
my $INPUT_FILE1 = $ARGV[0];
my $INPUT_FILE2 = $ARGV[1];

# output files/directories
my $OUTPUT_FILE = $ARGV[2];

# constants
# N/A

# global variables
my %conv;

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

read_ids($INPUT_FILE2);
replace_ids($INPUT_FILE1, $OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_ids {
	my $input_file = $_[0];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";

	while (my $line=<IN_FILE>) {
		chomp $line;
		my @bits = split(/\t/, $line);
		my $ensembl = $bits[0];
		my $entrez = $bits[1];
		$conv{$ensembl} = $entrez;
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
}

sub replace_ids {
	my $input_file = $_[0];
	my $output_file = $_[1];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";

	while (my $line=<IN_FILE>) {
		chomp $line;
		my @bits = split(/\t/, $line);
		my $ensembl = $bits[0];
		my $rank = $bits[1];
		if (!defined $conv{$ensembl}) {
			print "WARNING: $ensembl ID does not exist.\n" ;
		} else {
			my $entrez = $conv{$ensembl};
			print OUT_FILE "$entrez\t$rank\n";
		}
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
	close(OUT_FILE) or die "Error occured closing output file: $!";
}

