#!/bin/bash

# Create the directory for the data
mkdir -p data/08/

# Pull the apptainer images
apptainer pull --dir data/08/ docker://ncbi/sra-tools
apptainer pull --dir data/08/ docker://staphb/fastp
apptainer pull --dir data/08/ docker://quay.io/biocontainers/star:2.7.11b--h5ca1c30_6
apptainer pull --dir data/08/ docker://staphb/samtools

# Download OrthoDB data
mkdir -p data/08/orthodb
wget https://data.orthodb.org/current/download/odb12v1_aa_fasta.gz -O data/08/orthodb/odb12v1_aa_fasta.gz
wget https://data.orthodb.org/current/download/odb12v1_levels.tab.gz -O data/08/orthodb/odb12v1_levels.tab.gz
wget https://data.orthodb.org/current/download/odb12v1_level2species.tab.gz -O data/08/orthodb/odb12v1_level2species.tab.gz
wget https://raw.githubusercontent.com/tomasbruna/orthodb-clades/master/selectClade.py -O data/08/orthodb/selectClade.py

# Download RNA-Seq data
export SRR_RNA="SRR10123445"
mkdir -p data/08/reads
apptainer run docker://ncbi/sra-tools prefetch $SRR_RNA -O data/08/reads
