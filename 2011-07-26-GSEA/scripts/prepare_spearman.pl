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
  <input-file1> - input file 1 with GSEA gene set rankings
  <input-file2> - input file 2 with GSEA gene set rankings
  <output-file> - output file prepared for spearman correlation
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
my %scores1;
my %scores2;
my %gene_sets;

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

%scores1 = read_scores($INPUT_FILE1);
%scores2 = read_scores($INPUT_FILE2);

check_genesets();

write_file($OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_scores {
	my %scores;
	my $input_file = $_[0];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";
	
	my $previous = 0;
	while (my $line=<IN_FILE>) {
		chomp $line;
		my @bits = split(/\t/, $line);
		my $geneset = $bits[0];
		my $score = $bits[5];
		if ($score ne "") {
			$scores{$geneset} = $score;
			$previous = $score;
		} else {
			$scores{$geneset} = $previous;
			#print "$geneset\n";
		}
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
	return %scores;
}

sub check_genesets {
	my $n1 = scalar keys %scores1;
	my $n2 = scalar keys %scores2;
	die "ERROR: number of genesets in the two lists is different" if ($n1 != $n2);
	
	foreach my $key ( keys %scores1 ) {
		#print "key: $key, value: $scores1{$key}\n";
		die "ERROR: some genesets are unique in two lists" if (! defined($scores2{$key}));
	}
}

sub write_file {
	my $output_file = $_[0];
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";
	foreach my $key ( keys %scores1 ) {
		print OUT_FILE "$scores1{$key} $scores2{$key}\n";
	}	
	close(OUT_FILE) or die "Error occured closing output file: $!";
}
