#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# A scipt exemplifying the use of breaks in R

i <- 0 #Initialize i
    while(i < Inf) {
        if (i ==20) {
            break } # Break out of the while loop!
        else {
            cat("i equals " , i , "\n")
            i <- i + 1 # Update i
    }
}