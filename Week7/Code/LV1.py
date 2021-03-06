#!/usr/bin/env python3

""" The Lokta-Volterra model """

__appname__ = 'LV1.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

### The Lokta-Volterra model ###

import scipy.integrate as integrate
import scipy as sc
import sys

# Defining a function that returns the growth rate of 
# consumer and resource population at any given step:
def dCR_dt(pops, t=0):
        """ Returns growth rate of consumer and resource
        at any given step """

        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C
        dCdt = -z * C + e * a * R * C

        return sc.array([dRdt, dCdt])


# Parameter values
try:
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
except (IndexError, ValueError): #Defaults
        r = 1.
        a = 0.1
        z = 0.6
        e = 0.75

# Define time vector; integrate from time
# point 0 to 15, using 1000 sub-divisions of time:
t = sc.linspace(0, 60, 1000) # time units are arbitary

# Set initial conditions for the two populations 
R0 = 10
C0 = 5
RC0 = sc.array([R0, C0])

# Numerically integrate system with those starting conditions:
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
## infodict is a dictionary with additional information

### Plotting in Python ###

import matplotlib.pylab as p

# Open empty figure object (like in ggplot in R)
f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1] , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics \n' 
        "r= {},".format(str(r)) + "  a= {},".format(str(a)) + "  z= {},".format(str(z)) + "  e= {}".format(str(e)))

f1.savefig('../Results/LV1_model1.pdf') # Save figure

#### Resource density x Consumer density ####
f1 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
p.title('Consumer-Resource population dynamics \n' 
        "r= {},".format(str(r)) + "  a= {},".format(str(a)) + "  z= {},".format(str(z)) + "  e= {}".format(str(e)))

f1.savefig('../Results/LV1_model2.pdf') # Save figure