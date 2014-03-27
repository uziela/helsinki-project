#!/usr/bin/perl -w

sub parse_score {
	my $INPUT_FILE = $_[0];
	my $TYPE = $_[1];
	my $score = "";
	
	open(IN_FILE, "$INPUT_FILE") or die "Error occured opening input file '$INPUT_FILE': $!";
	while (my $line=<IN_FILE>) {
		chomp $line;
		if ($TYPE eq "-spearman") {
			if ($line =~ m/^Spearman correlation:\s+(-?\d+\.\d+)$/) {
				$score = $1;
			}
		} elsif ($TYPE eq "-corr") {
			if ($line =~ m/^Correlation:\s+(-?\d+\.\d+)$/) {
				$score = $1;
			} 
		} 
	}
	close(IN_FILE) or die "Error occured closing input file: $!";
	
	if ($score eq "") {
		print "WARNING:Score not found in a file '$INPUT_FILE'\n";
	}
	return $score;
}

1;

