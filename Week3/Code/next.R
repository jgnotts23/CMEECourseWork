#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# A script demonstrating the use of next to move to the next iteration of a loop

for (i in 1:10) {
    if ((i %% 2) == 0)
        next # pass to next iteration of loop
    print(i)
}