#!/bin/bash

# Create the directory for the data
mkdir -p data/03/

# Pull the apptainer image
apptainer pull --dir data/03/ docker://quay.io/biocontainers/kat:2.4.2--py36hc902310_3
