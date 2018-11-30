#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: tiff2png.sh
# Desc: Script to convert a .tiff image to a .png image
# Arguments: 1 -> .png
# Date: Oct 2018

for f in *.tif;
    do
        echo "Converting $f";
        convert "$f"  "$(basename "$f" .tif).png";
    done