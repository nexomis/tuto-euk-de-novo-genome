#!/bin/bash

# Create the directory for the data
mkdir -p data/06/

# Pull the apptainer images
apptainer pull --dir data/06/ docker://ghcr.io/nexomis/ragout:build_1.0-ragout_2.3-hal_2.3-Sibelia_3.0.7
apptainer pull --dir data/06/ docker://quay.io/comparative-genomics-toolkit/cactus:v2.9.9

# Download the reference genomes
wget -P data/06/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/085/055/GCF_013085055.1_ASM1308505v1/GCF_013085055.1_ASM1308505v1_genomic.fna.gz
wget -P data/06/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/048/165/035/GCA_048165035.1_ASM4816503v1/GCA_048165035.1_ASM4816503v1_genomic.fna.gz
wget -P data/06/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/048/164/945/GCA_048164945.1_ASM4816494v1/GCA_048164945.1_ASM4816494v1_genomic.fna.gz
wget -P data/06/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/030/719/095/GCA_030719095.1_ASM3071909v1/GCA_030719095.1_ASM3071909v1_genomic.fna.gz

# Create local conda environment in ./data/06/conda
conda create -p ./data/06/venv -c bioconda -c conda-forge jolytree bc
