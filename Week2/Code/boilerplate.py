#!/usr/bin/env python3

""" A simple boilerplate to help learn python basics """

__appname__ = 'boilerplate.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'License for this code/program'

## Imports ##
import sys # Module to interface our program with the operating system

## Constants ##

## Functions ##
def main(argv):
    """ Main entry point of the program """
    print ('This is a boilerplate') 
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)