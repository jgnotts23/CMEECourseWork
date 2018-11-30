#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: variables.sh
# Desc: script to illustrate the use of variables in UNIX
# Arguments: None
# Date: Oct 2018

## Shows the use of variables
MyVar='some string' # explicit declaration
echo 'The current value of the variable is' $MyVar
echo 'Please enter a new string'
read MyVar # read from user
echo 'The current value of the variable is' $MyVar

## Reading multiple values
echo 'Enter two numbers separated by spaces(s)'
read a b
echo 'You entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum