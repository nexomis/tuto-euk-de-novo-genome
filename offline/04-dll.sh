#!/bin/bash

# Create the directory for the data
mkdir -p data/04/

# Pull the apptainer images
apptainer pull --dir data/04/ docker://staphb/spades
apptainer pull --dir data/04/ docker://staphb/masurca
