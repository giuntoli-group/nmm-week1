#!/bin/bash
#SBATCH -J QE_Si
#SBATCH -o %j.out
#SBATCH -p parallel
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 00:05:00

module load QuantumESPRESSO/7.1-foss-2022a
srun pw.x < Si.scf.in > Si.scf.out
