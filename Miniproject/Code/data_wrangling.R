#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019
# Desc - Import data and prepare for NLLS fitting

# Clear workspace
rm(list = ls())
graphics.off()

# Global constants
K <- 8.617e-5 # Boltzmann constant
Tref <- 283.15 # Schoolfield reference temp

# Read in BioTraits
bio <- read.csv(file="../Data/BioTraits.csv")

# Subset to FinalID, OriginalTraitValue, ConTemp
bio <- bio[c(3, 8, 67)]

# Remove NAs
bio <- bio[!is.na(bio$OriginalTraitValue),]
bio <- bio[!is.na(bio$ConTemp),]

# Remove datasets with < 6 data points
bio <- bio[bio$FinalID %in% names(table(bio$FinalID))[table(bio$FinalID) >= 6],]

# Add column for Kelvin
bio$Kelvin <- bio$ConTemp + 273.15

# Set iteration counter
iter = 1

# Loop through each dataset within BioTraits and calculate starting parameters
for (i in unique(bio$FinalID)) {
  
  # Store temperature and trait values in temporary variables
  temp <- bio$Kelvin[bio$FinalID==i] 
  trait <- bio$OriginalTraitValue[bio$FinalID==i]
  
  # Remove datasets with less than 6 unique temperature values
  if (length(unique(temp)) < 6) {
    bio <- bio[-which(bio$FinalID==i),]
    next
  }
  
  # Make dataframe of temp and trait and order by temp value
  dataset <- data.frame(temp, trait)
  dataset <- dataset[order(temp), ] 
  
  # Adjust negative values
  if (min(dataset$trait) <= 0) {
    lowest <- abs(min(dataset$trait)) + 1e-10 # Establish lowest value and add 1e-10 to avoid zeros
    dataset$trait <- dataset$trait + lowest # Scale all values in dataset by this factor
    bio$OriginalTraitValue[bio$FinalID==i] <- bio$OriginalTraitValue[bio$FinalID==i] + lowest
  }
  
  # Calculate Tref and B0
  Tref_idx <- which(abs(dataset$temp - Tref)==min(abs(dataset$temp-Tref))) # closest temp value to 283.15 K
  bio$Tref[bio$FinalID==i] <- dataset$temp[Tref_idx[1]] # store Tref
  bio$B0[bio$FinalID==i] <- dataset$trait[Tref_idx[1]] # store corresponding B0
  
  # Calculate max trait and temp
  Bmax_idx <- which(dataset$trait == max(dataset$trait)) # index of trait max
  Tmax_idx <- which(dataset$temp == max(dataset$temp)) # index of temp max
  
  # Remove datasets with duplicates at Bmax and Tmax
  if (length(Bmax_idx) > 1 | length(Tmax_idx) > 1) {
    bio <- bio[-which(bio$FinalID==i),]
    next
  }
  
  # Assign T0
  bio$T0[bio$FinalID==i] <- min(dataset$temp)
  
  # Only split data if Bmax doesn't equal Tmax (i.e. trait has passed Tpk)
  if (Bmax_idx == Tmax_idx) { # i.e. the curve is still rising
    bio$Th[bio$FinalID==i] <- dataset$temp[Tmax_idx] # make Th equal Tmax
    
    # Arrhenius transformation
    log_trait <- log(dataset$trait)
    adj_temp <- 1 / K*dataset$temp
    regres <- lm(log_trait ~ adj_temp) # linear regression
    E <- abs(as.numeric(regres$coef[2])) # make E the gradient
    
    # Use defaults if E is either NA or out of 'reasonable' range
    if (is.na(E)) {
      bio$E[bio$FinalID==i] <- 0.65
    }
    else {
      if (1.2 > E && E > 0.2)
        bio$E[bio$FinalID==i] <- E
      else{
        bio$E[bio$FinalID==i] <- 0.65
      }
    }
    
    bio$Tm[bio$FinalID==i] <- dataset$temp[Tmax_idx] + 10
    bio$Eh[bio$FinalID==i] <- 2*bio$E[bio$FinalID==i]
  }
  else if (Bmax_idx == 1) {
    Bhalf <- dataset$trait[Bmax_idx] / 2 
    Bhalf_idx <- which(abs(dataset$trait - Bhalf)==min(abs(dataset$trait-Bhalf)))
    bio$Th[bio$FinalID==i] <- dataset$temp[Bhalf_idx[1]]
    
    right_trait <- dataset$trait
    right_temp <- dataset$temp
    
    log_trait <- log(right_trait)
    adj_temp <- 1 / K*right_temp
    regres <- lm(log_trait ~ adj_temp)
    Eh <- abs(as.numeric(regres$coef[2]))
    
    if (is.na(Eh)) {
      bio$Eh[bio$FinalID==i] <- 1.3
    }
    else {
      if (3 > Eh && Eh > 0.65)
        bio$Eh[bio$FinalID==i] <- Eh
      else{
        bio$Eh[bio$FinalID==i] <- 1.3
      }
    }
    
    bio$Tm[bio$FinalID==i] <- dataset$temp[Tmax_idx]
    bio$E[bio$FinalID==i] <- bio$Eh[bio$FinalID==i] / 2
  }
  
  else {
    # Find nearest trait value to Bmax/2 and assign Th to corresponding temp
    Bhalf <- dataset$trait[Bmax_idx] / 2
    Bhalf_idx <- which(abs(dataset$trait - Bhalf)==min(abs(dataset$trait-Bhalf)))
    bio$Th[bio$FinalID==i] <- dataset$temp[Bhalf_idx[1]]
    
    left_trait <- dataset$trait[1:Bmax_idx]
    left_temp <- dataset$temp[1:Bmax_idx]
    
    log_trait <- log(left_trait)
    adj_temp <- 1 / K*left_temp
    regres <- lm(log_trait ~ adj_temp)
    E <- abs(as.numeric(regres$coef[2]))
    
    if (is.na(E)) {
      bio$E[bio$FinalID==i] <- 0.65
    }
    else {
      if (1.2 > E && E > 0.2)
        bio$E[bio$FinalID==i] <- E
      else{
        bio$E[bio$FinalID==i] <- 0.65
      }
    }
    
    bio$Tm[bio$FinalID==i] <- dataset$temp[Tmax_idx]
    bio$Eh[bio$FinalID==i] <- 2*bio$E[bio$FinalID==i]
  }
  bio$Tpk[bio$FinalID==i] <- dataset$temp[Bmax_idx]
  
}


  
# Save as csv 
write.csv(bio, file = "../Data/bio_wrangled.csv")




