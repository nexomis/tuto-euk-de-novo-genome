#!/bin/bash

# Create the directory for the data
mkdir -p data/07/

# Pull the apptainer image
apptainer pull --dir data/07/ docker://dfam/tetools:latest

# Download the assembly
wget -P data/07/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/085/055/GCF_013085055.1_ASM1308505v1/GCF_013085055.1_ASM1308505v1_genomic.fna.gz

# Download the Dfam libraries
wget -P data/07/ https://www.dfam.org/releases/current/families/FamDB/dfam39_full.0.h5.gz
wget -P data/07/ https://www.dfam.org/releases/current/families/FamDB/dfam39_full.16.h5.gz
