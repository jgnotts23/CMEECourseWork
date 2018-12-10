#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Concatenate (merge) the contents of two files
# Arguments: Two files
# Date: Oct 2018

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3

exit