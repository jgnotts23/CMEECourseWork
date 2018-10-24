###############################
README - CMEE Coursework Week 3
###############################

### Description ###

This directory and its subsidaries contains the code created in week 3 of the Computational Methods in Ecology and Evolution MSc at Imperial College London. Some code was provided by my supervisor, Samraat Pawar, and the rest is original content. Subdirectories have been created entitled 'Code', 'Data', 'Results' and 'Sandbox'. 'Code' contains several scripts, predominantly in R. 'Data' contains some data that was used to test some of the scripts and 'Results' is where any script outputs will appear. 'Sandbox' was created for practice purposes and can be ignored. The purpose of this project was to learn basic R coding.

### Code ###

> apply1.R
A script demonstrating the use of apply to apply the same function to rows/columns of a matrix.

> apply2.R
A script showing how you can use apply to define your own functions

> basic_io.R
A simple script to demonstrate how to input and output files in R. A warning may show because the scipt appends column names to a file that already has column names but this is to be expected.

> boilerplate.R
A boilerplate R script which demonstrates the use of basic functions and arguments. Should return 4 arguments and print their data type.

> break.R
A script demonstrating the use of a break in R to break out of a loop. When i = 20, the loop will stop.

> browse.R
A script demonstrating the use of browse in R. The script will run until the first iteration of the loop, at which point the console enters browser mode where variables present at that point can be examined. Enter 'Q' to quit.

> control.R
Some code demonstrating control flow statements in R. 

> DataWrang.R
A script demonstrating how to wrangle data in R.

> DataWrangTidy.R
A script demonstrating the use of tidyr and dplyr in R to wrangle data. Both packages are required to run this script

> get_TreeHeight.R
A modified version of TreeHeight.R that allows any .csv file to be used as an input and will output results in the Results directory. A modified version of the input file name is used for identification. The script should be run in the command like using Rscript and an input file needs to be specified.

> map.R
A script that creates a world map and plots species locations on it. The R maps package is required to run this.

> next.R
A script demonstrating the use of next to move to the next iteration of a loop.
For numbers between 1 and 10 it will print only odd numbers.

> preallocate.R
A script demonstrating the use of preallocation in R to speed up processes. The first output is a function without preallocation and the second is a function that uses preallocation. Preallocation reduces the system time drastically.

> run_get_TreeHeight.sh
Unix shell script that tests get_TreeHeight.R, using the example input, trees.csv from the Data directory.

> sample.R
A sample R script that generates a random population and samples it using vectorisation and for loops. Mean of each population is only calculated if the sample size > 30.

> TAutoCorr.R
A script that examines temperature in Florida over the 20th century. The correlation coefficient between successive years is calculated and repeated 10000 times with random permutations. A histogram is plotted and outputted to the Data directory. A red line indicates a p-value approximation. The pdf in the Data directory entitled 'TAutoCorr.pdf' shows figure with annotations.

> try.R
A script demonstrating the use of try in R.

> TreeHeight.R
This script calculates the heights of trees given distance from base and angle to top. The script reads a file caled trees.csv in the Data directory and should output the results in a file called TreeHts.csv in the Results directory.

> Vectorize1.R
This script demonstrates how vectorisation can be used to speed up processes in R, rather than using loops. Two system times will be printed; the first for the loop and the second for the vector.

> Vectorize2.R
This script uses a stochastic Ricker model to demonstrate how vectorisation can improve process speed. The system times for both the non-vectorised and vectorised versions will be displayed.


### Dependencies ###

Everything in this project was created and run with the ubuntu 16.04 OS.
Most of the code was either entered directly into the UNIX terminal or saved as a shell script created in Visual Studio Code 1.27.2. R scripts were run in R 3.2.3.


### Authors/Contributors ###

Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
Samraat Pawar, s.pawar@imperial.ac.uk


### Useful Links ###

github CMEE Coursework repository: https://github.com/jgnotts23/CMEECourseWork


### .gitignore list ###

*~
*.tmp
