#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: run all scripts that make up miniproject
# Arguments: None
# Date: Mar 2019

echo "Here goes nothing..."

# Data wrangling in R
echo "Commencing data wrangling in R, Yee-haw!"
Rscript data_wrangling.R
echo "Wrangling complete!"

# Model fitting in Pythojn
echo "Hey Python? Let's fit those models!"
python3 model_fitting.py
echo "Model fitting complete!"

# Plotting and summarising
echo "Time to make some sweet plots and compare those models!"
Rscript model_comparison.R
echo "Plotting and comparing complete! See plots in ../Results/"

# LaTeX compiling
echo "And the piece de resistance, the report!"
bash CompileLaTeX.sh writeup.tex Miniproject.bib
echo "LaTeX compiled, see pdf in ../Results/"
echo "Mic drop"

exit
