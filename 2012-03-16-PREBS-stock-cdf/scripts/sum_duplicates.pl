#!/usr/bin/perl -w

use strict;

my $last_id = "";
my @last_fields = ();

my $line = <>;
print $line; # print header

while (my $line=<>) {
	chomp $line;
	my @fields = split(" ",$line);
	my $id = $fields[0];
	#print "$id\n";
	#print "@fields\n";	
	#print "@last_fields\n";
	
	if ($id eq $last_id) {
		for (my $i = 1; $i <= $#fields; $i++) {
			$last_fields[$i] += $fields[$i];
		}		
	} else {
		if ($last_id ne "") {
			print "@last_fields\n";
		}
		$last_id = $id;
		@last_fields = @fields;
	}
	
}

print "@last_fields\n";	# print last line
