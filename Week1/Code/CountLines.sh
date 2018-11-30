#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: CountLines.sh
# Desc: script to count the number of lines in a file
# Arguments: line number count
# Date: Oct 2018

NumLines=`wc -l < $1` # < redirects file contents to standard input of the comand 
echo "The file $1 has $NumLines lines"
echo