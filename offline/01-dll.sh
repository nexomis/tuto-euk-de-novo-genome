#!/bin/bash

# Create the directory for the data
mkdir -p data/01/

# Pull the apptainer image
apptainer pull --dir data/01/ docker://ncbi/sra-tools

# Download the SRA data
export SRR_ILLUMINA=SRR14237206
export SRR_NANOPORE=SRR14237202

apptainer run docker://ncbi/sra-tools prefetch $SRR_ILLUMINA -O data/01/
apptainer run docker://ncbi/sra-tools prefetch $SRR_NANOPORE -O data/01/
