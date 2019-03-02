#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019
# Desc - Import model fits and visualise

wrangled_data <- read.csv("../Data/bio_wrangled.csv")
test = wrangled_data[wrangled_data$FinalID == "MTD4294", ]

fitted_data <- read.csv("../Data/test.csv")

test <- fitted_data[fitted_data$FinalID == "MTD2852", ]


