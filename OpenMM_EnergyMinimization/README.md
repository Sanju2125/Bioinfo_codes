## Energy Minimization with Backbone Restraints (OpenMM)

This script performs energy minimization of a protein structure using OpenMM,
with weak harmonic restraints applied to Cα (CA) atoms to preserve the backbone
during relaxation.

The input PDB structure is first repaired using PDBFixer to handle missing
residues, atoms, and hydrogens.

### Features
- Automatic PDB fixing (missing atoms, hydrogens, nonstandard residues)
- CHARMM36 force field
- Energy minimization only
- Weak positional restraints on backbone Cα atoms

### Requirements
- Python
- OpenMM
- PDBFixer

