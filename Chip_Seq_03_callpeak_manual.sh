#!/bin/bash


set -e
set -u
set -o pipefail

# This is just a ChIP simple script for call peak
# you can only put the scrpr in 03_filter_alignment

# set up the software environment
module load MACS/2.1.2


# make the output file
mkdir -p ../04_callpeak/merge_peak
mkdir -p ../04_callpeak/div_peak
mkdir -p ../../logs/macs2/merge_peak
mkdir -p ../../logs/macs2/div_peak

# set up filenames
div_callpeak_out=../04_callpeak/div_peak
div_callpeak_log=../../logs/macs2/div_peak

# make a array
name_array=("Root_Tip_3d_Rep1_H3K27me3" "Root_Tip_3d_Rep2_H3K27me3" "Root_Tip_7d_Rep1_H3K27me3" "Root_Tip_7d_Rep2_H3K27me3")


index=0

for i in `seq 49 52`
do
    echo "IP:CYJ-${i}.rm_organelle.bam" "Input:CYJ-$[i+4].rm_organelle.bam"  ${name_array[index]}
 
     macs2 callpeak \
     -t CYJ-${i}.rm_organelle.bam \
     -c CYJ-$[i+4].rm_organelle.bam \
     -f BAMPE \
     -n ${name_array[index]} \
     --broad \
     -g 1.1e8 \
     --outdir ${div_callpeak_out} 2> ${div_callpeak_log}/${name_array[index]}.log &
 
     index=$[index + 1]
 done
