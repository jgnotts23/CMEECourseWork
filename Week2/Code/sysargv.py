#!/usr/bin/env python3

""" A simple program to demonstrate the function of sys.argv """

__appname__ = 'sysargv.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import sys

## Constants ##

## Functions ##
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))