#!/bin/bash
#SBATCH --export=NONE
#SBATCH --job-name=canu_multi
#SBATCH --time=7-00:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=360G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load GCCcore/8.3.0 canu/2.1.1-Java-1.8

################################### INPUTS ######################################

nanopore_raw_reads="nanopore_raw_reads.fastq.gz"

################################### PARAMETERS ##################################

genome_size="65m"
stop_on_low_coverage="stopOnLowCoverage=4"

################################### COMMANDS ####################################

while IFS=$'\t' read -r draft_name prefix assembly_directory extra_params; do
    echo "Running ${draft_name}"
    echo "Prefix: ${prefix}"
    echo "Output directory: ${assembly_directory}"
    echo "Extra parameters: ${extra_params}"

    canu useGrid=false \
        -p "${prefix}" \
        -d "${assembly_directory}" \
        genomeSize="${genome_size}" \
        -nanopore "${nanopore_raw_reads}" \
        "${stop_on_low_coverage}" \
        ${extra_params}

done <<EOF
draft1	draft1	draft1_canu	
draft2	draft2	draft2_canu	correctedErrorRate=0.100
draft3	draft3	draft3_canu	rawErrorRate=0.300
draft4	draft4	draft4_canu	correctedErrorRate=0.100 rawErrorRate=0.300
draft5	draft5	draft5_canu	rawErrorRate=0.200
draft6	draft6	draft6_canu	rawErrorRate=0.400
draft7	draft7	draft7_canu	rawErrorRate=0.100
EOF
