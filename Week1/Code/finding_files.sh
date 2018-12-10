#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: finding_files.sh
# Desc: demonstrating finding files in UNIX
# Date: Nov 2018

cd ../Sandbox
mkdir TestFind
cd TestFind
mkdir -p Dir1/Dir11/Dir111 # -p ensures no errors if file already exists
mkdir Dir2
mkdir Dir3
touch Dir1/File1.txt
touch Dir1/File1.csv
touch Dir1/File1.tex
touch Dir2/File2.txt
touch Dir2/file2.csv
touch Dir2/File2.tex
touch Dir1/Dir11/Dir111/File111.txt
touch Dir3/File3.txt

# Find particular files
find . -name "File1.txt"

# Ignore cases and use wildcards
find . -iname "fi*.txt"

# Exclude sub-directories
find . -maxdepth 2 -name "*.txt"

# Exclude certain files
find . -maxdepth 2 -not -name "*.txt"

# Find only directories
find . -type d -iname *dir*

exit