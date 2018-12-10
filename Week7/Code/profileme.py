#!/usr/bin/env python3

""" This script is an example of code that can be profiled in python,
    profileme2.py is the profiled version of this """

__appname__ = 'profileme.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

# Define some functions to be profiled later

def my_squares(iters):
    """ Square every iteration """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """ Add all strings together """
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """ Set the arguments """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")