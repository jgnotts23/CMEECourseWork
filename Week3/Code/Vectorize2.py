#!/usr/bin/env python3

""" Runs the stochastic (with gaussian fluctuations) Ricker Eqn. """

__appname__ = 'Vectorize2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'


import numpy as np
import timeit
import time

a = np.random.uniform(0.5, 1.5, 1000)
def stochrick(p0=np.random.uniform(0.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
    """ Stochrick model """
    N = np.full([numyears, len(p0)], fill_value=np.nan)
    N[0,] = p0

    for pop in range(len(p0)):
        for yr in range(1, numyears):
           N[yr,pop] = N[yr-1,pop]*np.exp(r*(1-N[yr-1,pop]/K)+np.random.normal(0,sigma))

    return(N)


def stochrickvect(p0=np.random.uniform(0.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
    """ Vectorized stochrick model """
    N = np.full([numyears, len(p0)], fill_value=np.nan)
    N[0,] = p0

    #for pop in range(len(p0)):
    for yr in range(1, numyears):
        N[yr,] = N[yr-1,]*np.exp(r*(1-N[yr-1,]/K)+np.random.normal(0,sigma,len(p0)))

    return(N)


start = time.clock()
stochrick()
print("stochrick(): %.3f" % (time.clock() - start) + "s")

start = time.clock()
stochrickvect()
print("stochrickvect(): %.3f" % (time.clock() - start) + "s")