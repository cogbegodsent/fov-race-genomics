#!/bin/bash
#SBATCH --export=NONE
#SBATCH --job-name=repeatmasker
#SBATCH --time=01:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=54G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load icc/2018.3.222-GCC-7.3.0-2.30 impi/2018.3.222 RepeatMasker/4.0.8-Perl-5.28.0-HMMER

set -euo pipefail

###############################################################################
# RepeatMasker genome repeat masking
###############################################################################

################################### INPUT #####################################

genome="assembly.fasta"

################################ PARAMETERS ###################################

species="fusarium"
threads=$SLURM_CPUS_PER_TASK

################################ COMMAND ######################################

RepeatMasker \
    -s \
    -species "${species}" \
    -pa "${threads}" \
    -e hmmer \
    "${genome}"

###############################################################################
# OUTPUT
###############################################################################

echo "RepeatMasker completed."
echo "Masked genome: ${genome}.masked"
