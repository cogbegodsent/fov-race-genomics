# Fov-race-genomics
# Comparative Genomics and Transcriptomic Analysis of *Fusarium oxysporum* Strains Fov1, Fov4, 17-3, and 18-24

## Overview

This repository contains analysis scripts used for genome assembly, annotation, transcriptomic profiling, and comparative genomics of four *Fusarium oxysporum* strains: **Fov1 (race 1), Fov4 (race 4), 17-3, and 18-24**.

Hybrid genome assemblies were generated using Oxford Nanopore MinION long-read sequencing combined with Illumina paired-end short-read sequencing for polishing and error correction. Strain-specific genome assemblies and gene annotations were used for downstream analyses.

RNA-seq data were generated for Fov1 and Fov4 under control (CK) and inoculated (Int) conditions, with three independent biological replicates per condition. Reads were aligned to their respective strain-specific genome assemblies using **STAR**, and gene-level expression abundance was estimated using **RSEM**. Processed gene expression matrices (expected counts and TPM values) were used for downstream differential expression and comparative analyses.

---

## Repository Contents

This repository includes:

- Genome assembly and polishing workflows  
- Gene annotation scripts  
- RNA-seq alignment and quantification pipelines  
- Comparative genomics analysis workflows
- SNP analysis workflow

All analyses were executed on a Linux-based high-performance computing (HPC) cluster.

Software versions, parameters, and runtime configurations are documented within the corresponding scripts to ensure reproducibility.

---

## Data Availability

Genome assemblies, gene annotations, and raw whole-genome sequencing (WGS) data (Oxford Nanopore and Illumina) are available under NCBI BioProject accession:

**PRJNA1235835**

RNA-seq raw data are deposited in the NCBI Sequence Read Archive (SRA) under the same BioProject.

Processed gene expression matrices are available in the NCBI Gene Expression Omnibus (GEO) under accession:

**GSE320225**

---

## Reproducibility

All software versions and parameter settings are explicitly specified within the analysis scripts.
