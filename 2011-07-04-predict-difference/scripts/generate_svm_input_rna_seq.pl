#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland


use strict;
use Getopt::Long;
use File::Basename;


my $usage = "
Short description:
The script reads feature names from the first line of input file and creates svm input file 
in the output directory with the values of target and training features which were specified. 
The output file is named according to the features used.

Usage:
$0 <Parameters>

Parameters:

-in <filename>    Input file has to be merged table with rna-seq and microarray data (output from R)

-svm <filename>   Name of the output svm file

-index <filename> Name of the output index file

-target <colname> Name of the target column (for ex. adj.P.Val)

-features <list>  List of training features delimited by '+' (for ex. baseMean+log2FoldChange+padj+GeneLengthKB)

";

# input files/directories	
my $INPUT_FILE;

# output files/directories
my $SVM_FILE;
my $INDEX_FILE;

# constants
my $TARGET;
my $FEATURES;

# global variables
my @data = ();
my @index = ();		# array of 0 and 1 to mark which features to use
my @col_ids = ();   # ids of the columns in the input file

################ read in parameters #####################

if ($#ARGV == -1) {
	die $usage;
}

print "$0 has started with parameters: @ARGV\n";

my $opt_return = GetOptions(
               'in=s'   => \$INPUT_FILE,
               'svm=s'   => \$SVM_FILE,
               'index=s'   => \$INDEX_FILE,
               'target=s' => \$TARGET,
               'features=s' => \$FEATURES,
               'help|h'   => sub { print $usage; exit( 0 ); }
);

if (!$INPUT_FILE || !$SVM_FILE || !$INDEX_FILE || !$TARGET || !$FEATURES) {
	print "ERROR: All parameters are mandatory!\n";
	print $usage;
	exit( 0 );
}

if (! $opt_return) {
	die "Program terminated because of unkown options.";
}

if ($#ARGV >=0) {
	die "
Program terminated because of unkown options.
Unknown options:
@ARGV
";
}


###################### main script ######################


read_data($INPUT_FILE, $SVM_FILE);

make_index($INDEX_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_data {
	my $input_file = shift;
	my $svm_file = shift;
	
	open(SVM_FILE,">$svm_file") or die "Error occured opening output file: '$svm_file': $!";
	open(IN_FILE, "$input_file") or die "Error occured opening input file '$input_file': $!";
	
	my $firstline = <IN_FILE>;
	chomp $firstline;
	@col_ids = split(/ /, $firstline);
	my @feat = split(/\+/, $FEATURES);
	my %feat_set = map { $_ => 1 } @feat;
	$index[0] = 0;							# never use first column ("name" in R)
	
	for (my $i = 0; $i <= $#col_ids; $i++) {
		my $col_id = $col_ids[$i];
		if ($feat_set{$col_id}) {
			$index[$i] = 1;
			delete($feat_set{$col_id});
		} else {
			$index[$i] = 0;
		}
	}
	die "ERROR: unindentified features in the parameters. Check the parameters again!" if (%feat_set);
	
	while (my $line=<IN_FILE>) {
		chomp $line;
		my @bits = split(/ /, $line);
		my $target = "";
		my @add = ();	
		
		for (my $i = 1; $i <= $#bits; $i++) {
			my $value = $bits[$i];
			if ($col_ids[$i-1] eq "adj.P.Val") {
				if ($value > 1e-7) {							# convert to log scale and make a min value for adjusted P-value
					$value = log($value)/log(10);
				} else {
					$value = -7;
				}
			}
			if ($col_ids[$i-1] eq "padj") {
				if ($value > 1e-22) {							# convert to log scale and make a min value for adjusted P-value
					$value = log($value)/log(10);
				} else {
					$value = -22;
				}
			}		
			#if ($col_ids[$i-1] eq "logFC") {
			#	$value = 1.5 if ($value > 1.5);
			#	$value = -1.5 if ($value < -1.5);
			#}
			#if ($col_ids[$i-1] eq "log2FoldChange") {
			#	$value = 3 if ($value > 3);
			#	$value = -3 if ($value < -3);
			#}			
			
			if ($col_ids[$i-1] eq "baseMean") {	
				$value = log($value)/log(10);		# convert RNA baseMean expression to logscale 
			}
			push(@add, $value) if ($index[$i-1]);
			$target = $value if ($col_ids[$i-1] eq $TARGET);
		}
		
		die "ERROR: unindentified target in the parameters. Check the parameters again!" if ($target eq "");
	
		my $svm_string = $target;
		for (my $i = 0; $i <= $#add; $i++) {
			my $ii = $i+1;
			$svm_string .= " $ii:$add[$i]";
		}
		print SVM_FILE "$svm_string\n";
	}

	
	close(IN_FILE) or die "Error occured closing input file: $!";
	close(SVM_FILE) or die "Error occured closing output file: $!";
}

sub make_index {
	my $index_file = shift;
	open(INDEX_FILE,">$index_file") or die "Error occured opening output file: '$index_file': $!";
	
	my $index_string = "TARGET: $TARGET\n";
	
	my $j = 0;
	for (my $i = 0; $i <= $#col_ids; $i++) {
		if ($index[$i]) {
			$j++;
			$index_string .= "$j:$col_ids[$i]\n";
		}
	}

	print INDEX_FILE "$index_string\n";
	
	close(INDEX_FILE) or die "Error occured closing output file: $!";
}

