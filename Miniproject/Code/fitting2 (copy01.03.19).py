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
import time
import cProfile

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
def cubic(params, Celsius, trait):
    x = Celsius
    B0 = params['B0']
    B1 = params['B1']
    B2 = params['B2']
    B3 = params['B3']

    model = B0 + B1*x + B2*(x**2) + B3*(x**3)

    return model - trait #return residuals

# Briere model
def Briere(params, Celsius, trait):
    x = Celsius
    B0 = params['B0_Briere']
    T0 = params['T0'] # minimum trait temp
    Tm = params['Tm'] # max trait temp

    model = (B0*x*(x-T0))*(abs(Tm-x)**(1/2))

    return model - trait


# Schoolfield model (El and Tl omitted)
def School_nolow(params, Kelvin, trait):
    x = Kelvin
    B0 = params['B0_School']
    E = params['E']
    Eh = params['Eh']
    Th = params['Th']

    model = (B0*(np.exp((-E/k)*((1/x)-(1/283.15))))) / (1 + (np.exp(Eh/k*((1/Th)-(1/x)))))

    return model - trait

# Starting parameter calculator
def start_params(Celsius, Kelvin, trait):

    # x = Kelvin
    # C = Celsius
    # # Split data by Tpk and log-transform
    # try:
    #     pk_index = np.argmax(trait)
    #     Tpk = x[pk_index] #Temp at which peak metabolic rate occurs

    #     # B0
    #     B0_indx = (np.abs(x - Tref)).argmin() #get index of nearest val to reference

    #     left_x = 1 / (k * (x[0:(pk_index+1)]))
    #     right_x = 1/ (k * (x[pk_index:(x.size)]))
    #     left_trait = np.log(trait[0:(pk_index+1)])
    #     right_trait = np.log(trait[pk_index:(x.size)])

    #     # Linear regression on log-transformed data
    #     slopeL, interceptL, r_valueL, p_valueL, std_errL = stats.linregress(left_x, left_trait)
    #     slopeR, interceptR, r_valueR, p_valueR, std_errR = stats.linregress(right_x, right_trait)
    
    #     E = slopeL
    #     if math.isnan(E):
    #         E = 0.65

    #     Eh = slopeR
    #     if math.isnan(Eh):
    #         Eh = 1.3

    #     # Calculate Th and reverse log-transformation
    #     Th = ((((np.mean(right_trait)) - interceptR) / (slopeR))**(-1)) / k
    #     if math.isnan(Th):
    #         Th = np.argmax(x)

    # except ValueError:
    #     E = 0.65
    #     Eh = 1.3
    #     Th = np.argmax(x)
    #     B0_indx = (np.abs(x - Tref)).argmin() #get index of nearest val to reference

    School_B0 = np.array(dataset.B0)[0]
    T0 = np.array(dataset.T0)[0]
    Th = np.array(dataset.Th)[0]
    E = np.array(dataset.E)[0]
    Tm = np.array(dataset.Tm)[0]
    Eh = np.array(dataset.Eh)[0]
    Tpk = np.array(dataset.Tpk)[0]

    cubic_params = Parameters()
    cubic_params.add('B0', value=1)
    cubic_params.add('B1', value=1)
    cubic_params.add('B2', value=1)
    cubic_params.add('B3', value=1)

    Briere_params = Parameters() 
    Briere_params.add('B0_Briere', value=1)
    Briere_params.add('T0', value=T0, max = Tm)
    Briere_params.add('Tm', value=Tm, min = T0)

    School_params = Parameters()
    School_params.add('B0_School', value=School_B0)
    School_params.add('E', value=E, max=Eh)
    School_params.add('Eh', value=Eh, min = E)
    School_params.add('Th', value=Th, min=Tpk)


    return cubic_params, Briere_params, School_params

