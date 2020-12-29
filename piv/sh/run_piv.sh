#!/bin/sh

bsub -J "ATA" -o "stdo%J.txt" -n 1 "$LSF_BINDIR/openmpi_wrapper ./piv_20201223br.sh"
