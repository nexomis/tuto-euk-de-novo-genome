source 00_set_env.sh

#  Go in your home directory
cd $WORK_DIR
cd 01_data
cd 01_raw
## Do the same for nanopore data
SRR_NANOPORE=SRR14237202
#apptainer run --no-https docker://ncbi/sra-tools prefetch $SRR_NANOPORE
cp /hpool/ngsshare/data_workshop/$SRR_NANOPORE .
apptainer run --no-https docker://ncbi/sra-tools fasterq-dump $SRR_NANOPORE \
  --split-files --progress
pigz -p 8 ${SRR_NANOPORE}.fastq 
rm -rf $SRR_NANOPORE
mv ${SRR_NANOPORE}.fastq.gz nanopore.fastq.gz