def add_vals(i):

    ndata = len(trait)

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
        cub_AICc = AICc(cub_out.aic, cub_out.ndata, 4)
        #cub_nfev = cub_out.nfev
        #cub_residuals = cub_out.residual

    else:
        B0 = 'NA'
        B1 = 'NA'
        B2 = 'NA'
        B3 = 'NA' 
        cub_AICc = 'NA' 
        #cub_nfev = 'NA'
        #cub_residuals = 'NA'  

    if Briere_out != 0:
        a = Briere_out.params.valuesdict()
        B0_Briere = a['B0_Briere']
        T0 = a['T0']
        Tm = a['Tm']
        Briere_AICc = AICc(Briere_out.aic, Briere_out.ndata, 3)
        #Briere_nfev = Briere_out.nfev
        #Briere_residuals = Briere_out.residual
    else:
        B0_Briere = 'NA'
        T0 = 'NA'
        Tm = 'NA'
        Briere_AICc = 'NA'
        #Briere_nfev = 'NA'
        #Briere_residuals = 'NA'

    if School_out != 0:
        a = School_out.params.valuesdict()
        B0_School = a['B0_School']
        E = a['E']
        Eh = a['Eh']
        Th = a['Th']
        School_AICc = AICc(School_out.aic, School_out.ndata, 4)
        #School_nfev = School_out.nfev
        #School_residuals = School_out.residual

    else:
        B0_School = 'NA'
        E = 'NA'
        Eh = 'NA'
        Th = 'NA'
        School_AICc = 'NA'
        #School_nfev = 'NA'
        #School_residuals = 'NA'

    new_row = pd.Series([i, ndata, Init_B0, B0, Init_B1, B1, Init_B2, B2, Init_B3, B3, \
            cub_AICc, cub_R2, \
            Init_B0_Briere, B0_Briere, Init_T0, T0, Init_Tm, Tm, \
            Briere_AICc, Briere_R2, \
            Init_B0_School, B0_School, Init_E, E, Init_Eh, Eh, Init_Th, Th, \
            School_AICc, School_R2], index=(colnames))

    #residual_new_row = pd.Series([i, cub_residuals, Briere_residuals, School_residuals], index=(residual_colnames))

    return new_row #residual_new_row

def Gaussian(School_out, School_params):
    # Make aic of starting params the current best
    best_AICc = AICc(School_out.aic, School_out.ndata, 4)
    a = School_out.params.valuesdict()
    best_E = a['E']
    
    # # See if current best is better than default:
    # School_params.add('E', value=0.65, max=(1.30), min=1e-5)
    # School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
    # new_AICc = AICc(School_out.aic, School_out.ndata, 4)
    # if new_AICc < best_AICc:
    #     best_AICc = new_AICc
    #     a = School_out.params.valuesdict()
    #     best_E = a['E']

    School_params.add('E', value=best_E, max=(2*best_E))

    i = 0
    # Draw from a random distribution with mean E
    while i < 5:
        new_E = np.random.normal(best_E, 1)
        School_params.add('E', value=new_E, max=(2*new_E))
        try:
            School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
            new_AICc = AICc(School_out.aic, School_out.ndata, len(School_out.var_names))

            if new_AICc < best_AICc:
                best_AICc = new_AICc
                a = School_out.params.valuesdict()
                best_E = a['E']

        except ValueError:
            continue
        
        #print(best_E)
        #print(best_AICc)
        i = i + 1

    #print(best_AICc)
    
    School_params.add('E', value=best_E, max=2*best_E)

    return School_out, School_params

def r_squared(output, trait):

    a = 1 - output.redchi / np.var(trait)

    return a

def AICc(AIC, n, K):
    # if n - K - 1 != 0:
    #     AICc = AIC + ((2*(K**2) + 2*K) / (n - K - 1))
    # else:
    #     AICc = AIC

    return AIC

#######################################
############### Fitting ###############
#######################################
cubic_params = Parameters()
cubic_params.add('B0', value=1)
cubic_params.add('B1', value=1)
cubic_params.add('B2', value=1)
cubic_params.add('B3', value=1)
a = cubic_params.valuesdict()
Init_B0 = a['B0']
Init_B1 = a['B1']
Init_B2 = a['B2']
Init_B3 = a['B3']

Briere_params = Parameters() 
Briere_params.add('B0_Briere', value=1)
a = Briere_params.valuesdict()
Briere_Init_B0 = a['B0_Briere']

School_params = Parameters()

FinalIDs = np.unique(bio.FinalID)
colnames = ('FinalID', 'ndata', 'Init_B0', 'B0', 'Init_B1', 'B1', 'Init_B2', 'B2', 'Init_B3', 'B3', \
            'cub_AICc', 'cub_R2',  \
            'Init_B0_Briere', 'B0_Briere', 'Init_T0', 'T0', 'Init_Tm', 'Tm', \
            'Briere_AICc', 'Briere_R2', \
            'Init_B0_School', 'B0_School', 'Init_E', 'E', 'Init_Eh', 'Eh', 'Init_Th', 'Th', \
            'School_AICc', 'School_R2')
residual_colnames = ('FinalID', 'cub_residuals', 'Briere_residuals', 'School_residuals')
proper_fit = pd.DataFrame(columns=(colnames))
new_row = pd.Series(['NA', 'NA', Init_B0, 'NA', Init_B1, 'NA', Init_B2, 'NA', Init_B3, 'NA', \
                    'NA', 'NA', Briere_Init_B0, 'NA', 'NA', 'NA', 'NA', 'NA', \
                    'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA'], index=(colnames))
#residuals = pd.DataFrame(columns=(residual_colnames))


