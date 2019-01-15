#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load R
module load intel-suite
echo "R is about to run"
R --vanilla < $HOME/jsg18_cluster.R
mv Output* $HOME
echo "R has finished running"
