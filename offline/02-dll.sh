#!/bin/bash

# Create the directory for the data
mkdir -p data/02/

# Pull the apptainer images
apptainer pull --dir data/02/ docker://staphb/fastqc
apptainer pull --dir data/02/ docker://staphb/nanoplot
apptainer pull --dir data/02/ docker://staphb/fastp
apptainer pull --dir data/02/ docker://staphb/multiqc
apptainer pull --dir data/02/ docker://staphb/seqtk
apptainer pull --dir data/02/ docker://staphb/kraken2

# Download Kraken2 database
mkdir -p data/02/kraken2/k2_pluspf_08gb_20250402
wget -P data/02/kraken2/k2_pluspf_08gb_20250402 https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_08gb_20250402.tar.gz
tar -xzf data/02/kraken2/k2_pluspf_08gb_20250402/k2_pluspf_08gb_20250402.tar.gz -C data/02/kraken2/k2_pluspf_08gb_20250402
rm data/02/kraken2/k2_pluspf_08gb_20250402/k2_pluspf_08gb_20250402.tar.gz
