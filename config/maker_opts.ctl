#-----Genome
genome=assembly.fasta.masked
organism_type=eukaryotic

#-----Re-annotation Using MAKER Derived GFF3
maker_gff=
est_pass=0
altest_pass=0
protein_pass=0
rm_pass=0
model_pass=0
pred_pass=0
other_pass=0

#-----EST Evidence
est=data/Fusarium_oxysporum_f_sp_lycopersici_4287.cds.fa
altest=data/Fusarium_oxysporum_f_sp_lycopersici_4287.cdna.fa
est_gff=data/merged_est_alignments.gff3
altest_gff=data/alternate_est_alignments.gff3

#-----Protein Homology Evidence
protein=data/Fusarium_oxysporum_f_sp_lycopersici_4287.proteins.fa
protein_gff=

#-----Repeat Masking
model_org=all
rmlib=
repeat_protein=data/te_proteins.fasta
rm_gff=
prok_rm=0
softmask=1

#-----Gene Prediction
snaphmm=
gmhmm=data/genemark.mod
augustus_species=fusarium
fgenesh_par_file=
pred_gff=
model_gff=
run_evm=0
est2genome=1
protein2genome=1
trna=1
unmask=1

#-----Other Annotation Feature Types
other_gff=

#-----External Application Behavior Options
alt_peptide=C
cpus=1

#-----MAKER Behavior Options
max_dna_len=100000
min_contig=1

pred_flank=200
pred_stats=0
AED_threshold=1
min_protein=0
alt_splice=0
always_complete=0
map_forward=0
keep_preds=0

split_hit=10000
min_intron=20
single_exon=0
single_length=250
correct_est_fusion=0

tries=2
clean_try=0
clean_up=0
TMP=
