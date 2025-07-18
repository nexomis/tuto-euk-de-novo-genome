#!/bin/bash

# Create the directory for the data
mkdir -p data/11/

# Pull the apptainer images
apptainer pull --dir data/11/ docker://quay.io/comparative-genomics-toolkit/cactus:v2.9.9
apptainer pull --dir data/11/ docker://quay.io/biocontainers/orthofinder:3.1.0--hdfd78af_0

# Download proteomes
mkdir -p data/11/proteomes
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/085/055/GCF_013085055.1_ASM1308505v1/GCF_013085055.1_ASM1308505v1_protein.faa.gz -O data/11/proteomes/Fo47.faa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/048/165/035/GCA_048165035.1_ASM4816503v1/GCA_048165035.1_ASM4816503v1_protein.faa.gz -O data/11/proteomes/ZUM2407.faa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/048/164/945/GCA_048164945.1_ASM4816494v1/GCA_048164945.1_ASM4816494v1_protein.faa.gz -O data/11/proteomes/V032g.faa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/030/719/095/GCA_030719095.1_ASM3071909v1/GCA_030719095.1_ASM3071909v1_protein.faa.gz -O data/11/proteomes/ME23.faa.gz

# Download the script to select the longest transcript
wget https://raw.githubusercontent.com/davidemms/OrthoFinder/master/tools/primary_transcript.py -O data/11/primary_transcript.py
