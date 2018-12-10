#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: LV1LV2_run.sh
# Desc: Runs LV1.py and LV2.py and prints system times
# Arguments: None
# Date: Nov 2018

# LV1
echo "Running LV1.py with r = 1.0, a = 0.1, z = 0.6 and e = 0.75"

python3 LV1.py 1.0 0.1 0.6 0.75

echo "Done! See output in Results directory"

# LV2
echo "Running LV2.py with r = 1.0, a = 0.1, z = 0.6, e = 0.75 and K = 50.0"

python3 LV2.py 1.0 0.1 0.6 0.75 50.0

echo "Done! See output in Results directory"

# LV3
echo "Running LV3.py with r = 1.0, a = 0.1, z = 0.6, e = 0.75 and K = 50.0"

python3 LV3.py 1.0 0.1 0.6 0.75 50.0

echo "Done! See output in Results directory"

# Profiling
echo "Testing script speeds..."
ipython3 << END
%run -p LV1.py 1.0 0.1 0.6 0.75 50.0
%run -p LV2.py 1.0 0.1 0.6 0.75 50.0
%run -p LV3.py 1.0 0.1 0.6 0.75 50.0
END
echo "Done!"