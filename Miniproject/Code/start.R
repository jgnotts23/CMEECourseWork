#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

library("readxl")
library("ggplot2")
require("minpack.lm") 

options(repr.plot.width=6, repr.plot.height=5)

my_data <- read_excel("../Data/DeLong_data.xlsx", sheet = 1)

Daphnia <- subset(my_data, Scientific.name == "Daphnia middendorffiana")

ggplot(Daphnia, aes(x = Temp, y = Rate)) + geom_point() #scatterplot
