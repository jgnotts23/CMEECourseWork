#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: Vectorize_speed.sh
# Desc: Comparing system times of the vectorization scripts
# Date: Nov 2018

echo "Running Vectorize1.R"

Rscript Vectorize1.R


echo "Running Vectorize1.py"

python3 Vectorize1.py

echo "Running Vectorize2.R"

Rscript Vectorize2.R

echo "Running Vectorize2.py"

python3 Vectorize2.py