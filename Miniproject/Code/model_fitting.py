#!/usr/bin/env python3

""" Miniproject model fitting in python second attempt """

__appname__ = 'model_fitting.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import numpy as np
from numpy import exp
import pandas as pd
import lmfit
from lmfit import Parameters, minimize
import matplotlib.pyplot as plt
from matplotlib import pylab
from scipy import stats
import csv
import math
from collections import Counter 

###############################
########### IMPORT ############
###############################
bio = pd.read_csv("../Data/bio_wrangled.csv")

###############################
######## DEFINITIONS ##########
###############################
k = 8.617e-5 # botzmann constant
Tref = 283.15 # Reference temp

# Cubic polynomial
def cubic(params, Kelvin, trait):
    """ Returns residuals of the cubic polynomial given the
    relevant parameters, temperature and trait data """

    x = Kelvin
    B0 = params['B0']
    B1 = params['B1']
    B2 = params['B2']
    B3 = params['B3']

    model = B0 + B1*x + B2*(x**2) + B3*(x**3)

    return model - trait #return residuals

# Briere model
def Briere(params, Kelvin, trait):
    """ Returns residuals of the Briere given the
    relevant parameters, temperature and trait data """

    x = Kelvin
    B0 = params['B0_Briere']
    T0 = params['T0'] # minimum trait temp
    Tm = params['Tm'] # max trait temp

    model = (B0*x*(x-T0))*(abs(Tm-x)**(1/2))

    return (model - trait).astype(float)


# Schoolfield model (El and Tl omitted)
def School_nolow(params, Kelvin, trait):
    """ Returns residuals of the Schoolfield model given the
    relevant parameters, temperature and trait data """

    x = Kelvin
    B0 = params['B0_School']
    E = params['E']
    Eh = params['Eh']
    Th = params['Th']

    model = (B0*(np.exp((-E/k)*((1/x)-(1/283.15))))) / (1 + (np.exp(Eh/k*((1/Th)-(1/x)))))

    return model - trait
  
def Gaussian(School_out, School_params, Kelvin, trait):
    """ Takes the output of minimise() with relevant parameters
    and peturbs them via a Gaussian distribution in an attempt
    to improve fits """

    # Make AICc of starting params the current best
    best_AICc = AICc(School_out.aic, School_out.ndata, 4)
    a = School_out.params.valuesdict()
    best_E = a['E']
    
    # See if current best is better than default:
    School_params.add('E', value=0.65, max=3, min=0)
    School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
    new_AICc = AICc(School_out.aic, School_out.ndata, 4)
    if new_AICc < best_AICc:
        best_AICc = new_AICc
        a = School_out.params.valuesdict()
        best_E = a['E']

    School_params.add('E', value=best_E, min=0, max=3)

    i = 0
    # Draw from a random distribution with mean E 10 times and compare
    # AICc scores each time, returning the best score
    while i < 10:
        new_E = np.random.normal(best_E, 1)
        School_params.add('E', value=new_E, min=0, max=3)
        try:
            School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
            new_AICc = AICc(School_out.aic, School_out.ndata, len(School_out.var_names))

            if new_AICc < best_AICc:
                best_AICc = new_AICc
                a = School_out.params.valuesdict()
                best_E = a['E']

        except ValueError:
            continue
        
        i = i + 1
    
    School_params.add('E', value=best_E, min=0, max=3)

    return School_out, School_params

def r_squared(output, trait, p, dataset):
    """ Takes the output from minimise() and calculates
    adjusted R2 scores for a given model and dataset """

    R2 = 1 - output.redchi / np.var(trait) # Convert reduced chi to R2
    n = len(dataset)

    adj_R2 = 1 - (1 - R2) * ((n - 1) / (n - p - 1))

    return adj_R2

def AICc(AIC, n, K):
    """ Calculates AICc for a given AIC, sample size,
    and parameter number """

    AICc = AIC + ((2*(K**2) + 2*K) / (n - K - 1)) # adds additional parameter penalty
    
    return AICc

def best_AICc(cub_AICc, Briere_AICc, School_AICc):
    """ Determines the best AICc score given the AICc scores
    for each model """

    AICcs = {
        "Cubic" : cub_AICc,
        "Briere" : Briere_AICc,
        "School" : School_AICc
    }

    a = Counter(AICcs)
    order = a.most_common(3) # order by value

    if abs(order[2][1] - order[1][1]) > 2 : # check the difference is > 2
        best_model = order[2][0]

    elif abs(order[2][1] - order[0][1]) > 2 :
        best_model = order[2][0] + " and " + order[1][0]

    else:
        best_model = "NA"


    return best_model



#######################################
############### Fitting ###############
#######################################

# Set starting parameters for parameters that don't change each iteration
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
Briere_params.add('B0_Briere', value=0.001)
a = Briere_params.valuesdict()
Briere_Init_B0 = a['B0_Briere']
School_params = Parameters()

# Create dataframes ready to store value in
FinalIDs = np.unique(bio.FinalID)
colnames = ('FinalID', 'ndata', 'Init_B0', 'B0', 'Init_B1', 'B1', 'Init_B2', 'B2', 'Init_B3', 'B3', \
            'cub_AICc', 'cub_adjR2',  \
            'Init_B0_Briere', 'B0_Briere', 'Init_T0', 'T0', 'Init_Tm', 'Tm', \
            'Briere_AICc', 'Briere_adjR2', \
            'Init_B0_School', 'B0_School', 'Init_E', 'E', 'Init_Eh', 'Eh', 'Init_Th', 'Th', \
            'School_AICc', 'School_adjR2', 'Best_AICc', 'Best_adjR2')
