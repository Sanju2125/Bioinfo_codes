from openmm import app, unit, CustomExternalForce
import openmm as mm
from pdbfixer import PDBFixer
import sys

input_pdb  = sys.argv[1]
output_pdb = sys.argv[2]


# Fix the struct

fixer = PDBFixer(filename=input_pdb)
fixer.findMissingResidues()
fixer.findNonstandardResidues()
fixer.replaceNonstandardResidues()
fixer.removeHeterogens(keepWater=False)
fixer.findMissingAtoms()
fixer.addMissingAtoms()
fixer.addMissingHydrogens(pH=7.0)

modeller = app.Modeller(fixer.topology, fixer.positions)


# FORCE FIELD ( CHARMM36)

forcefield = app.ForceField("charmm36.xml")

system = forcefield.createSystem(
    modeller.topology,
    nonbondedMethod=app.NoCutoff,
    constraints=app.HBonds
)


# Weak Backbone Restraints

restraint = CustomExternalForce(
    "0.5*k*((x-x0)^2 + (y-y0)^2 + (z-z0)^2)"
)
restraint.addGlobalParameter(
    "k", 0.5 * unit.kilocalories_per_mole / unit.angstroms**2
)
restraint.addPerParticleParameter("x0")
restraint.addPerParticleParameter("y0")
restraint.addPerParticleParameter("z0")

for atom in modeller.topology.atoms():
    if atom.name == "CA":
        pos = modeller.positions[atom.index]
        restraint.addParticle(atom.index, pos)

system.addForce(restraint)


# INTEGRATOR (minimization only)

integrator = mm.VerletIntegrator(0.001 * unit.picoseconds)

simulation = app.Simulation(modeller.topology, system, integrator)
simulation.context.setPositions(modeller.positions)

print("Energy minimization...")
simulation.minimizeEnergy(maxIterations=10000)


# Save the PDB struct

state = simulation.context.getState(getPositions=True)
with open(output_pdb, "w") as f:
    app.PDBFile.writeFile(
        modeller.topology,
        state.getPositions(),
        f,
        keepIds=True
    )

print(f"Minimized structure saved → {output_pdb}")
