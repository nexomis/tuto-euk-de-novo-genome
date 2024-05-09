source 00_set_env.sh

#Go in your home directory
cd $WORK_DIR
# Create a directory for data and primary QC
mkdir -p 01_data
cd 01_data
# Create a directory for raw data
mkdir -p 01_raw
cd 01_raw
SRR_ILLUMINA=SRR14237206
## Prefetch the SRA file
apptainer run --no-https docker://ncbi/sra-tools prefetch $SRR_ILLUMINA
#cp -r $SHARED_FOLDER/$SRR_ILLUMINA .
## Extract Fastq from SRA
apptainer run --no-https docker://ncbi/sra-tools fasterq-dump $SRR_ILLUMINA \
  --split-files --progress
## Compress files
pigz -p 8 ${SRR_ILLUMINA}_* 
## Clean
rm -rf $SRR_ILLUMINA
## Rename
mv ${SRR_ILLUMINA}_1.fastq.gz illumina_R1.fastq.gz
mv ${SRR_ILLUMINA}_2.fastq.gz illumina_R2.fastq.gz
