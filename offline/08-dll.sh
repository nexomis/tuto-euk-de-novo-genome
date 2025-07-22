#!/bin/bash

# Create the directory for the data
mkdir -p data/08/

# Pull the apptainer images
apptainer pull --dir data/08/ docker://ncbi/sra-tools
apptainer pull --dir data/08/ docker://staphb/fastp
apptainer pull --dir data/08/ docker://quay.io/biocontainers/hisat2:2.2.1--h503566f_8
apptainer pull --dir data/08/ docker://staphb/samtools

# Download OrthoDB data
mkdir -p data/08/orthodb
wget https://data.orthodb.org/current/download/odb12v1_aa_fasta.gz -O data/08/orthodb/odb12v1_aa_fasta.gz
wget https://data.orthodb.org/current/download/odb12v1_levels.tab.gz -O data/08/orthodb/odb12v1_levels.tab.gz
wget https://data.orthodb.org/current/download/odb12v1_level2species.tab.gz -O data/08/orthodb/odb12v1_level2species.tab.gz
wget https://raw.githubusercontent.com/tomasbruna/orthodb-clades/master/selectClade.py -O data/08/orthodb/selectClade.py

# Download RNA-Seq data
mkdir -p data/08/reads
curl -s "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/085/055/GCF_013085055.1_ASM1308505v1/GCF_013085055.1_rnaseq_runs.txt" > data/08/reads/rnaseq_runs.txt

# Sample and shuffle SRA IDs using an embedded Python script
python3 - <<EOF
import pandas as pd
import random

# Set seed for reproducibility
random.seed(42)

# Define file paths
input_file = "data/08/reads/rnaseq_runs.txt"
output_file = "data/08/reads/sra_list.txt"

# Read the tab-delimited file.
df = pd.read_csv(input_file, sep='\t')

# Sample one SRA ID ('Run') per unique BioProject ID
sra_samples = df.groupby('Bioproject Accession')['SRA run accession'].first().tolist()

# Shuffle the list of SRA IDs
random.shuffle(sra_samples)

# Write the shuffled list to the output file
with open(output_file, 'w') as f:
    for sra_id in sra_samples:
        f.write(f"{sra_id}\n")

print(f"Sampled and shuffled {len(sra_samples)} SRA IDs and saved to {output_file}")
EOF

# Prefetch the SRA data from the generated list
cat data/08/reads/sra_list.txt | xargs -n 1 apptainer run docker://ncbi/sra-tools prefetch -O data/08/reads
