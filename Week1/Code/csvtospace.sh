#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: Script to convert a .csv file to a space separated
# Arguments: 1 .csv file
# Date: Oct 2018

echo "Creating a tab separated version of $1 ..."

# Change file extension
filename="${1//.csv/_space.txt}"

# Extract basename and change output directory
new_filename=$(basename $filename)
out_filename="../Results/$new_filename"

# Replace commas with spaces and output
cat $1 | tr -s "," "  " >> $out_filename
echo "Done! The file has been saved as $out_filename"
exit