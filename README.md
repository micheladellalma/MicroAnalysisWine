# MultiOmicsFermentation

## Overview
MuliOmicsFermentation is a workflow for identifying the dynamics of microorganisms, pathways and metabolites throughout the fermentation process.
The final output is a multi-layered network, where each layer corresponds to a different time point during fermentation.

This workflow leverages multiple programming languages, including R, Python, and Bash.

Below is an image illustrating the initial inputs and the final table used to construct the network:

<img width="781" height="269" alt="Screenshot 2025-12-04 at 09 24 06" src="https://github.com/user-attachments/assets/f35888dc-a37d-4a38-b31c-4adb3bd992b1" />

In reality in the middle, there are many more steps...
summarized in the following diagram:

<img width="522" height="428" alt="image" src="https://github.com/user-attachments/assets/bbdd70b6-1845-47d0-ad18-c287a8691ca0" />


Among the different steps of the pipeline:

1. **Preprocessing** of the data
2. **Taxonomic classification** and **differential abundance** of taxa between time points
3. **Discovering** of the **pathways** potentially expressed and definition of the pathways enriched for each time point
4. **Metabolites classification** into chemical groups and search for enriched metabolites per time point
5. **Integration** of all the data and **Network analysis**

<img width="349" height="208" alt="image" src="https://github.com/user-attachments/assets/a84b81d0-b2aa-49e6-b27c-e444886931e1" />


## How to use
For the initial steps of pre-processing and taxonomic classification...


## Repository structure
- /scripts contiene solo codici eseguibili da command line.
- /notebooks contiene analisi Rmd e Jupyter con parti descrittive e figure.
