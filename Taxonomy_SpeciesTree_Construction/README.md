## Species Taxonomy Mapping and Tree Construction (Python)

This script processes a list of species names, resolves their NCBI taxonomic
identifiers (taxids) using a local NCBI taxonomy database, and constructs a
species-level phylogenetic tree.

In addition, the script identifies unique and repeated species names from the
input list and writes them to separate output files.

### Features
- Uses a local NCBI taxonomy database via `ete3`
- Resolves species names to NCBI taxids
- Supports manual taxid mapping for unresolved or ambiguous taxa
- Builds and visualizes a species topology tree
- Exports the tree in Newick format
- Identifies and separates unique and repeated species names

### Requirements
- Python 3.x
- `ete3`
- Local NCBI taxonomy database (`taxdump`)

### Input
- A text file containing species names (one per line)

### Output
- `species_tree.nwk` — species tree in Newick format
- `unique_species.txt` — species appearing once in the input
- `repeated_species.txt` — species appearing multiple times in the input

### Notes
- The environment variable `ETE_NCBI_TAXONOMY_DB` must point to the local NCBI
  taxonomy database directory
- Manual taxid mappings can be added for taxa not resolved automatically
- Tree topology is based on NCBI taxonomy, not sequence-based inference

### Disclaimer
This script is intended for exploratory and preprocessing purposes and may
require customization for large datasets or downstream phylogenetic analyses.
