#!/usr/bin/perl -w

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

# Script description:
# N/A


use strict;

require "./scripts/parse-score.pl";

if ($#ARGV != 0) {
	die "
Usage:

$0 [Parameters]

Parameters:
	<out-file> - output html file with summary
\n";
}

# input files/directories	
#my $INPUT_FILE = $ARGV[0];

# output files/directories
my $OUTPUT_FILE = $ARGV[0];

# constants
# N/A

# global variables
my %logfc;
my %padj;

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

read_corr();

round_values();

write_summary($OUTPUT_FILE);

print "$0 done.\n";

###################### subroutines ######################

sub read_corr {
	$logfc{'array_vs_rna'} = parse_score("output/logfc_ensembl/array_logfc_vs_rna_logfc.corr", "-spearman");
	$logfc{'array_vs_array03'} = parse_score("output/logfc_ensembl/array_logfc_vs_array_log03.corr", "-spearman");
	$logfc{'array_vs_array08'} = parse_score("output/logfc_ensembl/array_logfc_vs_array_log08.corr", "-spearman");
	$logfc{'rna_vs_rna03'} = parse_score("output/logfc_ensembl/rna_logfc_vs_rna_log03.corr", "-spearman");
	$logfc{'rna_vs_rna08'} = parse_score("output/logfc_ensembl/rna_logfc_vs_rna_log08.corr", "-spearman");
	
	$padj{'array_vs_rna'} = parse_score("output/padj/array_p_vs_rna_p.corr", "-spearman");
	$padj{'array_vs_array03'} = parse_score("output/padj/array_p_vs_array_p03.corr", "-spearman");
	$padj{'array_vs_array08'} = parse_score("output/padj/array_p_vs_array_p08.corr", "-spearman");
	$padj{'rna_vs_rna03'} = parse_score("output/padj/rna_p_vs_rna_p03.corr", "-spearman");
	$padj{'rna_vs_rna08'} = parse_score("output/padj/rna_p_vs_rna_p08.corr", "-spearman");

}

sub round_values {
	foreach my $key ( keys %logfc ) {
		$logfc{$key} = sprintf "%.2f", $logfc{$key};
		$padj{$key} = sprintf "%.2f", $padj{$key};
	}
}

sub write_summary {
	my $output_file = $_[0];
	open(OUT_FILE,">$output_file") or die "Error occured opening output file: '$output_file': $!";
		print OUT_FILE
"<html>

<h2> Linear Kernel </h2>

<table border=\"1\">
<tr>
<th align=\"left\"></th>
<th align=\"left\">Log2FoldChange</th>
<th align=\"left\">Adjusted P-val</th>
</tr>

<tr>
<th align=\"left\">True Microarray vs True RNA-seq</th>
<td>$logfc{'array_vs_rna'}</td>
<td>$padj{'array_vs_rna'}</td>
</tr>

<tr>
<th align=\"left\">True Microarray vs Predicted Microarray (Linear kernel)</th>
<td>$logfc{'array_vs_array03'}</td>
<td>$padj{'array_vs_array03'}</td>
</tr>


<tr>
<th align=\"left\">True RNA-seq vs Predicted RNA-seq (Linear kernel)</th>
<td>$logfc{'rna_vs_rna03'}</td>
<td>$padj{'rna_vs_rna03'}</td>
</tr>

</table> 


<h2> Radial Kernel </h2>

<table border=\"1\">
<tr>
<th align=\"left\"></th>
<th align=\"left\">Log2FoldChange</th>
<th align=\"left\">Adjusted P-val</th>
</tr>

<tr>
<th align=\"left\">True Microarray vs True RNA-seq</th>
<td>$logfc{'array_vs_rna'}</td>
<td>$padj{'array_vs_rna'}</td>
</tr>

<tr>
<th align=\"left\">True Microarray vs Predicted Microarray (Radial kernel)</th>
<td>$logfc{'array_vs_array08'}</td>
<td>$padj{'array_vs_array08'}</td>
</tr>

<tr>
<th align=\"left\">True RNA-seq vs Predicted RNA-seq (Radial kernel)</th>
<td>$logfc{'rna_vs_rna08'}</td>
<td>$padj{'rna_vs_rna08'}</td>
</tr>


</html>
";

	
	close(OUT_FILE) or die "Error occured closing output file: $!";
}
