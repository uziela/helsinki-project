#!/usr/bin/env python

import sys

################################ Usage ################################

script_name = sys.argv[0]

usage_string = """
Usage:

	%s [Parameters]
	
Parameters:
	<input-file1> - input file1 (no filter)
	<input-file2> - input file2 (5%% filter)
	<input-file3> - input file3 (10%% filter)
	<input-file4> - input file4 (20%% filter)
	<input-file5> - input file5 (30%% filter)	
	<input-file6> - input file6 (40%% filter)	
	<input-file7> - input file7 (50%% filter)	
	<input-file8> - input file8 (names)		
	<output-file> - output file (html table)
""" % script_name

if len(sys.argv) != 10:
    sys.exit(usage_string)

################################ Functions ################################

def read_data(filename, is_string=False):    
    my_array = []    
    f = open(filename)  
    
    while True:
        line = f.readline()
        if len(line) == 0: 
            break
        line = line.rstrip('\n')
        #bits = line.split("\t")     
        if is_string:
        	my_array.append(line)
        else:
        	my_array.append(float(line))
    f.close()
    
    return my_array

def add_line(out_str, my_array, header):
	out_str += """<tr>
<th align=\"left\">%s</th>
""" % header

	for i in range(0, len(my_array)):
		out_str += "<td>%0.2f</td>\n" % my_array[i]
	
	out_str += "</tr>\n"
	return out_str

def write_data(filename, nofilter, filter05, filter10, filter20, filter30, filter40, filter50, names):
	f = open(output_file,"w")

	out_str = """<html>
<table border=\"1\">
<tr>
<th align=\"left\"></th>
"""
	for i in range(0, len(names)):
		out_str += "<th align=\"left\">%s</th>" % names[i]
	out_str += "\n</tr>"
	
	out_str = add_line(out_str, nofilter, "No filter")
	out_str = add_line(out_str, filter05, "5% filter")
	out_str = add_line(out_str, filter10, "10% filter")
	out_str = add_line(out_str, filter20, "20% filter")
	out_str = add_line(out_str, filter30, "30% filter")
	out_str = add_line(out_str, filter40, "40% filter")
	out_str = add_line(out_str, filter50, "50% filter")
	
	out_str += """</table>
</html>
"""
	
	f.write(out_str)
	
	f.close() 


################################ Variables ################################

# Input files/directories
input_file1 = sys.argv[1]
input_file2 = sys.argv[2]
input_file3 = sys.argv[3]
input_file4 = sys.argv[4]
input_file5 = sys.argv[5]
input_file6 = sys.argv[6]
input_file7 = sys.argv[7]
input_file8 = sys.argv[8]

# Output files/directories
output_file = sys.argv[9]

# Constants
# N/A

# Global variables
# N/A

################################ Main script ################################
	
print "%s is running..." % script_name

nofilter = read_data(input_file1)
filter05 = read_data(input_file2)
filter10 = read_data(input_file3)
filter20 = read_data(input_file4)
filter30 = read_data(input_file5)
filter40 = read_data(input_file6)
filter50 = read_data(input_file7)
names = read_data(input_file8, True)


write_data(output_file, nofilter, filter05, filter10, filter20, filter30, filter40, filter50, names)

print "%s done." % script_name



