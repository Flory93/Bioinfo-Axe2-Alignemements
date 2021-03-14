#!/bin/sh
blastp -query $1 -db nr -outfmt 6 -remote | awk '$3>95' | cut -f2 > matches_id.txt

fichier=matches_id.txt
if [ -s $fichier ]; then
  for line in $(cat $fichier)
  do
  esearch -db protein -query "$line"| efetch -format fasta >> sequences.fasta
  done
else
  echo "fichier vide"
fi

mafft --auto sequences.fasta > alignement.fasta

open alignement.fasta