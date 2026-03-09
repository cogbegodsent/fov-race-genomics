#!/bin/bash
#SBATCH --export=NONE
#SBATCH --job-name=maker
#SBATCH --time=7-00:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=360G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load GCC/9.3.0 OpenMPI/4.0.3 MAKER/3.01.03-Python-3.8.2

set -euo pipefail

################################### VARIABLES ##################################

genome="assembly.fasta.masked"
cpus=$SLURM_CPUS_PER_TASK
out_prefix="maker_annotation"

################################### COMMANDS ###################################

maker \
  -cpus "${cpus}" \
  -genome "${genome}" \
  -TMP "${TMPDIR}" \
  -base "${out_prefix}" \
  maker_opts.ctl \
  maker_bopts.ctl \
  maker_exe.ctl

# Merge final FASTA and GFF3 outputs
fasta_merge -d "${out_prefix}.maker.output/${out_prefix}_master_datastore_index.log"
gff3_merge -d "${out_prefix}.maker.output/${out_prefix}_master_datastore_index.log"

# Review this file for any FAILED tasks
# ${out_prefix}.maker.output/${out_prefix}_master_datastore_index.log
