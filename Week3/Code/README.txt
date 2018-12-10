###################################
README - CMEE Coursework Week2 CODE
###################################
.
├── apply1.R
	Demonstrating the use of apply to apply the same function to rows/columns of a matrix
├── apply2.R
	Showing how you can use apply to define your own functions
├── basic_io.R
	A simple script to demonstrate how to input and output files in R. A warning may show 		because the scipt appends column names to a file that already has column names but this 	is to be expected
├── basic_plot.R
	Demonstrating the plotting function in R
├── boilerplate.R
	A boilerplate R script which demonstrates the use of basic functions and arguments. 		Should return 4 arguments and print their data type
├── break.R
	A script demonstrating the use of a break in R to break out of a loop. When i = 20, the 	loop will stop
├── browse.R
	A script demonstrating the use of browse in R. The script will run until the first 		iteration of the loop, at which point the console enters browser mode where variables 		present at that point can be examined. Enter 'Q' to quit
├── control.R
	Demonstrating control flow statements in R 
├── DataWrang.R
	Demonstrating how to wrangle data in R
├── DataWrangTidy.R
	A script demonstrating the use of tidyr and dplyr in R to wrangle data. Both packages 		are required to run this script
├── get_TreeHeight.py
	A python equivalent of get_TreeHeight.R
├── get_TreeHeight.R
	A modified version of TreeHeight.R that allows any .csv file to be used as an input and 	will output results to the Results directory. A modified version of the input file name 	is used for identification. The script should be run in the command like using Rscript 		and an input file needs to be specified
├── map.R
	A script that creates a world map and plots species locations on it. The R maps package 	is required to run this
├── MyBars.R
	Using ggplot to plot bargraphs
├── next.R
	A script demonstrating the use of next to move to the next iteration of a loop.
	For numbers between 1 and 10 it will print only odd numbers
├── plotLin.R
	Demonstrates how to annotate a plot in R, output to Results directory
├── poundhill_example.R
	Practice loading datasets into R
├── PP_Lattice.R
	A script that creates three lattice graphs based on feeding interaction data. Mean and 		medians are calculated in each instance and saved to a csv file. All outputs will appear 		in the Results directory
├── PP_Regress.R
	A script that reproduces a figure shown by my demonstrater, S. Pawar. Output to the 		Results directory
├── preallocate.R
	A script demonstrating the use of preallocation in R to speed up processes. The first 		output is of a function without preallocation and the second is a function that uses 		preallocation. Preallocation reduces the system time drastically
├── run_get_TreeHeight.sh
	Unix shell script that tests get_TreeHeight.R and get_TreeHeight.py, using the example 		input, trees.csv from the Data directory.
├── sample.R
	A sample R script that generates a random population and samples it using vectorisation 	and for loops. Mean of each population is only calculated if the sample size > 30
├── SQLinR.R
	Some practice using SQLite in R
├── TAutoCorr.R
	A script that examines temperature in Florida over the 20th century. The correlation 		coefficient between successive years is calculated and repeated 10000 times with random 	permutations. A histogram is plotted and outputted to the Results directory. A red line 	indicates a p-value approximation. The pdf 'TAutoCorr.pdf' shows figure with annotations
├── TAutoCorr.tex
	Code for a LaTeX document with the figure from TAutoCorr.R in it with annotations
├── TreeHeight.R
	This script calculates the heights of trees given distance from base and angle to top. 		The script reads a file caled trees.csv in the Data directory and should output the 		results in a file called TreeHts.csv in the Results directory
├── try.R
	A script demonstrating the use of try in R
├── Vectorize1.py
	A python equivalent of Vectorize1.R
├── Vectorize1.R
	This script demonstrates how vectorisation can be used to speed up processes in R, 		rather than using loops
├── Vectorize2.py
	A python equivalent of Vectorize2.R
├── Vectorize2.R
	This script uses a stochastic Ricker model to demonstrate how vectorisation can improve 	process speed
└── Vectorize_speed.sh
	This script compares the speeds of Vectorize1.R, Vectorize1.py, Vectorize2.R and 		Vectorize2.py.

0 directories, 33 files
