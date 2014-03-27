#!/usr/bin/perl -w

use strict;

my $correct = 0;
my $n = 0;

my $correct_spam = 0;
my $classified_as_spam = 0;
my $all_spam_messages = 0;

while (my $line=<>) {
	$n++;
	if ($line =~ /^(\S+)\t(\S+)$/) {
		#print "$1 and $2\n";
		if (($1>0) && ($2>0)) {
			$correct++;
			$correct_spam++;
		} elsif (($1<0) && ($2<0)) {
			$correct++;
		}
		if ($2>0) {
			$classified_as_spam++;
		}
		if ($1>0) {
			$all_spam_messages++;
		}
		
	} else {
		die "ERROR: wrong input";
	}
}

my $accuracy = $correct / $n;
my $precision = $correct_spam / $classified_as_spam;
my $recall = $correct_spam / $all_spam_messages;

print "Accuracy = $accuracy
Precision = $precision
Recall = $recall
";

