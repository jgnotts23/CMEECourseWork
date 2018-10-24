#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

## Mapping species data on a world map

require(maps)

load("../Data/GPDDFiltered.RData")
str(gpdd)

map("world", col="gray90", fill=TRUE)
points(gpdd$long, gpdd$lat, pch=19, col="red", cex=0.5)

# Data is bias because samples have only been taken in developed countries.
# There is also only a very small dataset