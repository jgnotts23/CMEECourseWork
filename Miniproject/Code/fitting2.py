#!/usr/bin/env python3

""" Miniproject model fitting in python second attempy """

__appname__ = 'fitting2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import numpy as np
from numpy import exp, sin
import pandas as pd
from lmfit import Minimizer, Parameters, minimize

## Read in data
bio = pd.read_csv("../Data/bio_wrangled.csv")
MTD5398 = bio.loc[(bio.FinalID == "MTD5398")]

## Function definitions
def cubic(params, x, data):
    B0 = params['B0']
    B1 = params['B1']
    B2 = params['B2']
    B3 = params['B3']

    model = B0 + B1*x + B2*(x**2) + B3*(x**3)

    return model - data


## Model fitting
params = Parameters()
params.add('B0', value=0.1)
params.add('B1', value=0.1)
params.add('B2', value=0.1)
params.add('B3', value=0.1)


x = np.array(MTD5398.Kelvins)
data = np.array(MTD5398.OriginalTraitValue)


out = minimize(cubic, params, args=(x, data))
