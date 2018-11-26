#!/usr/bin/env python3

""" Using the subprocess module to search for files """

__appname__ = 'using_os.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        FilesDirsStartingWithC += re.findall(r"C.*", i)
    for i in subdir:
        FilesDirsStartingWithC += re.findall(r"C.*", i)
    for i in files:
        FilesDirsStartingWithC += re.findall(r"C.*", i)
print(FilesDirsStartingWithC)

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithCorc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        FilesDirsStartingWithCorc += re.findall(r"[Cc].*", i)
    for i in subdir:
        FilesDirsStartingWithCorc += re.findall(r"[Cc].*", i)
    for i in files:
        FilesDirsStartingWithCorc += re.findall(r"[Cc].*", i)
print(FilesDirsStartingWithCorc)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
DirsStartingWithCorc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        DirsStartingWithCorc += re.findall(r"[Cc].*", i)
    for i in subdir:
        DirsStartingWithCorc += re.findall(r"[Cc].*", i)

print(DirsStartingWithCorc)