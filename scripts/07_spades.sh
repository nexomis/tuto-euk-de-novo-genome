SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source $SCRIPT_DIR/00_set_env.sh

cd $WORK_DIR

mkdir -p $WORK_DIR/

apptainer run --no-https docker://staphb/spades spades.py \
  -1 01_data/03_merged/illumina_R1.fastq.gz \
  -2 01_data/03_merged/illumina_R2.fastq.gz \
  -s 01_data/03_merged/illumina.fastq.gz \
  --nanopore 01_data/02_fastp/nanopore.fastq.gz \
  --isolate \
  -t 16 -k \
  -o 02_contigs/01_spades
