#!/bin/bash
#SBATCH --job-name=test
#SBATCH --time=00:20:00
#SBATCH --partition=regularshort
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --reservation=nanoscale

module load LAMMPS/23Jun2022-foss-2021b-kokkos
srun lmp -in scripts/in.3dlj > out.dat
