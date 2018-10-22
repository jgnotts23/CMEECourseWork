#!/usr/bin/env python3

""" A program demonstrating how bugs can form in a script """

__appname__ = 'debugme.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##

## Constants ##

## Functions ##
def createabug(x):
    y = x**4
    z = 0
    y = y/z
    return y

createabug(25)