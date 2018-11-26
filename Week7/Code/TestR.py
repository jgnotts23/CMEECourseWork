#!/usr/bin/env python3

""" Example of how to use subprocess in python """

__appname__ = 'TestR.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

#backslahes so python can read as a single line
import subprocess
subprocess.Popen("/usr/lib/R/bin/Rscript --verbose TestR.R > \
../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout",\
 shell=True).wait()

