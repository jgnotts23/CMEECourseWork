#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019
# Desc - Import data and prepare for NLLS fitting

# Clear and import
rm(list = ls())
graphics.off()

bio <- read.csv(file="../Data/BioTraits.csv")

# Subset to FinalID, OriginalTraitValue, ConTemp, AmbientTempUnit
bio <- bio[c(3, 8, 67, 68)]

# Remove negative and 0 zero trait values
bio <- bio[!is.na(bio$OriginalTraitValue),]
bio <- bio[!is.na(bio$ConTemp),]
#bio <- bio[bio$OriginalTraitValue > 0, ]

# Remove datasets with <5 data points
bio <- bio[bio$FinalID %in% names(table(bio$FinalID))[table(bio$FinalID) >= 5],]

# Convert celsius to kelvins
bio$Kelvins <- bio$ConTemp + 273.15 

# Save as csv 
write.csv(bio, file = "../Data/bio_wrangled.csv")






