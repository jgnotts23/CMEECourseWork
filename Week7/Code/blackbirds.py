#!/usr/bin/env python3

""" A practical example of regular expression use """

__appname__ = 'blackbirds.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import re
import pandas as pd

# Read the file
f = open('../Data/blackbirds.txt', 'r')
text = f.read()
f.close()

# remove \t\n and put a space in:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

# note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform
# to ASCII:
#text = text.decode('ascii', 'ignore') #will not work in python 3

# Now extend this script so that it captures the Kingdom, 
# Phylum and Species name for each species and prints it out to screen neatly.

new = re.findall(r"Kingdom\s(\w+).+?Phylum\s(\w+).+?Species\s(\w+\s+\w+)", text)

df = pd.DataFrame(new, columns=["Kingdom", "Phylum" , "Species"])
print(df)

# Hint: you may want to use re.findall(my_reg, text)...
# Keep in mind that there are multiple ways to skin this cat! 
# Your solution may involve multiple regular expression calls (easier!), or a single one (harder!)