#!/usr/bin/perl -w

use strict;


###################### main script ######################

print "$0 has started with parameters: @ARGV\n";


print "$0 done.\n";

###################### subroutines ######################

sub read_file {
	my $input_file = $_[0];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";

	#my @file = <IN_FILE>;
	#for (my $i = 0; $i <= $#file; $i++) {
	#}

	while (my $line=<IN_FILE>) {
		chomp $line;
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
}

sub write_file {
	my $output_file = $_[0];
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";
	
	close(OUT_FILE) or die "Error occured closing output file: $!";
}
