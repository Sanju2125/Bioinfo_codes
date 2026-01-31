## Biopython Utilities: Entrez Search, Alignment, and PDB Parsing

This collection of Python scripts demonstrates core bioinformatics tasks using
Biopython, including sequence retrieval from NCBI, pairwise sequence alignment,
and basic parsing of PDB structure files.

The code is intended for exploratory analysis and learning Biopython workflows.

### Features
- Search and fetch protein sequences from NCBI using Entrez
- Download and store FASTA-formatted protein sequences
- Perform local pairwise sequence alignment
- Parse PDB files to summarize atom occurrences per residue

### Main Libraries Used
- `Bio.Entrez`
- `Bio.SeqIO`
- `Bio.pairwise2`
- Python standard libraries (`os`)

### Entrez Usage
- Queries the NCBI protein database (example: *insulin* from *E. coli*)
- Retrieves multiple sequence records in FASTA format
- Requires a valid email address for NCBI Entrez access

### Alignment
- Local pairwise alignment using `pairwise2.align.localxx`
- Outputs formatted alignment for inspection

### PDB Parsing
- Reads a PDB file and builds a nested dictionary
- Counts atoms per amino acid residue from `ATOM` records

### Notes
- File paths are currently hard-coded and may need adjustment
- Intended for small datasets and demonstration purposes

