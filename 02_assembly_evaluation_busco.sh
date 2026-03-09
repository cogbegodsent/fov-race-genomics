#!/bin/bash
#SBATCH --export=NONE               # do not export current env to the job
#SBATCH --job-name=busco            # job name
#SBATCH --time=06:00:00             # max job run time dd-hh:mm:ss
#SBATCH --ntasks-per-node=1         # tasks (commands) per compute node
#SBATCH --cpus-per-task=48          # CPUs (threads) per command
#SBATCH --mem=360G                  # total memory per node
#SBATCH --output=stdout.%x.%j       # save stdout to file
#SBATCH --error=stderr.%x.%j        # save stderr to file

module load GCC/8.3.0 OpenMPI/3.1.4 BUSCO/4.1.2-Python-3.7.4

################################### VARIABLES ##################################

########## INPUTS ##########
genome_file="assembly.fasta"

######## PARAMETERS ########
threads=$SLURM_CPUS_PER_TASK

# BUSCO mode
busco_mode="genome"

# BUSCO lineage
busco_lineage="/scratch/data/bio/busco4/odb10/lineages/fungi_odb10"
lineage_name=$(basename "${busco_lineage}")

# AUGUSTUS settings
augustus_species="fusarium"
augustus_model="partial"

########## OUTPUTS #########
out_prefix="busco_${lineage_name}_${augustus_species}"

########## CONFIG ##########
# Copy AUGUSTUS config to scratch if needed
if [ ! -d "$SCRATCH/my_augustus_config/config" ]; then
  echo "Copying AUGUSTUS config directories to $SCRATCH/my_augustus_config"
  mkdir -p "$SCRATCH/my_augustus_config"
  if [ "-$EBROOTAUGUSTUS" == "-" ]; then
    echo "Augustus module not loaded"
    exit 1
  fi
  rsync -r "$EBROOTAUGUSTUS"/ "$SCRATCH/my_augustus_config"
  chmod -R 755 "$SCRATCH/my_augustus_config"
fi

export AUGUSTUS_CONFIG_PATH="$SCRATCH/my_augustus_config/config"

################################### COMMANDS ###################################

busco \
  --offline \
  --in "${genome_file}" \
  --mode "${busco_mode}" \
  --augustus_species "${augustus_species}" \
  --cpu "${threads}" \
  --lineage "${busco_lineage}" \
  --out "${out_prefix}" \
  --augustus_parameters="--genemodel=${augustus_model}"
