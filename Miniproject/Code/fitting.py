#!/usr/bin/env python3

""" Miniproject model fitting in python """

__appname__ = 'fitting.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.optimize import curve_fit


## Import data ##
bio = pd.read_csv("../Data/bio_wrangled.csv")

MTD5398 = bio.loc[(bio.FinalID == "MTD5398")]

plt.scatter(MTD5398.Kelvins, MTD5398.OriginalTraitValue)

## Model fitting ##
x = MTD5398.Kelvins
y = MTD5398.OriginalTraitValue


z = np.polyfit(x, y, 3)
cubic = np.poly1d(z)

# calculate new x's and y's
x_new = np.linspace(min(x), max(x), 100)
y_new = cubic(x_new)

plt.plot(x,y,'o', x_new, y_new)
plt.xlim([min(x), max(x)])
plt.show()




