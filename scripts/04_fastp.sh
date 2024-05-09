cd $WORK_DIR/01_data

mkdir -p 02_fastp

apptainer run docker://staphb/fastp fastp --help

apptainer run docker://staphb/fastp fastp \
  -i 01_raw/illumina_R1.fastq.gz -I 01_raw/illumina_R2.fastq.gz -o 02_fastp/illumina_R1.fastq.gz -O 
02_fastp/illumina_R2.fastq.gz \
  --detect_adapter_for_pe --trim_poly_g --trim_poly_x \
  --average_qual ?? --length_required ?? \
  --html 02_fastp/fastp.html \
  --cut_right_window_size ? --cut_right_mean_quality ?? --cut_right \
  --cut_tail_window_size ? --cut_tail_mean_quality ?? --cut_tail \
  --thread 8

mkdir -p 02_fastp/fastQC
apptainer run --no-https docker://staphb/fastqc fastqc --threads 4 --memory 8000 \
  --extract --outdir 02_fastp/fastQC \
  01_fastp/*.fastq.gz
mkdir -p 03_merged

# Merger les reads

apptainer run docker://staphb/fastp fastp \
  --merge --correction --merged_out 03_merged/illumina.fastq.gz \
  --disable_quality_filtering \
  -i 02_fastp/illumina_R1.fastq.gz -I 02_fastp/illumina_R2.fastq.gz -o 03_merged/illumina_R1.fastq.g
z -O 03_merged/illumina_R2.fastq.gz \
  --detect_adapter_for_pe --trim_poly_g --trim_poly_x \
  --html 03_merged/fastp.html \
  --thread 12

mkdir -p 03_merged/fastQC
apptainer run --no-https docker://staphb/fastqc fastqc --threads 4 --memory 8000 \
  --extract --outdir 03_merged/fastQC \
  03_merged/*.fastq.gz
