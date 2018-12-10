#!/usr/bin/env python3

""" Demonstrating how to index and print tuple elements """

__appname__ = 'tuple.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

print("Bird data created:")
print(birds)

print("\nListing by species:")
for item in birds:
  print("{} {} {}".format(item[0], item[1], item[2]))
