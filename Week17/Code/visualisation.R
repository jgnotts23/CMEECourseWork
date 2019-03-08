#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019
# Desc - Import model fits and visualise

rm(list = ls())
graphics.off()

library(ggplot2)

k <- 8.617e-5

# Read in fitted data
wrangled <- read.csv("../Data/bio_wrangled.csv")
fitted_data <- read.csv("../Data/proper_fit.csv")

for (i in unique(wrangled$FinalID)) {
  # Plots
  #i <- "MTD2092"
  dataset <- wrangled[wrangled$FinalID==i, ]
  optima <- fitted_data[fitted_data$FinalID==i, ]
  
  # Optimised params
  x <- seq(min(dataset$Kelvin), max(dataset$Kelvin), 0.1)
  
  cub_y <- optima$B0 + (optima$B1*x) + (optima$B2*x^2) + (optima$B3*x^3)
  Briere_y <- (optima$B0_Briere*x*(x-optima$T0))*(abs(optima$Tm-x)^(1/2))
  School_y = (optima$B0_School*(exp((-optima$E/k)*((1/x)-(1/283.15))))) / (1 + (exp(optima$Eh/k*((1/optima$Th)-(1/x)))))
  cub <- data.frame(x, cub_y, Briere_y, School_y)
  
  # Plot
  pdf(paste("../Results/", i, ".pdf", sep="", collapse=""))
  print(ggplot(dataset, aes(Kelvin, OriginalTraitValue)) + geom_point(shape=4, size=2) +
    geom_line(data=cub, mapping=aes(x, cub_y, col='red')) +
    geom_line(data=cub, mapping=aes(x, Briere_y, col='blue')) +
    geom_line(data=cub, mapping=aes(x, School_y, col='green')) +
    ggtitle(i) +
    xlab("Temp (Kelvin)") + ylab("Metabolic Trait") +
    scale_color_discrete(name = "Models", labels = c("Cubic", "Briere", "Schoolfield")))
  graphics.off()
  
}

graphics.off()
