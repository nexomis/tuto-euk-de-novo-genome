#!/bin/bash

# Create the directory for the data
mkdir -p data/10/

# Pull the apptainer images
apptainer pull --dir data/10/ docker://interpro/interproscan:5.75-106.0
apptainer pull --dir data/10/ docker://quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_0

# Download InterProScan data
mkdir -p data/10/interproscan
curl -o data/10/interproscan/interproscan-data-5.75-106.0.tar.gz http://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.75-106.0/alt/interproscan-data-5.75-106.0.tar.gz

# Download eggNOG-mapper data
mkdir -p data/10/eggnog
apptainer run docker://quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_0 download_eggnog_data.py -y --data_dir data/10/eggnog
apptainer run docker://quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_0 create_dbs.py -m diamond --dbname fungi --taxa Fungi --data_dir data/10/eggnog
