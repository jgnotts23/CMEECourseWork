#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# A script demonstrating how vectorisation can be used to speed up processes

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

## Takes about 1 second for Samraat
print(system.time(SumAllElements(M)))
## Takes about 0.01 seconds for Samraat
print(system.time(sum(M)))