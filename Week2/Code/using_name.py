#!/usr/bin/env python3

""" A simple program to demonstrate how a file can be used 
    as both a script and an importable module """

__appname__ = 'using_name.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Functions ##
if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')