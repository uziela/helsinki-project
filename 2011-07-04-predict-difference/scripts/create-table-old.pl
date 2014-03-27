#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

# Script description:
# Very quick and untidy script to create html tables out of results.


use strict;

if ($#ARGV != 1) {
	die "
Usage:

$0 [Parameters]

Parameters:
  <input-file> - input file
  <output-file> - output file
\n";
}

# input files/directories	
my $INPUT_FILE = $ARGV[0];

# output files/directories
my $OUTPUT_FILE = $ARGV[1];

# constants
# N/A

# global variables
my @features;
my @correlation;
my @spearman;

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

read_file($INPUT_FILE);
check_data();
round_numbers();
write_file($OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_file {
	my $input_file = $_[0];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";

	my $i = 10;			# in input file 10-14 goes before 1-9. This is a quick fix
	while (my $line=<IN_FILE>) {
		chomp $line;
		if ($line ne "") {
			my @bits = split(/: /, $line);
			#print "$bits[0] $bits[1]\n";
			my $label = $bits[0];
			my $value = $bits[1];
			$features[$i] = $value if ($label eq "Features");
			$correlation[$i] = $value if ($label eq "Correlation");
			$spearman[$i] = $value if ($label eq "Spearman correlation");
			
			
			if ($label eq "Spearman correlation") {
				#print "foo\n";
				$i++;
				$i = 1 if ($i > 14);	# in input file 10-14 goes before 1-9
			}
		}
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
	
}

# quick fix for a stupid bug inside old "commands.txt" files. Features 13 and 14 should be switched places so that they match Features 6 and 7
sub check_data {
	if (($features[14] eq $features[6]) && ($features[13] eq $features[7])) {
		#print "bug present\n";
		($features[13], $features[14]) = ($features[14], $features[13]);
		($correlation[13], $correlation[14]) = ($correlation[14], $correlation[13]);
		($spearman[13], $spearman[14]) = ($spearman[14], $spearman[13]);
	}
	for (my $i = 1; $i <= 7; $i++) {
		die "ERROR: Features of two kernels don't match: $i $features[$i]\n" if ($features[$i] ne $features[$i+7]);
	}
}

sub round_numbers {
	for (my $i = 1; $i <= 14; $i++) {
		$correlation[$i] = sprintf "%.2f", $correlation[$i];
		$spearman[$i] = sprintf "%.2f", $spearman[$i];
	}
}

sub write_file {
	my $output_file = $_[0];
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";

print OUT_FILE 
"<html>
<table border=\"1\">
<tr>
<th align=\"left\">Training Features/Kernel</th>
<th align=\"left\">Linear</th>
<th align=\"left\">Radial</th>
</tr>
";

for (my $i = 1; $i <= 7; $i++) {
print OUT_FILE 
"
<tr>
<th align=\"left\">$features[$i]</th>
<td>$correlation[$i]</td>
<td>$correlation[$i+7]</td>
</tr>
";
}

print OUT_FILE 
"
</table> 
</html>
";

	close(OUT_FILE) or die "Error occured closing output file: $!";
}
