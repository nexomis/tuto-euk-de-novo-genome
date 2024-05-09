## Basic QCs
cd $WORK_DIR/01_data/

mkdir -p 01_raw/fastQC
apptainer run --no-https docker://staphb/fastqc fastqc --threads 4 --memory 8000 \
  --extract --outdir 01_raw/fastQC \
  01_raw/*.fastq.gz
