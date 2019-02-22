#!/usr/bin/env python3

""" Miniproject model fitting in python second attempt """

__appname__ = 'fitting2.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import numpy as np
from numpy import exp, sin
import pandas as pd
import lmfit
from lmfit import Minimizer, Parameters, minimize, report_fit
import matplotlib.pyplot as plt
from matplotlib import pylab
from scipy import stats
import csv

###############################
########### IMPORT ############
###############################
bio = pd.read_csv("../Data/bio_wrangled.csv")
MTD5398 = bio.loc[(bio.FinalID == "MTD5398")]
MTD3161 = bio.loc[(bio.FinalID == "MTD3161")]


###############################
######## DEFINITIONS ##########
###############################
k = 8.617e-5 # botzmann constant

x = np.array(MTD5398.Kelvins)
data = np.array(MTD5398.OriginalTraitValue)

# Cubic polynomial
def cubic(params, x, data):
    B0 = params['B0']
    B1 = params['B1']
    B2 = params['B2']
    B3 = params['B3']

    model = B0 + B1*x + B2*(x**2) + B3*(x**3)

    return model - data #return residuals

# Briere model
def Briere(params, x, data):
    B0 = params['B0']
    T0 = params['T0'] # minimum trait temp
    Tm = params['Tm'] # max trait temp

    model = (B0*x*(x-T0))*(abs(Tm-x)**(1/2))

    return model - data

# Schoolfield model (full)
def School(params, x, data):
    B0 = params['B0']
    E = params['E']
    El = params['El']
    Tl = params['Tl']
    Eh = params['Eh']
    Th = params['Th']

    model = B0 * (np.exp((-E / k) * ((1 / x) - (1 / 283.15))) / (1 + np.exp((El / k) * (1 / Tl - (1 / x))) + np.exp((Eh / k) * (1 / Th - (1 / x)))))

    return model - data

# Schoolfield model (El and Tl omitted)
def School_nolow(params, x, data):
    B0 = params['B0']
    E = params['E']
    Eh = params['Eh']
    Th = params['Th']

    model = (B0*(np.exp((-E/k)*((1/x)-(1/283.15))))) / (1 + (np.exp(Eh/k*((1/Th)-(1/x)))))

    return model - data

# Starting parameter calculator
def start_params(x, data):
    Tref = 283.15 #Reference temp
    pk_index = np.argmax(data)
    Tpk = x[pk_index] #Temp at which peak metabolic rate occurs

    # B0
    B0_indx = (np.abs(x - Tref)).argmin() #get index of nearest val to reference

    # Split data by Tpk and log-transform
    left_x = 1 / (k * (x[0:(pk_index+1)]))
    right_x = 1/ (k * (x[pk_index:(x.size - 1)]))
    left_data = np.log(data[0:(pk_index+1)])
    right_data = np.log(data[pk_index:(x.size - 1)])

    # Linear regression on log-transformed data
    slopeL, interceptL, r_valueL, p_valueL, std_errL = stats.linregress(left_x, left_data)
    slopeR, interceptR, r_valueR, p_valueR, std_errR = stats.linregress(right_x, right_data)
   
    E = slopeL
    Eh = slopeR

    # Calculate Th and reverse log-transformation
    Th = ((((np.mean(right_data)) - interceptR) / (slopeR))**(-1)) / k

    cubic_params = Parameters()
    cubic_params.add('B0', value=270)
    cubic_params.add('B1', value=2)
    cubic_params.add('B2', value=2)
    cubic_params.add('B3', value=2)

    Briere_params = Parameters() 
    Briere_params.add('B0_Briere', value=2)
    Briere_params.add('T0', value=min(x))
    Briere_params.add('Tm', value=max(x))

    School_params = Parameters()
    School_params.add('B0_School', value=10)
    School_params.add('E', value=E)
    School_params.add('Eh', value=Eh)
    School_params.add('Th', value=Th, min=Tpk)


    return cubic_params, Briere_params, School_params

def vals():
    #initial values
    a = cubic_params.valuesdict()
    Init_B0 = a[0]
    Init_B1 = a[1]
    Init_B2 = a[2]
    Init_B3 = a[3]

    a = Briere_params.valuesdict()
    Init_B0_Briere = a[0]
    Init_T0 = a[1]
    Init_Tm = a[2]

    a = School_params.valuesdict()
    Init_B0_School = a[0]
    Init_E = a[1]
    Init_Eh = a[2]
    Init_Th = a[3]

    #final values
    a = cub_out.params.valuesdict()
    B0 = a[0]
    B1 = a[1]
    B2 = a[2]
    B3 = a[3]

    a = Briere_out.params.valuesdict()
    B0_Briere = a[0]
    T0 = a[1]
    Tm = a[2]

    a = School_out.params.valuesdict()
    B0 = a[0]
    B1 = a[1]
    B2 = a[2]
    B3 = a[3]

    #stats

    return

###### Full run with one dataset ######
proper_fit = pd.DataFrame(columns=('Init_B0', 'B0', 'Init_B1', 'B1', 'Init_B2', 'B2', 'Init_B3', 'B3', 'Init_B0_Briere', 'B0_Briere', 'Init_T0', 'T0', 'Init_Tm', 'Tm', 'Init_B0_School', 'B0_School', 'Init_E', 'E', 'Init_Eh', 'Eh', 'Init_Th', 'Th'))


# for i in FinalID:

# Assign variables
x = np.array(x)
data = np.array(data)

cubic_params, Briere_params, School_params = start_params(x, data)

# Fit models
cub_out = minimize(cubic, cubic_params, args=(x, data))
lmfit.printfuncs.report_fit(cub_out.params, min_correl=0.5)

Briere_out = minimize(Briere, Briere_params, args=(x, data))
lmfit.printfuncs.report_fit(Briere_out.params, min_correl=0.5)

School_out = minimize(School_nolow, School_params, args=(x, data))
lmfit.printfuncs.report_fit(School_out.params, min_correl=0.5)



###################
##### OUTPUT ######
###################



bio.to_csv('../Data/test.csv')



plt.close()
plt.plot(x, data, 'x')
plt.plot(x, School(out.params, x, data) + data, 'r')
plt.show()
