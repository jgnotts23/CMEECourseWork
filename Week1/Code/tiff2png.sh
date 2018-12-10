#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: tif2png.sh
# Desc: Script to convert a .tif image to a .png image
# Arguments: 1 -> .tif
# Date: Oct 2018

echo "Creating a .png version of $1 ..."

# Change file extension
filename="${1//.png/.tif}"

# Extract basename and change output directory
new_filename=$(basename $filename)
out_filename="../Results/$new_filename"

# Output
cat $1 >> $out_filename
echo "Done! The file has been saved as $out_filename"
exit