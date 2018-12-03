#!/usr/bin/env python3

""" Basic operations and terminology in Python """

__appname__ = 'baby_steps.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'License for this code/program'

# Basic operations
2 + 2
2 * 2
2 / 2 # float division
2 // 2 # integer division
2 > 3 
2 >= 2

### Some terminology ###
# Workspace:	The "environment" of your current python session, including all variables, functions, objects, etc.
# Variable:	    A named number, text string, boolean (True or False), or data structure that can change (more on variable and data types later)
# Function:	    A computer procedure or routine that performs operations and returns some value(s), and which can be used again and again
# Module:	    Variables and functions packaged into a single set of programs that can be invoked as a re-useable command (potentially with sub-commands)
# Class:	    A way of grouping Variables and functions into a single object with specific properties that are inherited when you create its copy. 
#               Unlike modules, you can create ("spawn") many copies of a class within a python session or program
# Object:	    A particular instance of a class (every object belongs to a class) that is created in a session and eventually destroyed; everything in your workspace is an object in python!

### Magic commands ###
# %who	Shows current namespace (all variables, modules and functions)
# %whos	Also display the type of each variable; typing %whos function only displays functions etc.
# %pwd	Print working directory
# %history	Print recent commands

a = 1
type(a) # determine an objects type