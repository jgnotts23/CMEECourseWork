#!/usr/bin/env python3

""" A demonstration of the use of loops and list comprehensions
    to output data from a tuple of tuples """

__appname__ = 'lc2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##

## Constants ##
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

print("Rainfall data in 1910 imported from met office (UK)")
print(rainfall)

## Functions ##
# List comprehensions
# Months when rain > 100mm
print("\nFinding months when rainfall exceeded 100mm with list comprehension...")
high_lc = set([item for item in rainfall if item[1] > 100])
print(high_lc)

# Months when rain < 50mm
print("\nFinding months when rainfall was below 50mm with list comprehension...")
low_lc = set([item[0] for item in rainfall if item[1] < 50])
print(low_lc)


# Conventional loops
# Months when rain > 100mm
print("\nFinding months when rainfall exceeded 100mm with a loop...")
high_loop = set()
for values in rainfall:
    if values[1] > 100:
        high_loop.add(values)

print(high_loop)

# Months when rain < 50mm
print("\nFinding months when rainfall was below 50mm with a loop...")
low_loop = set()
for values in rainfall:
    if values[1] < 50:
        low_loop.add(values[0])

print(low_loop)