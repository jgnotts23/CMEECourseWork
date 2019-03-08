####################################
README - CMEE Coursework Miniproject
####################################

### Description ###

This directory and its subsidaries contains the code created for the Miniproject coursework of the Computational Methods in Ecology and Evolution MSc at Imperial College London. The purpose of this project was to fit models to the thermal responses of metabolic traits. The Code directory contains all script files, the Data directory has any files that the scripts require, and the Results directory is where all outputs will appear.

Code
- comparison.tex, a table used in the writeup.tex
- CompileLaTeX.sh, a bash script called by run_MiniProject.sh to compile the LaTeX, see Results for pdf
- converged.tex, a table used in the writeup.tex
- data_wrangling.R, script for all the pre-fitting aspects of the project
- Miniproject.bib, references for the LaTeX document
- model_comparison.R, comparitive statistics and plotting post-fitting
- model_fitting.py, the optimisation of model parameters for each dataset
- run_MiniProject.sh, the overall bash script that runs all the other scripts in the project
- writeup.tex, the LaTeX script for the final write-up


### Dependencies ###

Everything in this project was created and run with the ubuntu 16.04 OS. R scripts were run in R 3.2.3, Python in 3.5.2, and Bash in 4.3.48.


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


