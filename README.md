# MultiOmicsFermentation

## Overview
MuliOmicsFermentation is a workflow for identifying the dynamics of microorganisms, pathways and metabolites during the fermentation process.
The final output is a multi-layered network, in which the layers are the different time points.

It uses different programming languages, in particular R, Python and Bash.

This is an image of the initial inputs, and final table obtained, from which the network is designed.

<img width="781" height="269" alt="Screenshot 2025-12-04 at 09 24 06" src="https://github.com/user-attachments/assets/f35888dc-a37d-4a38-b31c-4adb3bd992b1" />

In reality in the middle, there are many more steps...
the image below is an overview of all the workflow

<img width="522" height="428" alt="image" src="https://github.com/user-attachments/assets/bbdd70b6-1845-47d0-ad18-c287a8691ca0" />


Among the different steps of the pipeline:

1. **Preprocessing** of the data
2. **Taxonomic classification** and **differential abundance** of taxa between time points
3. **Discovering** of the **pathways** potentially expressed and definition of the pathways enriched for each time point
4. **Metabolites classification** into chemical groups and search for enriched metabolites per time point
5. **Integration** of all the data and **Network analysis**
