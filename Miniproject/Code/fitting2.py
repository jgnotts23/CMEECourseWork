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
import math
import timeit

###############################
########### IMPORT ############
###############################
bio = pd.read_csv("../Data/bio_wrangled.csv")

###############################
######## DEFINITIONS ##########
###############################
k = 8.617e-5 # botzmann constant
Tref = 283.15 #Reference temp

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
    B0 = params['B0_Briere']
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
    B0 = params['B0_School']
    E = params['E']
    Eh = params['Eh']
    Th = params['Th']

    model = (B0*(np.exp((-E/k)*((1/x)-(1/283.15))))) / (1 + (np.exp(Eh/k*((1/Th)-(1/x)))))

    return model - data

# Starting parameter calculator
def start_params(x, data):

    # Split data by Tpk and log-transform
    try:
        pk_index = np.argmax(data)
        Tpk = x[pk_index] #Temp at which peak metabolic rate occurs

        # B0
        B0_indx = (np.abs(x - Tref)).argmin() #get index of nearest val to reference

        left_x = 1 / (k * (x[0:(pk_index+1)]))
        right_x = 1/ (k * (x[pk_index:(x.size)]))
        left_data = np.log(data[0:(pk_index+1)])
        right_data = np.log(data[pk_index:(x.size)])

        # Linear regression on log-transformed data
        slopeL, interceptL, r_valueL, p_valueL, std_errL = stats.linregress(left_x, left_data)
        slopeR, interceptR, r_valueR, p_valueR, std_errR = stats.linregress(right_x, right_data)
    
        E = slopeL
        if math.isnan(E):
            E = 0.65

        Eh = slopeR
        if math.isnan(Eh):
            Eh = 1.3

        # Calculate Th and reverse log-transformation
        Th = ((((np.mean(right_data)) - interceptR) / (slopeR))**(-1)) / k
        if math.isnan(Th):
            Th = np.argmax(x)

    except ValueError:
        E = 0.65
        Eh = 1.3
        Th = np.argmax(x)
        B0_indx = (np.abs(x - Tref)).argmin() #get index of nearest val to reference


    cubic_params = Parameters()
    cubic_params.add('B0', value=min(data))
    cubic_params.add('B1', value=0.1)
    cubic_params.add('B2', value=0.1)
    cubic_params.add('B3', value=0.1)

    Briere_params = Parameters() 
    Briere_params.add('B0_Briere', value=0.002)
    Briere_params.add('T0', value=min(x), min = (min(x)-100))
    Briere_params.add('Tm', value=max(x), max=(max(x)+100))

    School_params = Parameters()
    School_params.add('B0_School', value=data[B0_indx])
    School_params.add('E', value=E, max=Eh)
    School_params.add('Eh', value=Eh, min=E)
    School_params.add('Th', value=Th, min=Tpk, max=max(x + 100))


    return cubic_params, Briere_params, School_params

def add_vals(i):

    #initial values
    if cubic_params != 0:
        a = cubic_params.valuesdict()
        Init_B0 = a['B0']
        Init_B1 = a['B1']
        Init_B2 = a['B2']
        Init_B3 = a['B3']
    else:
        Init_B0 = 'NA'
        Init_B1 = 'NA'
        Init_B2 = 'NA'
        Init_B3 = 'NA'

    if Briere_params != 0:
        a = Briere_params.valuesdict()
        Init_B0_Briere = a['B0_Briere']
        Init_T0 = a['T0']
        Init_Tm = a['Tm']
    else:
        Init_B0_Briere = 'NA'
        Init_T0 = 'NA'
        Init_Tm = 'NA' 
        Briere_AIC = 'NA'
        Briere_BIC = 'NA'
        Briere_chi = 'NA'      

    if School_params != 0:
        a = School_params.valuesdict()
        Init_B0_School = a['B0_School']
        Init_E = a['E']
        Init_Eh = a['Eh']
        Init_Th = a['Th']

    else:
        Init_B0_School = 'NA'
        Init_E = 'NA'
        Init_Eh = 'NA'
        Init_Th = 'NA'

    #final values
    if cub_out != 0:
        a = cub_out.params.valuesdict()
        B0 = a['B0']
        B1 = a['B1']
        B2 = a['B2']
        B3 = a['B3']
        cub_AIC = cub_out.aic 
        cub_BIC = cub_out.bic
        cub_chi = cub_out.chisqr
    else:
        B0 = 'NA'
        B1 = 'NA'
        B2 = 'NA'
        B3 = 'NA' 
        cub_AIC = 'NA' 
        cub_BIC = 'NA'
        cub_chi = 'NA'     

    if Briere_out != 0:
        a = Briere_out.params.valuesdict()
        B0_Briere = a['B0_Briere']
        T0 = a['T0']
        Tm = a['Tm']
        Briere_AIC = Briere_out.aic 
        Briere_BIC = Briere_out.bic
        Briere_chi = Briere_out.chisqr
    else:
        B0_Briere = 'NA'
        T0 = 'NA'
        Tm = 'NA'
        Briere_AIC = 'NA'
        Briere_BIC = 'NA'
        Briere_chi = 'NA' 

    if School_out != 0:
        a = School_out.params.valuesdict()
        B0_School = a['B0_School']
        E = a['E']
        Eh = a['Eh']
        Th = a['Th']
        School_AIC = School_out.aic 
        School_BIC = School_out.bic
        School_chi = School_out.chisqr

    else:
        B0_School = 'NA'
        E = 'NA'
        Eh = 'NA'
        Th = 'NA'
        School_AIC = 'NA'
        School_BIC = 'NA'
        School_chi = 'NA'

    new_row = pd.Series([i, Init_B0, B0, Init_B1, B1, Init_B2, B2, Init_B3, B3, Init_B0_Briere, B0_Briere, Init_T0, T0, Init_Tm, Tm, Init_B0_School, B0_School, Init_E, E, Init_Eh, Eh, Init_Th, Th, cub_AIC, cub_BIC, cub_chi, Briere_AIC, Briere_BIC, Briere_chi, School_AIC, School_BIC, School_chi, cub_R2, Briere_R2, School_R2], index=(colnames))

    return new_row

