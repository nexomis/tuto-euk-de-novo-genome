#!/bin/bash

# Create the directory for the data
mkdir -p data/05/

# Pull the apptainer images
apptainer pull --dir data/05/ docker://staphb/quast
apptainer pull --dir data/05/ docker://ezlabgva/busco:v6.0.0_cv1
apptainer build --sandbox data/05/busco_sandbox docker://ezlabgva/busco:v6.0.0_cv1

# Download reference genome
wget -P data/05/ https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/085/055/GCF_013085055.1_ASM1308505v1/GCF_013085055.1_ASM1308505v1_genomic.fna.gz

# Download BUSCO database
apptainer exec --writable data/05/busco_sandbox busco --download fungi_odb10 --download_path data/05/datasets
