#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019
# Desc - Import model fits, plot, and run comparitive statistics
library(methods)
# Clear workspace and import packages
rm(list = ls())
graphics.off()

library(ggplot2)
library(gridExtra)
library(xtable)

k <- 8.617e-5 # Boltzmann constant

# Read in fitted and wrangled data
wrangled <- read.csv("../Data/bio_wrangled.csv")
fitted_data <- read.csv("../Data/proper_fit.csv")

FinalIDs <- unique(fitted_data$FinalID) # list of final IDs

iter <- 0

### Plotting ###
for (i in FinalIDs) {
  iter <- iter + 1
  
  # Subset by FinalID
  dataset <- wrangled[wrangled$FinalID==i, ]
  optima <- fitted_data[fitted_data$FinalID==i, ]
  
  # Generate simulated x data
  x <- seq(min(dataset$Kelvin), max(dataset$Kelvin), 0.1)
  
  # Generate y values based on optimised parameters
  cub_y <- optima$B0 + (optima$B1*x) + (optima$B2*x^2) + (optima$B3*x^3)
  Briere_y <- (optima$B0_Briere*x*(x-optima$T0))*(abs(optima$Tm-x)^(1/2))
  School_y = (optima$B0_School*(exp((-optima$E/k)*((1/x)-(1/283.15))))) / (1 + (exp(optima$Eh/k*((1/optima$Th)-(1/x)))))
  cub <- data.frame(x, cub_y, Briere_y, School_y)
  
  # Plot and save to pdf
  pdf(paste("../Results/", i, ".pdf", sep="", collapse=""))
  print(ggplot(dataset, aes(Kelvin, OriginalTraitValue)) + geom_point(shape=4, size=2) +
    geom_line(data=cub, mapping=aes(x, cub_y, col='red')) +
    geom_line(data=cub, mapping=aes(x, Briere_y, col='blue')) +
    geom_line(data=cub, mapping=aes(x, School_y, col='green')) +
    xlab("Temp (Kelvin)") + ylab("Metabolic Trait") +
    scale_color_discrete(name = "Models", labels = c("Cubic", "Briere", "Schoolfield")))
  graphics.off()
  
}

graphics.off()

### Starting and converged values ###

# Table of converged values
B0 <- as.numeric(summary(fitted_data$B0)[3])
B1 <- as.numeric(summary(fitted_data$B1)[3])
B2 <- as.numeric(summary(fitted_data$B2)[3])
B3 <- as.numeric(summary(fitted_data$B3)[3])
B0_Briere <- as.numeric(summary(fitted_data$B0_Briere)[3])
T0 <- as.numeric(summary(fitted_data$T0)[3])
Tm <- as.numeric(summary(fitted_data$Tm)[3])
B0_School <- as.numeric(summary(fitted_data$B0_School)[3])
E <- as.numeric(summary(fitted_data$E)[3])
Eh <- as.numeric(summary(fitted_data$Eh)[3])
Th <- as.numeric(summary(fitted_data$Th)[3])

converged <- matrix(ncol=3, nrow=9)
colnames(converged) <- c("Cubic", "Briere", "Schoolfield")
rownames(converged) <- c("$B_0$", "$B_1$", "$B_2$", "$B_3$", "$T_0$", "$T_m$", "$E$", "$E_h$", "$T_h$")
converged[,1] <- c(B0, B1, B2, B3, "-", "-", "-", "-", "-")
converged[,2] <- c(B0_Briere, "-", "-", "-", T0, Tm, "-", "-", "-")
converged[,3] <- c(B0_School, "-", "-", "-", "-", "-", E, Eh, Th)

# Save table to .tex file
print(xtable(converged, type = "latex", caption = 'Median parameter estimates after optimisation'), 
      caption.placement = "top", 
      scalebox = 0.8,
      sanitize.text.function = function(x) {x},
      file = "converged.tex")
      
### Comparitive statistics ###
best_AICcs <- summary(fitted_data$Best_AICc)
best_R2 <- summary(fitted_data$Best_adjR2)

comparison <- matrix(nrow=3, ncol = 3)
colnames(comparison) <- c("Cubic", "Briere", "Schoolfield")
rownames(comparison) <- c("Best $AIC_c$", "Best adjusted $R^2$", "Average adjusted $R^2$")

comparison[1,] <- c(as.integer(best_AICcs[4]), as.integer(best_AICcs[1]), as.integer(best_AICcs[7]))
comparison[2,] <- c(as.integer(best_R2[2]), as.integer(best_R2[1]), as.integer(best_R2[3]))
comparison[3,] <- c(summary(fitted_data$cub_adjR2)[3], summary(fitted_data$Briere_adjR2)[3], summary(fitted_data$School_adjR2)[3])
comparison[1,] <- sub("\\.\\d+$", "", comparison[1,])
comparison <- xtable(comparison, type = "latex", caption = 'Summary of comparative statistics for the three models.
                     The first and second rows are counts and the third row is the median adjusted $R^2$')
print(comparison, file = "comparison.tex", sanitize.text.function = function(x) {x}, scalebox = 0.8,
      caption.placement = "top")




