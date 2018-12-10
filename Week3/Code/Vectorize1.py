#!/usr/bin/env python3

""" A script demonstrating how vectorisation can be used to speed up processes  """

__appname__ = 'Vectorize1.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'


import numpy as np
import timeit
import time

# Generate synthetic data
M = np.random.rand(1000,1000)

# Define function
def SumAllElements(M):
    """ """
    Dimensions = M.shape
    Tot = 0 
    for i in range(Dimensions[0]):
        for j in range(Dimensions[1]):
            Tot = Tot + M[i,j]
        
    return(Tot)

start = time.clock()
SumAllElements(M)
print("SumAllElements(M): %.3f" % (time.clock() - start) + "s")

start = time.clock()
M.sum()
print("M.sum(): %.3f" % (time.clock() - start) + "s")