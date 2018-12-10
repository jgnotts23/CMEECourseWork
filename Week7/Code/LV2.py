#!/usr/bin/env python3

""" The Lotka-Volterra model with prey density-dependance
incorporated  """

__appname__ = 'LV2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

### The Lokta-Volterra model ###

import scipy.integrate as integrate
import scipy as sc
import sys
import matplotlib.pylab as p

# Defining a function that returns the growth rate of 
# consumer and resource population at any given step:
def dCR_dt(pops, t=0):
        """ Returns growth rate of consumer and resource
        at any given step """

        R = pops[0]
        C = pops[1]
        dRdt = r * R * (1 - R / K) - a * R * C #K is density-dependence
        dCdt = -z * C + e * a * R * C

        return sc.array([dRdt, dCdt])


# Parameter values
try:
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
        K = float(sys.argv[5])
except (IndexError, ValueError): #Defaults
        r = 1.
        a = 0.1
        z = 0.6
        e = 0.75
        K = 50.0

# Define time vector
t = sc.linspace(0, 100, 1000)

# Set initial conditions
R0 = 10
C0 = 5
RC0 = sc.array([R0, C0])

# Numerically integrate this system with those starting conditions:
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

# Calculate final R and C values
rd_final = round(pops[999][0], 2)
cd_final = round(pops[999][1], 2)

### Plotting ###

# Open empty figure object (like in ggplot in R)
f1 = p.figure()
ax = f1.add_subplot(111)
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1] , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.suptitle('Consumer-Resource Population Dynamics')
p.title("r = {},".format(str(r)) + "  a = {},".format(str(a)) + "  z = {},".format(str(z)) + "  e = {},".format(str(e)) + "  K = {}".format(str(K)) + "\nFinal resource density = {}".format(str(rd_final)) + ", Final consumer density = {}".format(str(cd_final)), fontsize=8)

f1.savefig('../Results/LV2_model1.pdf') # Save figure


#### Resource density x Consumer density ####
f1 = p.figure()

p.plot(pops[:,0], pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.suptitle('Consumer-Resource Population Dynamics')
p.title("r = {},".format(str(r)) + "  a = {},".format(str(a)) + "  z = {},".format(str(z)) + "  e = {},".format(str(e)) + "  K = {}".format(str(K)) + "\nFinal resource density = {}".format(str(rd_final)) + ", Final consumer density = {}".format(str(cd_final)), fontsize=8)

f1.savefig('../Results/LV2_model2.pdf') # Save figure