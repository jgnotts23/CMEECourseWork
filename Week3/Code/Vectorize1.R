#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# A script demonstrating how vectorisation can be used to speed up processes

# Generate synthetic data
M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){  
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]){
        for (j in 1:Dimensions[2]){
            Tot <- Tot + M[i,j]
        }
    }
    return (Tot)
}


print(paste0("SumAllElements(M): ", as.numeric(system.time(SumAllElements(M))[3]), "s"))
print(paste0("sum(M): ", as.numeric(system.time(sum(M))[3]), "s"))