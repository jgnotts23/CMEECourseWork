#!/usr/bin/env python3

""" A function that outputs a list of data from a tuple of tuples """

__appname__ = 'tuple.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##

## Constants ##
header = 'Species, Common_Name, Weight'
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

## Functions ##
for i in birds:
    print(*i)