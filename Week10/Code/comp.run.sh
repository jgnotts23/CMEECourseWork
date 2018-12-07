#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: comp.run.sh
# Desc: Script to compile and run C scripts
# Arguments: A C script
# Date: Dec 2018

# Script input
program="$1"

# Compile script
gcc "${program}" -Wall -o "${program}.out"

# Run script
./"${program}.out"