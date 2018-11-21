#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

#Clear and import
rm(list = ls())
graphics.off()
library("ggplot2")
library(repr)
require("minpack.lm")

#Change default plot size
options(repr.plot.width=6, repr.plot.height=5)

# Trait = any measurable feature of an individual organism
# e.g. body mass, respiration rate, feeding preference
# A trait is functional if it directly (e.g. mortality rate)
# or indirectly (e.g. growth rate) determines individual fitness
