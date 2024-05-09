cd $WORK_DIR/01_data

apptainer run --no-https docker://staphb/nanoplot NanoPlot --fastq 01_raw/nanopore.fastq.gz \
  --outdir 01_raw/nanoplot --only-report --info_in_report \
  --loglength --threads 12

#mkdir 04_pychopper NO CHANGE (already done)
#
#apptainer run docker://staphb/porechop porechop --threads 12 \
#  --format fastq.gz -i 01_raw/nanopore.fastq.gz -o 04_pychopper/nanopore.fastq.gz

apptainer run --no-https docker://staphb/fastp fastp \
  -i 01_raw/nanopore.fastq.gz -o 02_fastp/nanopore.fastq.gz \
  --disable_adapter_trimming \
  --average_qual 16 --length_required 1000 \
  --html 02_fastp/nanopore_fastp.html \
  --thread 12

apptainer run --no-https docker://staphb/nanoplot NanoPlot --fastq 02_fastp/nanopore.fastq.gz \
  --outdir 02_fastp/nanoplot --only-report --info_in_report \
  --loglength --threads 12
