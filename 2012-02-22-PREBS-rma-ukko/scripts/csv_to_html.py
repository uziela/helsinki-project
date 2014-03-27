#!/usr/bin/python

# Author: Karolis Uziela

import sys
import csv

################################ Usage ################################

script_name = sys.argv[0]

usage_string = """
Usage:

	%s [Parameters]
	
Parameters:

	<input-file> - input file (.csv)
	<output-file> - output file (.html)
	<delimiter> - csv file delimiter
	<table-name> - table name
""" % script_name

if len(sys.argv) != 5:
    sys.exit(usage_string)
    
################################ Variables ################################

# Input files/directories
input_file = sys.argv[1]

# Output files/directories
output_file = sys.argv[2]

my_delim = sys.argv[3]

table_name = sys.argv[4]

################################ Main script ################################

my_csv_file = open(input_file,'rb')
my_csv = csv.reader(my_csv_file, delimiter=my_delim)

my_html = open(output_file,'w')

my_html.write('<html>\n')
my_html.write('<b>' + table_name + '</b>\n')
my_html.write('<table border=\"1\">\n')

# first_line line
first_line = my_csv.next()
my_html.write('<tr>\n')
my_html.write('<th></th>\n')
for entry in first_line:
	my_html.write('<th align=\"left\">' + entry + '</th>\n')
my_html.write('</tr>\n')


# other lines
for line in my_csv:
	my_html.write('<tr>\n')
	first_entry = line[0]	# first entry
	my_html.write('<th align=\"left\">' + first_entry + '</th>\n')
	for i in range(1,len(line)):	# other entries
		entry = line[i]
		my_html.write('<td>' + entry + '</td>\n')
	my_html.write('</tr>\n')

my_html.write("</table>\n")
my_html.write("<br>\n")
my_html.write('</html>\n')
my_html.close()
my_csv_file.close()
