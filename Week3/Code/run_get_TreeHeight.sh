#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: run_get_TreeHeight.sh
# Desc: tests get_TreeHeight.R and get_TreeHeight.py
# Date: Oct 2018

echo "Testing get_TreeHeight.R..."

Rscript get_TreeHeight.R ../Data/trees.csv

file="../Results/trees_treeheights.csv"
if [ ! -f "$file" ]
then
    echo "Not successful :("
else
    echo "Success! :), see output in Results Directory"
fi 

echo "Testing get_TreeHeight.py..."

python3 get_TreeHeight.py ../Data/trees.csv

file="../Results/trees_treeheights_py.csv"
if [ ! -f "$file" ]
then
    echo "Not successful :("
else
    echo "Success! :), see output in Results Directory"
fi 