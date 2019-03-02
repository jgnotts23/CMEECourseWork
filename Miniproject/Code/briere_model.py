#!/usr/bin/env python3

""" Importing cleaned csv file, and fitting three models to the
    data """

__appname__ = 'Modelling_Miniproject.py'
__author__ = 'Deraj Wilson-Aggarwal (dw4415@ic.ac.uk)'
__version__ = '0.0.1'


########################################
# import modules
########################################

import pandas as pd 
import numpy as np
import matplotlib.pylab as p # wont be needed after it works
import lmfit
from lmfit import minimize
from lmfit import Parameters
from lmfit import Parameter
from scipy import stats



########################################
# Constants 
########################################

k = 8.617e-5 



##########################################
# Import Data
##########################################

# import the data using pandas
Data2Fit = pd.read_csv("../Data/bio_wrangled.csv")
# Data2Fit.head()


#####################################
########### BRIERE
#####################################

# define the Briere function 
# pars defines the parameter for the model
# x is the temperature ie ConTemp column 
# data is the actual observed data 
# model is the modelled data based on the inputted Temps 

def briere(pars, x, data):
    T0 = pars['T0']
    B0 = pars['B0']
    Tmax = pars['Tmax']

    model = B0*x*(x - T0)*(np.sqrt(abs(Tmax - x)))
    residuals = model - data 

    return(residuals)


# # plot the results agaisnt real data to check 

# p.plot(Temps, OTV, "o")
# p.plot(Temps, briere(briere_min.params, Temps, OTV) + OTV)
# p.show()


#############################################################################
# Function to run all models on large sets of data based on unique FinalIDs 
#############################################################################

def run_models (dataset):

    # define the empty data frame to fill return
    columns = ['FinalID', 'Briere_AIC', 'Briere_BIC', 'Briere_T0', 'Briere_B0', 'Briere_Tmax']
    fits = pd.DataFrame(data=None, index = None, columns=columns)

    IDs = dataset.loc[:,"FinalID"]
    uniqueIDs = np.unique(IDs)

    for i in uniqueIDs:

        data = dataset.loc[dataset.FinalID==i,:]
        Temps = data.loc[:,"ConTemp"]
        KTemps = data.loc[:,"KTemp"]
        OTV = data.loc[:,"OriginalTraitValue"]

        # define the parameter dictionaries 

        
        params_briere = Parameters()
        params_briere['T0'] = Parameter(value=min(Temps))
        params_briere['B0'] = Parameter(value=0.1)
        params_briere['Tmax'] = Parameter(value=max(Temps))

        # find the optimised parameter values 
        try:
            briere_min = minimize(briere, params_briere, args=(Temps, OTV))
            briere_pars = briere_min.params.valuesdict()

            # create a series for the results to be added to 

            results = pd.Series( \
                        [i,\
                        briere_min.aic, \
                        briere_min.bic, \
                        # briere_min.init_vals[0] \
                        # briere_min.init_vals[1] \
                        # briere_min.init_vals[2] \
                        briere_pars['T0'], \
                        briere_pars['B0'], \
                        briere_pars['Tmax']], index = fits.columns)


            # append the series as a row to the data frame 
            fits = fits.append(results, ignore_index=True)
            print("Fitted Briere Model for {0}".format(i))
        
        except ValueError:
            print("Could not fit Model for {0}".format(i))


    return fits
#####################################################################################################

briere_fits = run_models(Data2Fit)

briere_fits.to_csv("../Data/briere_fits.csv")

