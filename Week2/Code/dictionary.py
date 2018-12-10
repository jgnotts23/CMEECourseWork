#!/usr/bin/env python3

""" A demonstration of how to create a dictionary and map
    it to a specified key """

__appname__ = 'dictionary.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Constants ##
taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

print("Taxa data created:")
print(taxa)

## Functions ##
print("\nPopulating dictionary to map species to Order name...")
taxa_dic = {x[1]:set() for x in taxa} # Create key with empty set
for species in taxa:
    taxa_dic[species[1]].add(species[0])
print(taxa_dic)
print("Done!")