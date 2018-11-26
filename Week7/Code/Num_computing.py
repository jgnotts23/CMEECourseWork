#!/usr/bin/env python3

""" Learning numerical computing with Python """

__appname__ = 'Num_computing.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
# Scipy arrays can be stored in multiple dimensions:
# > Vectors 
# > Matrices
# > slices of Matrices
# Numpy arrays will always be a particular datatype (like R)
# Sometimes necessary to convert lists to numpy arrays
# ndarry = n-dimensional array
import scipy as sc # importing scipy and assining it to 'sc'

## Constants ##

## Functions ##
a = sc.array(range(5)) # a one-dimensional array
a

print(type(a)) # tells you it's a ndarry

print(type(a[0])) # What is at position 0? A 64-bit integer
# 64-bit means the iteger is stored at a higher precision

# You can specify the data type of an array
a = sc.array(range(5), float)
a

a.dtype # check type, it is a 64-bit float

# A 1-D array
x = sc.arange(5)
x

x = sc.arange(5.) # directly specify float using decimal
x
# Remember you can use x. then TAB to see all methods that can be applied to x
x.shape # shows dimensions of x
# Can use ?x.shape to get info on this method

# Converting to and from python lists
b = sc.array([i for i in range(10) if i%2==1]) #odd numbers between 1 and 0
b # an array

c = b.tolist() # convert back to list
c

# To make a matrix, you need a 2-D numpy array:
mat = sc.array([[0, 1], [2, 3]])
mat
mat.shape

### Indexing and accessing arrays ###
# Numpy arrays can be accessed using square brackets with the usual
# [row,column] reference. Indexing of numpy arrays starts at 0

mat[1] # accessing whole 2nd row

mat[:,1] # accessing whole second column

mat[0,0] # 1st row, 1st column element

mat[1,0] # 2nd row, 1st column element

mat[:,0] # accessing whole first column

# Python indexing also accepts negative values for going back 
# to the start from the end of an array

mat[0,1]

mat[0,-1]

mat[0,-2]

### Manipulating arrays ###
# The data associated with a numpy array object (its metdata - number of dimensions, 
# shape, data type, etc - as well as the actual data) are stored in homogenous and 
# contiguous (touching) block of memory (a "data buffer"), at a particular address in 
# the system's RAM. This makes numpy arrays more efficient than pure Python data structures
# like lists whose data are scattered across the system in memory

## Replacing, adding or deleting elements ##

mat[0,0] = -1 # replace a single element
mat

mat[:,0] = [12,12] # replace whole column
mat

sc.append(mat, [[12,12]], axis = 0) # append row, note axis specification

sc.append(mat, [[12], [12]], axis = 1) # append column

newRow = [[12,12]] #create new row

mat = sc.append(mat, newRow, axis = 0) #append that existing row
mat

sc.delete(mat, 2, 0) # delete 3rd row

# and concatenation:

mat = sc.array([[0, 1], [2, 3]])
mat0 = sc.array([[0, 10], [-1, 3]])
sc.concatenate((mat, mat0), axis = 0)


### Flattening or reshaping arrays ###
# You can also 'flatten' or 'melt' arrays, that is, change 
# array dimensions (e.g. from a matrix to a vector)

mat.ravel() # note: ravel is row-priority - happens row by row

mat.reshape((4,1)) # this is different from ravel

mat.reshape((3, 1)) # But total elements must remain the same
# different to R which 'recycles' data


### Pre-allocating arrays ###
# It is usually more efficient to preallocate an array rather than
# append/insert/concatenate additional elements, rows or columns.
# This is because you might run out of contiguous space in the RAM 
# address where the current array is stored. Preallocations allocates
# all the RAM you need in one call, while resizing the array (through append
# insert, concatenate, resize, etc.) may require copuing the array to a 
# larger block of memory, slowing things down, and significantly so if the 
# matrix/array is very large

# For example if you know the size of your matrix or array, you can 
# initialise it with ones or zeroes

sc.ones((4,2)) # (4,2) are the (row,col) array dimensions

sc.zeros((4,2)) # or zeros

m = sc.identity(4) # create an identity matrix
m

m.fill(16) # fill the matrix with 16
m

### numpy matrices ###
# Scipy/Numpy also has a matrix data structure class. Numpy matrices are 
# strictly 2-D, while numpy arrays are N-D. Matrix objects are a subclass of
# numpy arrays, so they inherit all the attributes and methods
# of numpy arrays (ndarrays)
# The main advantage of scipy matrices is that they provide a convenient
# notation for matrix multiplication: if a and b are matrices,
# then a * b is their matrix product

## Matrix-vector operations ##
mm = sc.arange(16) # create array (0-15)
mm = mm.reshape(4,4) # convert to matrix
mm

mm.transpose() #returns a view of array/matrix with axes transposed

mm + mm.transpose() # adding two matrices

mm - mm.transpose() # subtracting matrices

mm * mm.transpose() ## notes: elementwise multiplication

mm // mm.transpose() # integer division, warning because of division by 0

mm // (mm+1).transpose() # avoid division by zero

mm * sc.pi # by pi

mm.dot(mm) # matrix multiplication

mm = sc.matrix(mm) # convert to scipy matrix class
mm
print(type(mm))

mm * mm # now matrix multiplication is syntactically easier

### Useful scipy sub-packages ###
import scipy.linalg
import scipy.stats

scipy.stats.norm.rvs(size = 10) # 10 samples from N(0,1)

scipy.stats.randint.rvs(0, 10, size =7) # Randome integers between 0 and 10


### sc.integrate ###
# Numerical integration is the approximate computation of an integral
# using numerical techniques. You need numerical integration whenever you have
# a complicated function that cannot be integrated analytically using anti-derivatives.
