from ase.io import read, write

#QE input or output file
folder="/example/directory/"
atoms=read(f'{folder}scf.out')

# Some VESTA readable outputs examples (For pure visualization any work)
# Check ASE documentation for further info 

# write(f'{folder}scf.vasp', atoms, direct=0) #direct=True for crystal coords
# write(f'{folder}scf.cif', atoms, ) #Crystallographic information file
write(f'{folder}scf.xsf', atoms) #Xcrysden can read these too