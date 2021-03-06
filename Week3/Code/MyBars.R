#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018
# Desc - Using ggplot 


require(ggplot2)

a <- read.table("../Data/Results.txt", header = TRUE)
head(a)

a$ymin <- rep(0, dim(a)[1]) # append a column of zeros

# Print the first linerange
pdf("../Results/MyBars.pdf")
p <- ggplot(a) +
        geom_linerange(data = a, aes(
                          x = x,
                          ymin = ymin,
                          ymax = y1,
                          size = (0.5)
                          ),
                        colour = "#E69F00",
                        alpha = 1/2, show.legend = FALSE) +

# Print the second linerange
        geom_linerange(data = a, aes(
                          x = x,
                          ymin = ymin,
                          ymax = y2,
                          size = (0.5)
                          ),
                        colour = "#56B4E9",
                        alpha = 1/2, show.legend = FALSE) +

# Print the third linerange:
        geom_linerange(data = a, aes(
                          x = x,
                          ymin = ymin,
                          ymax = y3,
                          size = (0.5)
                          ),
                        colour = "#D55E00",
                        alpha = 1/2, show.legend = FALSE) +

# Annotate the plot with labels:
        geom_text(data = a, aes(x = x, y = -500, label = Label)) +

# now set the axis labels, remove the legend, and prepare for bw printing
        scale_x_continuous("My x axis",
                            breaks = seq(3, 5, by = 0.05)) + 
                            scale_y_continuous("My y axis") + 
                            theme_bw() + 
                            theme(legend.position = "none") 
p