proper_fit = pd.DataFrame(columns=(colnames))
new_row = pd.Series(['NA', 'NA', Init_B0, 'NA', Init_B1, 'NA', Init_B2, 'NA', Init_B3, 'NA', \
                    'NA', 'NA', Briere_Init_B0, 'NA', 'NA', 'NA', 'NA', 'NA', \
                    'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA'], index=(colnames))


def fitting():
    """ Runs the fitting of all models to all unique datasets when called.
    No arguments are required """

    iteration = 0
    for i in FinalIDs:
        ## ASSIGN ##
        iteration = iteration + 1
        dataset = bio.loc[(bio.FinalID == i)]
        new_row['FinalID'] = i
        new_row['ndata'] = len(dataset) # store sample size

        # Assign temp and trait for dataset
        Kelvin = np.array(dataset.Kelvin)
        trait = np.array(dataset.OriginalTraitValue)

        # Assign parameters that vary and haven't already been assigned
        School_B0 = np.array(dataset.B0)[0]
        new_row['Init_B0_School'] = School_B0
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

        Briere_params.add('T0', value=T0, min=min(Kelvin) - 50, max = Tpk)
        Briere_params.add('Tm', value=Tm, min = Tpk, max=max(Kelvin) + 75)

        School_params = Parameters()
        School_params.add('B0_School', value=School_B0)
        School_params.add('E', value=E, min=0, max = 2)
        School_params.add('Eh', value=Eh, min=0, max = 4)
        School_params.add('Th', value=Th, min=Tpk, max=max(Kelvin) + 75)

        ## Fitting ##
        # Cubic 
        try:
            cub_out = minimize(cubic, cubic_params, args=(Kelvin, trait))
            cub_R2 = r_squared(cub_out, trait, 4, dataset)
            a = cub_out.params.valuesdict()
            new_row['B0'] = a['B0']
            new_row['B1'] = a['B1']
            new_row['B2'] = a['B2']
            new_row['B3'] = a['B3']
            new_row['cub_adjR2'] = cub_R2
            cub_AICc = AICc(cub_out.aic, cub_out.ndata, 4)
            new_row['cub_AICc'] = cub_AICc

        except ValueError:
            cub_out = 0

        # Briere
        try:
            Briere_out = minimize(Briere, Briere_params, args=(Kelvin, trait))
            Briere_R2 = r_squared(Briere_out, trait, 3, dataset)
            a = Briere_out.params.valuesdict()
            new_row['B0_Briere'] = a['B0_Briere']
            new_row['T0'] = a['T0']
            new_row['Tm'] = a['Tm']
            new_row['Briere_adjR2'] = Briere_R2
            Briere_AICc = AICc(Briere_out.aic, Briere_out.ndata, 3)
            new_row['Briere_AICc'] = Briere_AICc

        except ValueError:
            Briere_out = 0
        
        # Schoolfield
        try:
            School_out = minimize(School_nolow, School_params, args=(Kelvin, trait))
            School_R2 = r_squared(School_out, trait, 4, dataset)
            a = School_out.params.valuesdict()
            new_row['B0_School'] = a['B0_School']
            new_row['E'] = a['E']
            new_row['Eh'] = a['Eh']
            new_row['Th'] = a['Th']
            new_row['School_adjR2'] = School_R2
            School_AICc = AICc(School_out.aic, School_out.ndata, 4)
            new_row['School_AICc'] = School_AICc
                
            # If R2 is less than 0.5, attempt some Gaussian fluctuations of E to try and improve     
            if School_R2 < 0.5:
                try:
                    School_out, School_params = Gaussian(School_out, School_params, Kelvin, trait)
                    School_R2 = r_squared(School_out, trait, 4, dataset)
                    a = School_out.params.valuesdict()
                    new_row['B0_School'] = a['B0_School']
                    new_row['E'] = a['E']
                    new_row['Eh'] = a['Eh']
                    new_row['Th'] = a['Th']
                    new_row['School_adjR2'] = School_R2
                    School_AICc = AICc(School_out.aic, School_out.ndata, 4)
                    new_row['School_AICc'] = School_AICc

                except ValueError:
                    School_out = 0

        # If error encountered, try Gaussian fluctuations of E
        except ValueError:
            try:
                School_out, School_params = Gaussian(School_out, School_params, Kelvin, trait)
                School_R2 = r_squared(School_out, trait, 4, dataset)
                a = School_out.params.valuesdict()
                new_row['B0_School'] = a['B0_School']
                new_row['E'] = a['E']
                new_row['Eh'] = a['Eh']
                new_row['Th'] = a['Th']
                new_row['School_adjR2'] = School_R2
                School_AICc = AICc(School_out.aic, School_out.ndata, 4)
                new_row['School_AICc'] = School_AICc

            except ValueError:
                School_out = 0
        
        new_row['Best_AICc'] = best_AICc(cub_AICc, Briere_AICc, School_AICc)
        new_row['Best_adjR2'] = (new_row[['cub_adjR2','Briere_adjR2', 'School_adjR2']]).astype(float).idxmax(axis=1)
        
        # Add row for this dataset to overall dataframe
        proper_fit.loc[iteration] = new_row

    return proper_fit # the finished dataframe

## RUN ##
proper_fit = fitting() # to run the fitting function


###################
##### OUTPUT ######
###################
proper_fit.to_csv('../Data/proper_fit.csv') # save to new csv


