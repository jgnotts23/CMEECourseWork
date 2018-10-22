#!/usr/bin/env python3

""" A program that takes sequence data inputs from a csv file
    and finds the alignment with the highest score, outputting 
    the result to a text file. """

__appname__ = 'align_seqs.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import csv
import sys
import pdb
import doctest

## Constants ##

## Functions ##
# These are the two sequences to match
with open('../Data/sequences.csv','r') as csvfile:
    sequences = csv.reader(csvfile)
    seq2 = str(next(sequences)) # Specifying where the sequence data is in the file
    seq1 = str(next(sequences))

print(seq1)
print(seq2)

# assign the longest sequence s1, and the shortest to s2
# l1 is the length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# function that computes a score
# by returning the number of matches 
# starting from arbitrary startpoint
def calculate_score(s1, s2, l1, l2, startpoint):
    # startpoint is the point at which we want to start
    matched = "" # contains string for alignement
    score = 0
    for i in range(l2):
        #import ipd here to learn loops better
        if (i + startpoint) < l1:
            # if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # build some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print("")

    return score

calculate_score(s1, s2, l1, l2, 0)
calculate_score(s1, s2, l1, l2, 1)
calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score)
my_best_align = None
my_best_score = -1

for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z

print (my_best_align)
print (s1)
print ("Best score:", my_best_score)

# Writing best alignment to output file
with open('../Results/bestalignment.txt','w') as results:
    results.write(my_best_align + "\n")
    results.write(s1 + "\n")
    results.write("Best score:" + str(my_best_score))

results.close 
csvfile.close 