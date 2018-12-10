#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: installing.sh
# Desc: how to install/uninstall in linux
# Arguments: None
# Date: Nov 2018

### Installing from main repositories ###
sudo apt install r-base # sudo (super user do)

### Installing from other repositories ###
# Add repository
sudo add-apt-repository ppa:atareao/atareao

# Update repository package list
sudo apt-get update 

# Install
sudo apt-get install my-weather-indicator

### Removing softare ###
sudo apt remove totem

### Installing from downloaded *.deb file ###
# First download the .deb package then:
cd ~/Downloads

# De-package
sudo dpkg -i <file>.deb 

# Install dependencies
sudo apt-get install -f

exit