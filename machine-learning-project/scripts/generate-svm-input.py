#!/usr/bin/env python

import sys

################################ Usage ################################

script_name = sys.argv[0]

usage_string = """
Usage:

	%s [Parameters]
	
Parameters:
	<input-file> - input file
	<output-file> - output file
""" % script_name

if len(sys.argv) != 3:
    sys.exit(usage_string)

################################ Functions ################################

def read_data(filename):
    
    f = open(filename)
    fw = open(output_file,"w")
    
    while True:
        line = f.readline()
        if len(line) == 0: 
            break
        line = line.rstrip('\n')
        bits = line.split(" ")
        
        out_str = ""
        
        if bits[1] == "1":
        	out_str += "+1"		# positive class instance
        elif bits[1] == "0":
        	out_str += "-1"		# negative class instance
        else:
        	sys.exit("ERROR: unknown class")
        
        for i in range(2,len(bits)):
        	feat = bits[i]
        	out_str = out_str + " " + str(i-1) + ":" + bits[i]
        out_str += "\n"
        fw.write(out_str)
        
    f.close()
    fw.close()
    
def write_data(filename):
	f = open(output_file,"w")
	
	#out_str = "%s %f \n" % str_var f_var
	#f.write(out_str)
	
	f.close()


################################ Variables ################################

# Input files/directories
input_file = sys.argv[1]

# Output files/directories
output_file = sys.argv[2]

# Constants
# N/A

# Global variables
# N/A

################################ Main script ################################
	
print "%s is running..." % script_name

read_data(input_file)

print "%s done." % script_name



