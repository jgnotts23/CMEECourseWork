#!/usr/bin/env python3

""" Discrete-time version of The Lotka-Volterra model 
made in LV2.py """

__appname__ = 'LV3.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

### Discrete Lokta-Volterra model ###

import scipy.integrate as integrate
import scipy as sc
import sys
import scipy.stats
import matplotlib.pylab as p

# Defining discrete version of model:
def discrete_lv(R, C, t=0):
        """ Returns growth rate of consumer and resource
        at any given step """

        Rt = R
        Ct = C
        Rt2 = Rt * (1 + (r * (1 - (Rt / K))) - a * Ct)
        Ct2 = Ct * (1 - z + e * a * Rt)

        return sc.array([Rt2, Ct2])

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

# Set initial conditions
R0 = 10
C0 = 5
RC0 = sc.array([[R0, C0]])

# Loop through model
for i in range(100):
    pops = discrete_lv(RC0[-1][0], RC0[-1][-1])
    RC0 = sc.vstack((RC0, pops))
    if RC0[-1][0] < 0: #breaks for extinction
        print("Prey population went extinct at timepoint %i" % i)
        break
    if RC0[-1][-1] < 0:
        print("Predator population went extinct at timepoint %i" % i)
        break

# Define x limits
x_axis = range(len(RC0))

### Plotting in Python ###
# Open empty figure object (like in ggplot in R)
f1 = p.figure()
p.plot(x_axis, RC0[:,0], 'g-', label='Resource density')
p.plot(x_axis, RC0[:,1] , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics \n' 
        "r= {},".format(str(r)) + "  a= {},".format(str(a)) + "  z= {},".format(str(z)) + "  e= {},".format(str(e)) + "  K= {}".format(str(K)))

f1.savefig('../Results/LV3_model1.pdf') # Save figure


#### Resource density x Consumer density ####
f1 = p.figure()
p.plot(RC0[:,0], RC0[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics \n' 
        "r= {},".format(str(r)) + "  a= {},".format(str(a)) + "  z= {},".format(str(z)) + "  e= {},".format(str(e)) + "  K= {}".format(str(K))) 

f1.savefig('../Results/LV3_model2.pdf') # Save figure