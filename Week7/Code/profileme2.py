#!/usr/bin/env python3

""" A script demonstrating how to profile in python using list comprehensions,
    This is a profiled version of profileme.py """

__appname__ = 'profileme2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

# To find out what is slowing down your code you need to
# 'profile' your code: locate the sections of your code
# where speed bottlenecks exist

def my_squares(iters):
    """ Square every iteration """
    out = [i ** 2 for i in range(iters)] #list comprehension
    return out

def my_join(iters, string):
    """ Add all strings together """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ Set the arguments """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")