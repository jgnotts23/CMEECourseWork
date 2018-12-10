#!/usr/bin/env python3

""" A program that identifies oaks from a list of taxa. 
    A bug was initially present but has been removed and 
    doctests have been added to test the functions.  """

__appname__ = 'oaks_debugme.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import pandas as pd
import scipy as sc
import math
import os
import sys

pd.set_option("display.precision", 13)
MyData = pd.read_csv(sys.argv[1], sep=',', float_precision='round_trip')
MyDF = pd.DataFrame(data=MyData)

MyDF["Tree.Height.m"] = MyDF["Angle.degrees"].apply(lambda x: math.tan(x * (math.pi / 180)))
MyDF['Tree.Height.m'] = MyDF['Tree.Height.m']*MyDF['Distance.m']


# Stripping file extension of input file
name = os.path.splitext(os.path.basename(sys.argv[1]))[0]

# Writing new .csv with results in
MyDF.to_csv("../Results/" + name + "_treeheights_py.csv", float_format="%.13f")