#!/bin/bash

# Create the directory for the data
mkdir -p data/09/

# Pull the apptainer image
apptainer pull --dir data/09/ docker://teambraker/braker3:latest
