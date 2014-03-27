#!/usr/bin/perl -w

use strict;

my $last = "";
my $sum = 0;
while (my $line=<>) {
	chomp $line;
	$line =~ /^(\S+) (\S+)$/;
	if (($last ne "") && ($last ne $1)) {
		print "$last $sum\n";
		$sum = 0;
	}
	$last = $1;
	$sum += $2;
}

print "$last $sum\n"; # Assuming there is no new line in the end of the file. We have to print the last sum
