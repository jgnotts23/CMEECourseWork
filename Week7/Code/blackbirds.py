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

# Using regex to search
new = re.findall(r"Kingdom\s(\w+).+?Phylum\s(\w+).+?Species\s(\w+\s+\w+)", text)

df = pd.DataFrame(new, columns=["Kingdom", "Phylum" , "Species"])
print(df)