###############################
README - CMEE Coursework Week 7
###############################

### Description ###

This directory and its subsidaries contains the code created in week 7 of the Computational Methods in Ecology and Evolution MSc at Imperial College London. Some code was provided by my supervisor, Samraat Pawar, and the rest is original content. Subdirectories have been created entitled 'Code', 'Data', 'Results' and 'Sandbox'. 'Code' contains several python scripts. 'Data' contains some data that was used to test some of the scripts and 'Results' is where any script outputs will appear. 'Sandbox' was created for practice purposes and can be ignored. The purpose of this project was to learn basic python coding.

### Code ###

> blackbirds.py
A practical example of using regular expressions to find matches in a dataset. Kingdom, Phylum and species will be printed on screen for four blackbird species.

> DrawFW.py
A script that plots food web networks. Outputs in the Results directory are called sizedist.pdf and network.pdf

> fmr.R
An R script that creates a graph and outputs to the Results directory, fmr_plot.pdf. This is an example script that is used in run_fmr.py

> Num_computing.py
A script that outlines how numerical computing can be done with python. Includes manipulation of matrices and arrays.

> LV1.py
A script that runs the Lotka-Volterra model based on parameters provided by the user. Values for r, a, z and e can be entered in the command line when running the script, if not it will run with default values. Two figures, LV_model.pdf and LV_model2.pdf are output to the results directory.

>LV2.py
Similar to LV1.py but includes prey density-dependance in the model, K, which needs to be entered as an additional command-line argument. Outputs in the Results directory are called LV_model3.pdf and LV_model4.pdf.

> LV1LV2_run.sh
A bash script that runs LV1.py and LV2.py and prints system times for both.

> profileme.py
A example script that has bottlenecks that need to be identified. 

> profileme2.py
A profiled version of profileme.py which has reduced system time using list comprehension.

> regexs.py
A script explaining how to use regular expressions in python

> TestR.py
An example of how subprocess can be used to run R scripts within python

> timeitme.py
A script demonstrating use of the timeit module to improve speed.



### Dependencies ###

Everything in this project was created and run with the ubuntu 16.04 OS.
Most of the code was either entered directly into the UNIX terminal or saved as a shell script created in Visual Studio Code 1.27.2. Python scripts were run in ipython 3.5.2.


### Authors/Contributors ###

Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
Samraat Pawar, s.pawar@imperial.ac.uk


### Useful Links ###

github CMEE Coursework repository: https://github.com/jgnotts23/CMEECourseWork

### .gitignore list ###

*~
*.tmp
*.p
*.pyc
pickle
/Week5/Data/GIS_Practical_1_files
/Week3/Data/EcolArchives-E089-51-D1.csv
/Miniproject/Data/BioTraits.csv

