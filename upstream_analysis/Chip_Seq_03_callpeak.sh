#!/bin/bash

set -e
set -u
set -o pipefail

if [ "$1" == "-h" ]
then
    echo "Usage: `basename $0` work_path geom_size"
	echo "default is At"
	echo 

    echo "This script is for Chip_bamtobw"
    echo -e "After align & filter, use the MACS2 to call peak"

    exit 0
fi

# set up the software environment
module load MACS/2.1.2

# set the work path
work_path=$1

# set the genome size 
genome_size=${2-1.1e8}

# make the output file
mkdir -p ${work_path}/result/04_callpeak/merge_peak
mkdir -p ${work_path}/result/04_callpeak/div_peak
mkdir -p ${work_path}/logs/macs2/merge_peak
mkdir -p ${work_path}/logs/macs2/div_peak

# set up filenames
input_file=${work_path}/result/03_filter_alignment
div_callpeak_out=${work_path}/result/04_callpeak/div_peak
div_callpeak_log=${work_path}/logs/macs2/div_peak

# MACS2
echo macs2 div_callpeak will begin 

ls ${input_file}/*IP-*rm_organelle.bam | while read id;
do
    IP=$(basename ${id} .rm_organelle.bam)
	input=$(echo ${IP} | sed 's/IP/input/g')
	
	base=$(echo ${IP} | sed 's/-IP-/_/g')
	
	echo ${IP} ${input} ${base}
	
    macs2 callpeak -t ${input_file}/${IP}.rm_organelle.bam \
	-c ${input_file}/${input}.rm_organelle.bam \
	-f BAMPE \
    -n ${base} \
    -g ${genome_size} \
    --outdir ${div_callpeak_out} 2> ${div_callpeak_log}/${base}.log 
done
