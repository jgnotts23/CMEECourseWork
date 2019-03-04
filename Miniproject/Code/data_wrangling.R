#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019
# Desc - Import data and prepare for NLLS fitting

# Clear and import
rm(list = ls())
graphics.off()

library(dplyr)

# Global constants
K <- 8.617e-5
Tref <- 283.15

bio <- read.csv(file="../Data/BioTraits.csv")

# Subset to FinalID, OriginalTraitValue, Climate, Latitude, Longitude, ConTemp
bio <- bio[c(3, 8, 45, 50, 51, 67)]

# Remove NAs
bio <- bio[!is.na(bio$OriginalTraitValue),]
bio <- bio[!is.na(bio$ConTemp),]

# Remove datasets with <5 data points
bio <- bio[bio$FinalID %in% names(table(bio$FinalID))[table(bio$FinalID) >= 5],]
bio$Kelvin <- bio$ConTemp + 273.15

iter = 1
options(warn=2)


for (i in unique(bio$FinalID)) {
  print(i)
  
  # Store temperature and trait values
  temp <- bio$ConTemp[bio$FinalID==i] + 273.15 #Kelvin
  trait <- bio$OriginalTraitValue[bio$FinalID==i]
  
  # Adjust negative values
  if (min(trait) <= 0) {
    lowest <- min(trait)
    trait <- (trait + abs(lowest)) + 1e-10
    bio$trait_scalar[bio$FinalID==i] <- abs(lowest) + 1e-10
  }
  
  # Calculate Tref and B0
  Tref_idx <- which(abs(temp - Tref)==min(abs(temp-Tref))) #closest value to 283.15 K
  bio$Tref[bio$FinalID==i] <- temp[Tref_idx[1]]
  bio$B0[bio$FinalID==i] <- trait[Tref_idx[1]]
  
  # Calculate max trait and Th
  Bmax_idx <- which(trait == max(trait))
  Tmax_idx <- which(temp == max(temp))
  if (length(Bmax_idx) > 1 | length(Tmax_idx) > 1) {
    bio <- bio[-which(bio$FinalID==i),]
    print(paste(c(i, "Removed"), collape = " "))
    next
  }
  
  bio$T0[bio$FinalID==i] <- min(temp)
  
  # Only split data if Bmax doesn't equal Tmax (i.e. trait has passed Tpk)
  if (Bmax_idx == Tmax_idx) {
    bio$Th[bio$FinalID==i] <- temp[Tmax_idx]
    log_trait <- log(trait)
    adj_temp <- 1 / K*temp
    regres <- lm(log_trait ~ adj_temp)
    E <- abs(as.numeric(regres$coef[2]))
    
    if (is.na(E)) {
      bio$E[bio$FinalID==i] <- 0.65
    }
    else {
      bio$E[bio$FinalID==i] <- E
    }
    
    bio$Tm[bio$FinalID==i] <- temp[Tmax_idx] + 10
    bio$Eh[bio$FinalID==i] <- 2*bio$E[bio$FinalID==i]
  }
  else if (Bmax_idx == 1) {
    Bhalf <- trait[Bmax_idx] / 2
    Bhalf_idx <- which(abs(trait - Bhalf)==min(abs(trait-Bhalf)))
    bio$Th[bio$FinalID==i] <- temp[Bhalf_idx[1]]
    
    right_trait <- trait
    right_temp <- temp
    
    log_trait <- log(right_trait)
    adj_temp <- 1 / K*right_temp
    regres <- lm(log_trait ~ adj_temp)
    Eh <- abs(as.numeric(regres$coef[2]))
    
    if (is.na(Eh)) {
      bio$Eh[bio$FinalID==i] <- 1.3
    }
    else {
      bio$Eh[bio$FinalID==i] <- Eh
    }
    
    bio$Tm[bio$FinalID==i] <- temp[Tmax_idx]
    bio$E[bio$FinalID==i] <- bio$Eh[bio$FinalID==i] / 2
  }
  
  else {
    # Find nearest trait value to Bmax/2 and assign Th to corresponding temp
    Bhalf <- trait[Bmax_idx] / 2
    Bhalf_idx <- which(abs(trait - Bhalf)==min(abs(trait-Bhalf)))
    bio$Th[bio$FinalID==i] <- temp[Bhalf_idx[1]]
    
    left_trait <- trait[1:Bmax_idx]
    left_temp <- temp[1:Bmax_idx]
    
    log_trait <- log(left_trait)
    adj_temp <- 1 / K*left_temp
    regres <- lm(log_trait ~ adj_temp)
    E <- abs(as.numeric(regres$coef[2]))
    
    if (is.na(E)) {
      bio$E[bio$FinalID==i] <- 0.65
    }
    else {
      bio$E[bio$FinalID==i] <- E
    }
    
    bio$Tm[bio$FinalID==i] <- temp[Tmax_idx]
    bio$Eh[bio$FinalID==i] <- 2*bio$E[bio$FinalID==i]
  }
  bio$Tpk[bio$FinalID==i] <- temp[Bmax_idx]
  
  print(paste(c(iter, "Done!"), collape = " "))
  iter <- iter + 1
}


  
  
#bio$TraitScale <- bio$ConTemp + 273.15 

# Save as csv 
write.csv(bio, file = "../Data/bio_wrangled.csv")






