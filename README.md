# Tutorial 1

## Assignment 1

Before running new simulations, familiarize yourself with the visualization software [Ovito](https://www.ovito.org/)! You will use it for the entire course. 
With Ovito you can visualize and render the trajectories of your simulations (both images and videos) and perform some rudimentary data analysis on the fly.

### Instructions

1a. visualize Quantum Espresso simulations

Load the Quantum Espresso file, perform some analyses.

1b. visualize Lammps simulations

The next system is much larger and was generated with Lammps and MD. It is a model hydrogel, a network of crosslinked polymer strands swollen with water (implicit in this simulation). More on the physics of these systems in Lecture 8!
Now we just focus on basic information we can extract with Ovito from a few snapshots.

-Open with Ovito the "no_reacted.data" file. Determine how many different atoms, atom types, bonds, and bond types are present in the system.
-Isolate a single molecule, using the selection modification tools in the Ovito pipeline. Make a snapshot of the molecule. Play with color and shape/size representation by changing the color and size of different atom types as you see fit.
-How many atoms are present in a molecule? How many molecules are present in the entire simulation? 
-The atoms at the extremity of the molecule will later react and form new bonds; what is the type of the reactive atoms and how many are there per molecule?
- Use a cluster analysis by bonds to determine again how many molecules are present in the system, and to color different molecules based on their molecular id. Make a snapshot of this coloring scheme.

-Now open in parallel the files "half-reacted.data" and "full_reacted.data". See how to set up a parallel visualization [here.](https://www.ovito.org/manual/advanced_topics/viewport_layouts.html)
-The two new systems come from the first one, with the addition of chemical reactions among reactive beads which change the system from a set of disconnected molecules to a connected network. Repeat the analyses of bond, molecules, and clusters 
as before. Compare and explain your findings.
- Focus now on the "full_reacted.data" system. Now, instead of full molecules as before, we will focus on new chains that are created by the reactions. The atoms in these chains follow the sequence [-A-A-B-], with A as the reactive atom (Can you guess B?). Select only reacted atoms (be careful, atom type changes once beads react!) and B-type atoms and make a cluster analysis on them. Report the distribution of cluster size calculated by Ovito.
This is a measure of the topological heterogeneity of the network, a fascinating topic we will discuss again in Lecture 8!  

## Assignment 2

Time to go on Habrok and run your first DFT simulation! To connect to Habrok (make sure you have an account and if you still don't, please follow the steps in [README.md](https://github.com/giuntoli-group/nanoscale-material-modelling/blob/main/README.md)). This assignment is also connected to next week's exercises on the electronic properties of bulk silicon.

### Instructions

2a. **Run Simulation**

Copy to your working directory the input file for Quantum Espresso ‘Si.scf.in’ as well as the pseudopotential file ‘Si.pbe-nl-rrkjus_psl.1.0.0.UPF’. Open the file ‘Si.scf.in’ using any editor (such as vi or nedit). Compare the parameters that you see with those listed on www.quantum-espresso.org/Doc/INPUT_PW.html. Take time to understand different parameters that you see in the file, check their meaning at the website. Close the file. Copy the file 'quantum.qsub' and submit the job by typing:

sbatch quantum.qsub 

Use squeue –u <username> to see the job status.

Several files will be created during the calculation. The most important is the output file Si.scf.out which contains all the information about the calculation. Once the calculation finishes correctly, you should be able to see at the end of the file:

This run was terminated on:  XXX  21March2025
JOB DONE.

2b. **Make sure that the total energy is well-converged in your calculation.** You can use the command:

grep 'total energy' Si.scf.out

How can you make your total energy more accurate? Which parameter in the input file do you need to vary? Check the Quantum Espresso website and run another calculation with a stricter convergence criterion. When it is finished, check again the accuracy of your total energy. Don't forget to save your old 'Si.scf.out' file. 

2c. **Vary the size of k-points mesh** in your input file and rerun the calculation. How does it affect the total energy? 

2d. **Vary the kinetic energy cutoff ecutwfc**. Run the calculations 20 Ry and 50 Ry and check how it impacts the total energy. What do you observe?

## Assignment 3

Time to also run your first MD simulation! All basic information about Habrok does not change, but this time you will use the software Lammps. 
This assignment is also connected to the MD assignment of the course Computational Physics, and it introduces the fundamental packing problem in soft matter which will come back in Lecture 5.

### Instructions

3a. **Run Simulation**
   - Open the 'in.3dlj' lammps script.
     Spend some time reading the different commands in the script, learn what they do using the [LAMMPS manual](https://docs.lammps.org/Manual.html), and familiarize yourself with basic Lammps syntax. Good time investment! 
   - Execute the `in.3dlj` script on Habrok.
   - Visualise the trajectory on Ovito. Can you observe any crystalline regions with the naked eye? Try to do the same using the Common neighbor analysis in Ovito, and report your findings.

3b. **Extract Data from Log File**
   - From the LAMMPS log file generated by the simulation, extract the following as a function of time:
     - Temperature
     - Pressure
     - Kinetic Energy
     - Potential Energy
   - The log file is saved in a YAML format, which can be loaded into a Pandas DataFrame for easy manipulation. See the code snippet [here](https://docs.lammps.org/Howto_structured_data.html#extracting-data-from-log-file), and load the thermodynamic information into ypur Pyhton environment

3c. **Beadspring Analytics**
   - You have already installed [beadspring](https://github.com/utkugurel/beadspring). If it somehow doesn't work, please contact Utku
   - You will find a minimally working example analysis script on the beadspring repo. Try to replicate it for your system. 
   - Note that we rely on multiple Python packages and you might want to check certain functionalities within their documentation pages. You will find an incomplete list of those at the end of beadspring README.
   - Compute and report the radial distribution function and the mean squared displacement.
   - Refer to the following submodules for the computations:
     - `structural_properties`
     - `dynamical_properties`

3d. **Run at Different Conditions**
   - Perform new simulations with the same script, but varying different temperatures and packing fractions.
   - Plot your the radial distribution functions and MSDs as functions of external parameters, and discuss your findings. For example, think about which systems are behaving like gases, liquids, or solids, and what you base your evidence on.

## Assignment 4

A key component of setting up quantum and molecular models is to determine their computational cost. Since you will make these evaluations throughout the course, let's get some intuition for it now!

4a. Benchmark the performance of Quantum Espresso for silicon. It is a small calculation and does not require running on many processors. Try to run your initial 'Si.scf.in' file using 2 processors and 64 processors. What is the difference in the length calculations? Which of the three calculations is optimal?

4b. Repeat the test for a significantly higher k-mesh. Do your observations remain the same?

4c. Benchmark Lammps simulations.
   - start again from the file 'in.3dlj', fixing the packing fraction to 0.5 and the temperature to 1.0. Vary the cutoff of the lennard-jones interaction potential (currently at 1.12) and report the efficiency of the code (timesteps per unit time)
     with varying cutoff value. For this step, fix the number of processors M and the number of particles N you are using.
   - repeat the calculation by using a cutoff of 1.12, but adding a coulombic repulsion potential among the particles, and setting the charge of each particle to +1.
   - Repeat this exercise varying the number of particles N and number of processors M, and draw your conclusions on the efficiency of parallelization of Lammps on Habrok.

## Additional Information

- Ensure you have the necessary dependencies installed for running the simulations and data analysis.
- Use the provided scripts and submodules to assist with the computations and visualizations.
- Document your observations and results thoroughly for each step.
