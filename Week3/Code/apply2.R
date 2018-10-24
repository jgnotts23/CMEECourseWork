#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# Using apply to define your own functions

SomeOperation <- function(v){  
    if (sum(v) > 0){
        return (v * 100)
    }
    return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))