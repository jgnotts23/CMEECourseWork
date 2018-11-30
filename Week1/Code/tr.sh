#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: tr.sh
# Desc: demonstrating the use of tr
# Date: Nov 2018

# tr is an abbreviation or translate or transliterate
# It deletes or subsitutes characters

# Remove excess spaces
echo "Remove    excess      spaces." | tr -s "\b" " "
# -s squeezes repeats into one occurence of that character

# Remove all the "a"s
echo "remove all the as" | tr -d "a"
# -d deletes characters

# Set to uppercase
echo "set to uppercase" | tr [:lower:] [:upper:]

# Remove non-numbers
echo "10.00 only numbers 1.33" | tr -d [:alpha:] | tr -s " " ","