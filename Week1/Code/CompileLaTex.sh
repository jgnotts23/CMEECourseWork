#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: CompileLaTex.sh
# Desc: bash script to compile a LaTex document with references
# Arguments: None
# Date: Oct 2018

file="$1"
filename="${file%%.*}"

{
  pdflatex "$filename"
  bibtex "$filename"
  pdflatex "$filename"
} &> /dev/null
pdflatex "$filename"
printf "\n"

# Moving all output files to ../Results 
mv *.log *.aux *.bbl *.blg ../Results
mv "$filename".pdf ../Results

{
        gnome-open "$filename.pdf"
} &> /dev/null

exit