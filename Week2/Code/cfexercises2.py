#!/usr/bin/env python3

"""Some functions to practice the use of control statements"""

__appname__ = 'cfexercises2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import sys

## Constants ##

## Functions ##
def foo_1(x=1):
    """ Finds the value of a number, x, to the power of 0.5"""
    return "foo_1(2): %d ^ 0.5 = " % x + str(x ** 0.5)

def foo_2(x=2, y=1):
    """ Returns the highest number, x or y """ 
    if x > y:
        return "foo_2(2, 1): %d is higher" % x + " than %d" % y
    return "%d is higher" % y + " than %d" % x

def foo_3(x=3, y=2, z=1):
    """ Function that swaps x and y if x is bigger THEN swaps y and z if y is bigger """
    if x > y:
        tmp = y  # Assigning to a temporary variable
        y = x
        x = tmp
        print("x > y, therefore they swap!")
    if y > z:
        tmp = z
        z = y
        y = tmp
        print("y > z, therefore they swap!")
    return [x, y, z]

def foo_4(x=5):
    """ Calculates the factorial (!) of x """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return "foo_4(5): %d! = " % x + str(result)

def foo_5(x=5): 
    """ Alternative (recursive) function that calculates the factorial (!) of x """
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x=5):
    """ Using a while loop to calculate the factorial of x """ 
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(2))
    print(foo_2(3, 2))
    print(foo_3(3, 2, 1))
    print(foo_4(5))
    print(foo_5(5))
    print(foo_6(5))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)