#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the spaces in the files with commas
# Arguments: 1-> tab delimited file
# Date: Oct 2018

echo "Creating a comma separated version of $1 ..."

# Change file extension
filename="${1//.txt/.csv}"

# Extract basename and change output directory
new_filename=$(basename $filename)
out_filename="../Results/$new_filename"

# Replace spaces with commas and output
cat $1 | tr -s " " "," >> $out_filename
echo "Done! The file has been saved as $out_filename"
exit