#!/usr/bin/env python3

""" An application of loops and list comprehensions """

__appname__ = 'oaks.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Finds just those taxa that are oak trees from a list of species
## Constants ##
taxa = [ 'Quercus robur', 
         'Fraxinus exelsior', 
         'Pinus sylvestris', 
         'Quercus cerris', 
         'Quercus petraea',
        ]

## Functions ##
def is_an_oak(name):
    """ Returns all oak species """
    return name.lower().startswith('quercus ')

# Using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

# Using list comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

# Get names in UPPER CASE using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

# Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)