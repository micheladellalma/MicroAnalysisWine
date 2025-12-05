#!/bin/bash

source ~/miniconda3/bin/activate
conda activate prodigal-env

for folder in /mnt/c/Users/stude/OneDrive\ -\ Università\ degli\ Studi\ di\ Milano\ \(1\)/michela_0/Savorgnano/Functional_annotation/*; do
    echo "Processing: $folder"
    cd "$folder/0_prodigal" || continue
    parent_dir=$(dirname "$folder")
    R1_file="$parent_dir"/*_R1_*.fastq.gz
    R2_file="$parent_dir"/*_R2_*.fastq.gz
    prodigal -i final.contigs.fa -a my.proteins.faa -d orf.fna -p meta # taking all the open reading frame from the files
    prodigal_dir=$(pwd)
    cd ../1_cd_hit_new || continue
    cd-hit -i "$prodigal_dir/final.contigs.fa" \
    -o non_redundant.fasta -c 0.95 -n 5
    kma index -i non_redundant.fasta -o clustered_genes_indexed
    kma -ipe "$R1_file" "$R2_file" \ # remember to put the dollar sign before the variable
    -o kma_output -t_db clustered_genes_indexed -t 8 -mem_mode -apm f
    # activation of the eggnog conda environment
    conda activate eggnog
    emapper.py -i non_redundant.fasta --itype metagenome -o eggnog_annot 
done