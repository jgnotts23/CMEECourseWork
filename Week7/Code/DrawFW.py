#!/usr/bin/env python3

""" Plotting food web networks """

__appname__ = 'DrawFW.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

### Imports ###
import networkx as nx 
import scipy as sc
import matplotlib.pyplot as p 

#C = connectance (probability of a connection between nodes)
#N = number of species
def GenRdmAdjList(N = 2, C = 0.5): 
    """ Generates a synthetic food web with N-species and connectance C
    """
    Ids = range(N) #creates list of a N range
    ALst = [] #create list
    for i in Ids: #for every species
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2).tolist() #coerce to list
            if Lnk[0] != Lnk[1]: #avoid self (e.g. cannibalistic) loops
                ALst.append(Lnk)
    return ALst

MaxN = 30
C = 0.75

#Generate adjacency list representing random food web
AdjL = sc.array(GenRdmAdjList(MaxN, C))
AdjL

#Generate species (node) data
Sps = sc.unique(AdjL) #get species ids

#Generate body sizes for species
#Using log because body sizes tend to be log-normally distributed
SizRan = ([-10,10])
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizs

#Visualise the size distribution
f1 = p.figure()
p.hist(Sizs)
p.hist(10 ** Sizs) #raw scale
f1.savefig('../Results/sizedist.pdf')

#Circular configuration
pos = nx.circular_layout(Sps)

#Generate a networkx graph object
G = nx.Graph()

#Add the nodes and links (edges)
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL)) #this function needs a tuple input

#Generate node sizes that are proportional to (log) body sizes
NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs))

#Render/plot graph
nx.draw_networkx(G, pos, node_size = NodSizs)
G.savefig('../Results/network.pdf')