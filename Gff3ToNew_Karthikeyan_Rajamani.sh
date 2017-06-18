#!/bin/bash
#Karthikeyan Rajamani 
#Usage:ThisScript Saccharomyces_cerevisiae.R64-1-1.34.gff3  ChromosomeChoice OutputFile
#Ex: from Ctools/MyHw6> ./Gff3ToNew_Karthikeyan_Rajamani.sh  Saccharomyces_cerevisiae.R64-1-1.34.gff3  "I" GFF3ToNewOut_I.txt

InputFile=$1
ChromsomeName=$2
OutputFile=$3


awk -v newChr=$ChromsomeName '$1==newChr {print $0}' $InputFile > chromosome_filter.txt
awk '$3=="CDS"  {print $0}' chromosome_filter.txt >CDS_filter.txt
awk 'BEGIN{print "Chromosome\tStart\tStop\tLength\tCDSID\tProteinID"}'>$OutputFile
awk 'BEGIN{OFS="\t"}{print $1,$4,$5,$5-$4+1,awk,gensub(/.*CDS:([^;]*).*/,"\\1",1,$0),gensub(/.*protein_id=([^;]*).*/,"\\1",1,$0)}' CDS_filter.txt >> $OutputFile


