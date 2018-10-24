load("../Data/KeyWestAnnualMeanTemperature.RData")
str(ats)
plot(ats)


ats1 <- 






ran_year <- sample_n(ats, 100, replace=FALSE)

doit <- function(x){
    cor(ran_year)
    }

result <- vector("list", 10000)
for(i in 1:10000) {
    result[[i]] <- try(doit(x), FALSE)
}

require(dplyr)

sample_n(ats, 100, replace=FALSE)



require(maps)

load("../Data/GPDDFiltered.RData")
str(gpdd)

map("world")