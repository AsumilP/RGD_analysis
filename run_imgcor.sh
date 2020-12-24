#!/bin/sh

bsub -J "ATA" -o "stdo%J.txt" -n 1 "$LSF_BINDIR/openmpi_wrapper ./imgcor"
