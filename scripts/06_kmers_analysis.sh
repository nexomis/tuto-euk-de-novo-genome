SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source $SCRIPT_DIR/00_set_env.sh

cd $WORK_DIR/01_data
mkdir -p 04_kmers
mkdir -p 04_kmers/kat

for k in 5 9 11 15 21 25 27 31 35 41 61 81; do \
apptainer run docker://quay.io/biocontainers/kat:2.4.2--py36hc902310_3 kat hist \
  -o 01_data/04_kmers/kat/hist-$k -H 250000000 -t 12 -m $k -p pdf \
  01_data/03_merged/illumina*fastq.gz > 01_data/04_kmers/kat/hist-${k}.out ; \
done

grep "Estimated genome size" 04_kmers/kat/hist-*.out

mkdir -p 04_kmers/kraken

apptainer run --no-https docker://staphb/kraken2 kraken2 --use-names \
  --threads 4 --db /hpool/ngsshare/data_workshop/k2_pluspfp_20240112 \
  --report 04_kmers/kraken/illumina.kreport --gzip-compressed \
  --output 04_kmers/kraken/illumina.kraken \
  --paired 02_fastp/illumina_R1.fastq.gz 02_fastp/illumina_R2.fastq.gz
