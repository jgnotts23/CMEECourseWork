#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: concatenate (merge) the contents of two files
# Arguments: None
# Date: Oct 2018

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3