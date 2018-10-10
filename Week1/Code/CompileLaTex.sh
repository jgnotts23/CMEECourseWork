#!/bin/bash

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