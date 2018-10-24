#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Load packages #############
require(dplyr)
require(tidyr)

############# Inspect the dataset ###############
# dplyr converts data to tbl class which are easier to examine
# than data frames. R only displays the data that fits onscreen
dplyr::tbl_df(MyData)  #head(MyData)
dim(MyData)
# glimpse (dplyr) gives an information dense summary of tbl data
dplyr::glimpse(MyData)  #str(MyData)
# View shows the data in a spreadsheet-like display
utils::View(MyData)  #fix(MyData) #you can also do this
utils::View(MyData)  #fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
dplyr::tbl_df(MyData) #head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############
# still needed with dplyr
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package


MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), 
variable.name = "Species", value.name = "Count")

#MyWrangledData <- tidyr::gather(TempData, "Cultivation", "Block", "Plot", "Quadrat", "Species", "Count", 1:6)

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.numeric(MyWrangledData[, "Count"])

dplyr::glimpse(MyWrangledData)  #str(MyWrangledData)
dplyr::tbl_df(MyWrangledData) #head(MyWrangledData)
dim(MyWrangledData)