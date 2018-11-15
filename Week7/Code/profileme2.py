#!/usr/bin/env python3

"""  """

__appname__ = 'profileme2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

# To find out what is slowing down your code you need to
# 'profile' your code: locate the sections of your code
# where speed bottlenecks exist

def my_squares(iters):
    out = [i ** 2 for i in range(iters)] #list comprehension
    return out

def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")