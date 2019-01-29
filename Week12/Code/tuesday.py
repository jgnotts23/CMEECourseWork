#!/usr/bin/env python3

"""  """

__appname__ = 'tuesday.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

x = np.linspace(-5, 5, 100)
def f(x, n):
    x = x+2
    return np.power(x,n)
for i in range(3):
    plt.plot(x, f(x, i))

plt.show()
