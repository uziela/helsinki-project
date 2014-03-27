#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

# Script description:
# Very quick and untidy script to create html tables out of results.


use strict;

if ($#ARGV != 4) {
	die "
Usage:

$0 [Parameters]

Parameters:
  <input-file> - input file
  <output-file> - output file
  <N> - number of feature sets for each kernel
  <Correlation-to-improve> - pre-calculated Pearson correlation to improve
  <Spearman?> - Do you want to calculate Spearman correlations? (0 or 1)
\n";
}

# input files/directories	
my $INPUT_FILE = $ARGV[0];

# output files/directories
my $OUTPUT_FILE = $ARGV[1];

# constants
my $N = $ARGV[2];
my $SP = $ARGV[4];

# global variables
my @features;
my @correlation;
my $CORR_TO_IMPROVE = $ARGV[3];
my $BEST_CORR = 0;
my $IMPROVEMENT = 0;

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

initialize();
read_file($INPUT_FILE);
check_data();
round_numbers();
calc_improvement();
write_file($OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub initialize {
	for (my $i = 1; $i <= $N*2; $i++) {
		$features[$i] = "";
		$correlation[$i] = "";
	}
}

sub read_file {
	my $input_file = $_[0];
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";

	my $i = 1;
	while (my $line=<IN_FILE>) {
		chomp $line;
		if ($line ne "") {
			my @bits = split(/: /, $line);
			#print "$bits[0] $bits[1]\n";
			my $label = $bits[0];
			my $value = $bits[1];
			
			if ($label eq "Name") {
				$i = substr($value, -2);
				#print "$n\n";
			}			
			
			$features[$i] = $value if ($label eq "Features");
			$correlation[$i] = $value if ( ($label eq "Correlation") && (!$SP) );
			$correlation[$i] = $value if ( ($label eq "Spearman correlation")  && ($SP) );
			
		}
	}

	close(IN_FILE) or die "Error occured closing input file: $!";
	
}


sub check_data {
	for (my $i = 1; $i <= $N; $i++) {
		$features[$i] = $features[$i+$N] if ($features[$i] eq "");
		$features[$i+$N] = $features[$i] if ($features[$i+$N] eq "");
		die "ERROR: Features of two kernels don't match: $i $features[$i]\n" if ($features[$i] ne $features[$i+$N]);
	}
}

sub round_numbers {
	for (my $i = 1; $i <= $N*2; $i++) {
		if ($correlation[$i] ne "") {
			$correlation[$i] = sprintf "%.2f", $correlation[$i];
		}
	}
	$CORR_TO_IMPROVE = sprintf "%.2f", $CORR_TO_IMPROVE;
}

sub calc_improvement {
	for (my $i = 1; $i <= $N*2; $i++) {
		if ($correlation[$i] ne "") {
			$BEST_CORR = $correlation[$i] if ($correlation[$i] > $BEST_CORR);
		}
	}
	$IMPROVEMENT = $BEST_CORR - $CORR_TO_IMPROVE;
	$IMPROVEMENT = sprintf "%.2f", $IMPROVEMENT;
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

for (my $i = 1; $i <= $N; $i++) {
print OUT_FILE 
"
<tr>
<th align=\"left\">$features[$i]</th>
<td>$correlation[$i]</td>
<td>$correlation[$i+$N]</td>
</tr>
";
}

print OUT_FILE 
"
</table> 
<p> <b> Best Correlation: </b> $BEST_CORR
<p> <b> Correlation to improve: </b> $CORR_TO_IMPROVE
<p> <b> Improvement: </b> $IMPROVEMENT

</html>
";

	close(OUT_FILE) or die "Error occured closing output file: $!";
}
