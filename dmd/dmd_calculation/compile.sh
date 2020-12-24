#!/bin/sh

#. /etc/profile.d/modules.sh
#module load intel
#module load intel-mpi

#mpiifort -O3 -mcmodel=medium -traceback -fpe0 grid_m.f90 mpi_m.f90 arrays_m.f90 dmd.f90 -mkl
#mpif90 -O3 -mcmodel=medium -traceback -fpe0 grid_m.f90 mpi_m.f90 arrays_m.f90 dmd.f90 -mkl
mpif90 -O3 -mcmodel=large -traceback -fpe0 grid_m.f90 mpi_m.f90 arrays_m.f90 dmd.f90 -mkl

rm *.mod
