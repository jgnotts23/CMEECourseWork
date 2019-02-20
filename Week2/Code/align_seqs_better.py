#!/usr/bin/env python3

""" Same as align_seqs_fasta.py but the output now contains
    all best alignments rather than just the first """

__appname__ = 'align_seqs_better.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import csv
import sys
import pdb
import doctest
import pickle

## Functions ##
# To extract names and sequences
def read_fasta(fp):
    """ Reads in a fasta file and extracts names and sequences """

    name, seq = None, []
    for line in fp:
        line = line.rstrip()
        if line.startswith(">"):
            if name: yield (name, ''.join(seq))
            name, seq = line, []
        else:
            seq.append(line)
    if name: yield (name, ''.join(seq))


# Assign and print
if len(sys.argv) > 1:
    with open(sys.argv[1]) as fp:
        for name, seq in read_fasta(fp):
            seq1 = seq
            name1 = name
            print("\nFASTA file 1:\n" + name)
    with open(sys.argv[2]) as fp:
        for name, seq in read_fasta(fp):
            seq2 = seq
            name2 = name
            print("\nFASTA file 2\n:\n" + name)
else:
    with open("../Data/407228326.fasta") as fp:
        for name, seq in read_fasta(fp):
            seq1 = seq
            name1 = name
            print("\nFASTA file 1:\n" + name)
    with open("../Data/407228412.fasta") as fp:
        for name, seq in read_fasta(fp):
            seq2 = seq
            name2 = name
            print("\nFASTA file 2:\n" + name)


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
    """ Calculates alignment scores given 2 sequences """
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

    return score

calculate_score(s1, s2, l1, l2, 0)
calculate_score(s1, s2, l1, l2, 1)
calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score)
my_best_align = None
my_best_score = -1

my_best_alignments = []
my_best_scores = []

for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z == my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z
        my_best_alignments.append(my_best_align)
        my_best_scores.append(my_best_score)
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z
        my_best_alignments.clear()
        my_best_scores.clear()
        my_best_alignments.append(my_best_align)
        my_best_scores.append(my_best_score)


with open('../Results/better_fasta_alignment.txt','w') as results:
    results.write(my_best_alignments[0] + "\n")
    results.write(s1 + "\n")
    results.write("Best score:" + str(my_best_scores[0]) + "\n\n")
results.close