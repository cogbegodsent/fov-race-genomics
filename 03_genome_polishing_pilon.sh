#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=pilon            # job name
#SBATCH --time=10:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=48          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file

module load GCC/10.2.0 BWA/0.7.17 SAMtools/1.11 picard/2.21.6-Java-11 Pilon/1.23-Java-11

################################### VARIABLES ##################################

assembly="assembly.fasta"
sample="sample"
threads=$SLURM_CPUS_PER_TASK

pe_1="reads_R1.fastq.gz"
pe_2="reads_R2.fastq.gz"

read_group_id="rg1"
library="pe"
platform="ILLUMINA"

sorted_bam="${sample}_sorted.bam"
output_bam="${sample}_sorted_dedup.bam"

################################### COMMANDS ###################################

# Index genome if needed
if [ ! -f "${assembly}.bwt" ]; then
  bwa index "${assembly}"
fi

# Align paired-end Illumina reads
bwa aln -t "${threads}" "${assembly}" "${pe_1}" > "pe_1.${sample}.aln.sai"
bwa aln -t "${threads}" "${assembly}" "${pe_2}" > "pe_2.${sample}.aln.sai"

# Convert to BAM and sort
bwa sampe -r "@RG\tID:${read_group_id}\tLB:${library}\tSM:${sample}\tPL:${platform}" \
  "${assembly}" \
  "pe_1.${sample}.aln.sai" \
  "pe_2.${sample}.aln.sai" \
  "${pe_1}" \
  "${pe_2}" | \
  samtools view -h -Sb - | \
  samtools sort -T tmp_prefix -m 10G -@ "${threads}" - -o "${sorted_bam}"

# Mark duplicates
java -jar $EBROOTPICARD/picard.jar MarkDuplicates \
  I="${sorted_bam}" \
  O="${output_bam}" \
  METRICS_FILE="${sample}.dup.metrics" \
  VALIDATION_STRINGENCY=LENIENT

# Index deduplicated BAM
samtools index "${output_bam}"

# Run Pilon polishing
java -Xmx300G -jar $EBROOTPILON/pilon.jar \
  --genome "${assembly}" \
  --frags "${output_bam}" \
  --output "${sample}" \
  --outdir pilon_output \
  --vcf \
  --tracks \
  --threads "${threads}"

################################################################################
