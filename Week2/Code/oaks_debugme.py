#!/usr/bin/env python3

""" A program that identifies oaks from a list of taxa. 
    A bug was initially present but has been removed and 
    doctests have been added to test the functions.  """

__appname__ = 'oaks_debugme.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import csv
import sys
import pdb
import doctest

## Constants ##

## Functions ##
def is_an_oak(name):
    """Finds whether a species is an oak or not

    >>> is_an_oak('Quercus robur')
    True

    >>> is_an_oak('Fraxinus excelsior')
    False

    >>> is_an_oak('Pinus sylvestria')
    False

    >>> is_an_oak('Quercus cerris')
    True

    >>> is_an_oak('Quercus petraea')
    True

    """
    return name.lower().startswith('quercus')

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    first_row = next(taxa) # Avoids the headers
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0])
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)