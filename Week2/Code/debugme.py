#!/usr/bin/env python3

""" A program demonstrating how bugs can form in a script """

__appname__ = 'debugme.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import doctest

## Functions ##
def createabug(x):
    """ Create a bug in x by trying to divide by zero
      
    >>> createabug(25)
    'ZeroDivisionError: division by zero' """

    y = x**4
    z = 0
    y = y/z
    return y

createabug(25)