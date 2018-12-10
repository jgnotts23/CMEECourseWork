#!/usr/bin/env python3

""" A demonstration of the use of loops and list comprehensions
    to output data from a tuple of tuples """

__appname__ = 'lc1.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

### Constants ###
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )
 
### Functions ###
# List comprehensions
# Latin names
print("Bird data imported:")
print(birds)
print("\nFinding latin names with list comprehension...")
ln_lc = set([item[0] for item in birds])
print(ln_lc)

# Common names
print("\nFinding common names with list comprehension...")
cn_lc = set([item[1] for item in birds])
print(cn_lc)

# Mean body masses
print("\nFinding mean body masses with list comprehension...")
mbm_lc = set([item[2] for item in birds])
print(mbm_lc)


# Conventional loops
# Latin names
print("\nFinding latin names with a loop...")
ln_loop = set()
for values in birds:
    ln_loop.add(values[0])

print(ln_loop)

# Common names
print("\nFinding common names with a loop...")
cn_loop = set()
for values in birds:
    cn_loop.add(values[1])

print(cn_loop)

# Mean body masses
print("\nFinding mean body masses with a loop...")
mbm_loop = set()
for values in birds:
    mbm_loop.add(values[2])

print(mbm_loop)