#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: csvtospace.sh
# Desc: bash script to convert a .csv file to a .tsv file
# Arguments: 1 -> .tsv
# Date: Oct 2018

echo "Creating a tab separated version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.tsv
echo "Done!"
exit