def fitting():
    start = time.time()
    iteration = 0
    for i in FinalIDs:
        ## ASSIGN ##
        iteration = iteration + 1
        dataset = bio.loc[(bio.FinalID == i)]
        new_row['FinalID'] = i
        new_row['ndata'] = len(i)

        Kelvin = np.array(dataset.ConTemp + 273.15)
        Celsius = np.array(dataset.ConTemp)
        trait = np.array(dataset.OriginalTraitValue)
        #trait_scalar = np.array(dataset.trait_scalar)[0]

        School_B0 = np.array(dataset.B0)[0]
        new_row['Init_School_B0'] = School_B0
        T0 = np.array(dataset.T0)[0]
        new_row['Init_T0'] = T0
        Th = np.array(dataset.Th)[0]
        new_row['Init_Th'] = Th
        E = np.array(dataset.E)[0]
        new_row['Init_E'] = E
        Tm = np.array(dataset.Tm)[0]
        new_row['Init_Tm'] = Tm
        Eh = np.array(dataset.Eh)[0]
        new_row['Init_Eh'] = Eh
        Tpk = np.array(dataset.Tpk)[0]
        #new_row['Tpk'] = Tpk

        Briere_params.add('T0', value=T0, min=0, max = Tm)
        Briere_params.add('Tm', value=Tm, min = T0, max=400)

        School_params.add('B0_School', value=School_B0)
        School_params.add('E', value=E, min=0, max=3)
        School_params.add('Eh', value=Eh, min=0, max = 5)
        School_params.add('Th', value=Th, min=Tpk, max=400)

        try:
            cub_out = minimize(cubic, cubic_params, args=(Celsius, trait))
            cub_R2 = r_squared(cub_out, trait)
            a = cub_out.params.valuesdict()
            new_row['B0'] = a['B0']
            new_row['B1'] = a['B1']
            new_row['B2'] = a['B2']
            new_row['B3'] = a['B3']
            new_row['cub_R2'] = cub_R2
            #cub_AICc = AICc(cub_out.aic, cub_out.ndata, 4)
        except ValueError:
            cub_out = 0


        #if Briere_params != 0:
        try:
            Briere_out = minimize(Briere, Briere_params, args=(Celsius, trait))
            Briere_R2 = r_squared(Briere_out, trait)
            a = Briere_out.params.valuesdict()
            new_row['B0_Briere'] = a['B0_Briere']
            new_row['T0'] = a['T0']
            new_row['Tm'] = a['Tm']
            new_row['Briere_R2'] = Briere_R2
        except ValueError:
            Briere_out = 0
        
        #if School_params != 0:
        try:
            School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
            School_R2 = r_squared(School_out, trait)
            a = School_out.params.valuesdict()
            new_row['B0_School'] = a['B0_School']
            new_row['E'] = a['E']
            new_row['Eh'] = a['Eh']
            new_row['Th'] = a['Th']
            new_row['School_R2'] = School_R2
                
                # if School_R2 < 0.25:
                #     try:
                #         School_out, School_params = Gaussian(School_out, School_params)
                #         School_R2 = r_squared(School_out, trait)
                #     except ValueError:
                #         School_out = 0
                #         School_R2 = 'NA' 
        except ValueError:
            School_out = 0
                # try:
                #     School_out, School_params = Gaussian(School_out, School_params)
                #     School_R2 = r_squared(School_out, trait)
                # except ValueError:
                #     School_out = 0
                #     School_R2 = 'NA'
        
        proper_fit.loc[iteration] = new_row


        #new_row = add_vals(i)  #, residual_new_row
        #proper_fit = proper_fit.append(new_row, ignore_index=True)
        #residuals = residuals.append(residual_new_row, ignore_index=True)

        print("Fit " + str(iteration) + " complete")

    end = time.time()
    print("Time taken: " + str(end-start) + " secs")

    return proper_fit

## RUN ##
proper_fit = fitting()



###################
##### OUTPUT ######
###################


proper_fit.to_csv('../Data/proper_fit.csv')
# residuals.to_csv('../Data/residuals.csv')



        # plt.plot(x, data, 'x')
        # plt.plot(x, School_nolow(School_out.params, x, data) + data, 'r')
        # plt.show()




    # try:
    #     cubic_params, Briere_params, School_params = start_params(Celsius, Kelvin, trait)
    # except ValueError:
    #     School_params = 0

    # Fit models
    #if cubic_params != 0:
# ##### Testing #####

# test = bio.loc[(bio.FinalID == "MTD3631")]

# # Assign variables
# x = np.array(test.Kelvins)
# data = np.array(test.OriginalTraitValue)

# cubic_params, Briere_params, School_params = start_params(x, data)

# School_out = minimize(School_nolow, School_params, args=(x, data))
# lmfit.printfuncs.report_fit(School_out.params, min_correl=0.5)


# plt.close()
# plt.plot(x, data, 'x')
# plt.plot(x, School_nolow(School_out.params, x, data) + data, 'r')
# plt.show()

