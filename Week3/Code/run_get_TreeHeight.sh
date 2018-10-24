#!/bin/bash

# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
#!/bin/bash
# Script: run_get_TreeHeight.sh
# Desc: tests get_TreeHeight.sh
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