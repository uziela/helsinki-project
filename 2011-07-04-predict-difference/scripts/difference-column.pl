#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

# Script description:
# N/A


use strict;

if ($#ARGV != 1) {
	die "
Usage:

$0 <input-file> <output-file>

  <input-file> - input file (.noindex)
  <output-file> - output file (difference of P-values between Microarray and RNA-seq in log-scale)
\n";
}

# input files/directories	
my $INPUT_FILE = $ARGV[0];

# output files/directories
my $OUTPUT_FILE = $ARGV[1];

# constants
# N/A

# global variables
# N/A

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

read_file($INPUT_FILE, $OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_file {
	my $input_file = shift;
	my $output_file = shift;
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";

	while (my $line=<IN_FILE>) {
		chomp $line;
		my @bits = split(/ /, $line);
		#print "$bits[6] $bits[14]\n";
		my $array_pval = adjust($bits[6]);
		my $rna_pval = adjust($bits[14]);
		print OUT_FILE abs($array_pval-$rna_pval)."\n";
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
	close(OUT_FILE) or die "Error occured closing output file: $!";
}

# convert to log scale and make a min value for adjusted P-value
sub adjust {
	my $value = shift;
	if ($value > 1e-10) {
		$value = log($value)/log(10);
	} else {
		$value = -10;
	}
	return $value;
}
