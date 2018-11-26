#!/usr/bin/env python3

"""  """

__appname__ = 'run_fmr_R.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import subprocess
from pathlib import Path


print("Running fmr.R...\n")
subprocess.call (["/usr/bin/Rscript", "--vanilla", "fmr.R"])

my_file = Path("../Results/fmr_plot.pdf")
if my_file.is_file():
    print("\nfmr.R successfully run! See output in Results directory")