def Gaussian(School_out, School_params):
    # Make aic of starting params the current best
    #best_aic = School_out.aic
    best_R2 = r_squared(School_out, data)
    a = School_out.params.valuesdict()
    best_E = a['E']
    
    # See if current best is better than default:
    School_params.add('E', value=0.65, max=(1.30))
    School_out = minimize(School_nolow, School_params, args=(x, data))
    new_R2 = r_squared(School_out, data)
    if new_R2 > best_R2:
        best_R2 = new_R2
        a = School_out.params.valuesdict()
        best_E = a['E']

    School_params.add('E', value=best_E, max=(2*best_E))

    i = 0
    # Draw from a random distribution with mean E
    while i < 5:
        new_E = np.random.normal(best_E, 1)
        School_params.add('E', value=new_E, max=(2*new_E))
        try:
            School_out = minimize(School_nolow, School_params, args=(x, data))
            #new_aic = School_out.aic
            new_R2 = r_squared(School_out, data)

            if new_R2 > best_R2:
                best_R2 = new_R2
                a = School_out.params.valuesdict()
                best_E = a['E']

        except ValueError:
            continue
        
        #print(best_E)
        #print(best_aic)
        i = i + 1

    
    School_params.add('E', value=best_E, max=2*best_E)

    return School_out, School_params

def r_squared(output, data):

    a = 1 - output.redchi / np.var(data)

    return a

#######################################
############### Fitting ###############
#######################################

FinalIDs = np.unique(bio.FinalID)
colnames = ('FinalID', 'Init_B0', 'B0', 'Init_B1', 'B1', 'Init_B2', 'B2', 'Init_B3', 'B3', 'Init_B0_Briere', 'B0_Briere', 'Init_T0', 'T0', 'Init_Tm', 'Tm', 'Init_B0_School', 'B0_School', 'Init_E', 'E', 'Init_Eh', 'Eh', 'Init_Th', 'Th', 'cub_AIC', 'cub_BIC', 'cub_chi', 'Briere_AIC', 'Briere_BIC', 'Briere_chi', 'School_AIC', 'School_BIC', 'School_chi', 'cub_R2', 'Briere_R2', 'School_R2')
proper_fit = pd.DataFrame(columns=(colnames))
iteration = 0


for i in FinalIDs:
    iteration = iteration + 1
    dataset = bio.loc[(bio.FinalID == i)]

    # Assign variables
    x = np.array(dataset.Kelvins)
    data = np.array(dataset.OriginalTraitValue)

    # Scale any negatives
    if min(data) < 0:
        lowest = min(data)
        data = data + np.abs(lowest)

    try:
        cubic_params, Briere_params, School_params = start_params(x, data)
    except ValueError:
        School_params = 0

    # Fit models
    if cubic_params != 0:
        try:
            cub_out = minimize(cubic, cubic_params, args=(x, data))
            cub_R2 = r_squared(cub_out, data)
        except ValueError:
            cub_out = 0
            cub_R2 = 'NA'

    if Briere_params != 0:
        try:
            Briere_out = minimize(Briere, Briere_params, args=(x, data))
            Briere_R2 = r_squared(Briere_out, data)
        except ValueError:
            Briere_out = 0
            Briere_R2 = 'NA'
    
    if School_params != 0:
        try:
            School_out = minimize(School_nolow, School_params, args=(x, data))
            # plt.plot(x, data, 'x')
            # plt.plot(x, School_nolow(School_out.params, x, data) + data, 'r')
            # plt.show()
            School_R2 = r_squared(School_out, data)
            
            if School_R2 < 0.7:
                try:
                    School_out, School_params = Gaussian(School_out, School_params)
                    School_R2 = r_squared(School_out, data)
                except ValueError:
                    School_out = 0
                    School_R2 = 'NA' 

        except ValueError:
            #School_out = 0
            #R2 = 'NA'
            try:
                School_out, School_params = Gaussian(School_out, School_params)
                School_R2 = r_squared(School_out, data)
            except ValueError:
                School_out = 0
    
    new_row = add_vals(i)
    proper_fit = proper_fit.append(new_row, ignore_index=True)
    print("Fit " + str(iteration) + " complete")





###################
##### OUTPUT ######
###################


proper_fit.to_csv('../Data/test.csv')







##### Testing #####

test = bio.loc[(bio.FinalID == "MTD3631")]

# Assign variables
x = np.array(test.Kelvins)
data = np.array(test.OriginalTraitValue)

cubic_params, Briere_params, School_params = start_params(x, data)

School_out = minimize(School_nolow, School_params, args=(x, data))
lmfit.printfuncs.report_fit(School_out.params, min_correl=0.5)


plt.close()
plt.plot(x, data, 'x')
plt.plot(x, School_nolow(School_out.params, x, data) + data, 'r')
plt.show()

