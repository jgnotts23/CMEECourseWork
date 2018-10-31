# Load the data into R
# Using as.matrix, setting the header and using stringsAsFactors
# guarantees the data are imported "as is" so they can be wrangled
# read.csv will convert first row to column headers and convert everything to factors
# All data will be converted to character class in resulting matrix called MyData
# because at least one of the entries is already character class
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F, stringsAsFactors = F))

# Header is set to true because there are metadata headers
# Semicolon used as delimiter because there are commas in some field descriptions
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

# Check data class, should return 'matrix'
class(MyData)

# View top 6 rows
head(MyData)