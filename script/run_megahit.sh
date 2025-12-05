#!/bin/bash

# List of sample prefixes (replicates)
samples=("SWT2R1" "SWT2R2" "SWT2R3")

# Loop through each sample
for sample in "${samples[@]}"; do # expands to each element of the array as a separate word, preserving any quotes around elements with spaces.
    echo "Running megaHIT for $sample..."

    # Define file names
    R1="${sample}_15_L001_R1_001_kneaddata.fastq"
    R2="${sample}_15_L001_R2_001_kneaddata.fastq"

    # Define output directory
    outdir="${sample}_megahit"

    # Run metaSPAdes
    megahit -1 "$R1" -2 "$R2" -o "$outdir"
    # metaspades.py -1 "$R1" -2 "$R2" -o "$outdir"

    echo "Finished $sample. Results in $outdir"
done
