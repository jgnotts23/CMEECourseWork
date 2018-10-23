#!/usr/bin/env Rscript
library(tools)

args <- commandArgs(trailingOnly = TRUE)
file_in <- args[1]
MyData <- read.csv(file = file_in, header = TRUE) 

for (i in MyData){ #i here just means for the 'ith' row
        radians <- MyData$Angle.degrees * pi / 180 # Referencing columns directly
        height <- MyData$Distance.m * tan(radians)
        Tree.Height.m <- c(height) # Make a new vector called Tree,height.m
}

tree.heights <- data.frame(MyData, Tree.Height.m)

file_out <- basename(file_path_sans_ext(file_in))

write.csv(tree.heights, paste0("../Results/", file_out, "_treeheights", ".csv"))


# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:  The angle of elevation of tree
# distance: The distance from base of tree (e.g., metres)
#
# OUTPUT
# The heights of the tree, same units as "distance"
