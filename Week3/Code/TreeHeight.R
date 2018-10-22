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

# Importing dataframe from existing file
MyData <- read.csv("../Data/trees.csv", header = TRUE) # import with headers

# Creating a function to calculate tree height
for (i in MyData){ #i here just means for the 'ith' row
        radians <- MyData$Angle.degrees * pi / 180 # Referencing columns directly
        height <- MyData$Distance.m * tan(radians)
        Tree.Height.m <- c(height) # Make a new vector called Tree,height.m
}

# Creating a new dataframe 'tree.heights' with previous columns plus new column 'Tree.Height.m'
tree.heights <- data.frame(MyData, Tree.Height.m)

# Creating new .csv file for new dataframe
write.csv(tree.heights, "../Results/TreeHts.csv") #write it out as a new file
