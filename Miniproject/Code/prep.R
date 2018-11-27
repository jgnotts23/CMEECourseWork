#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018
# Desc - Import data and prepare for NLLS fitting

# Clear and import
rm(list = ls())
graphics.off()

bio <- read.csv(file="../Data/BioTraits.csv")
