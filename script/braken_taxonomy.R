# Script to parse braken/kraken output
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

file_path="/Users/micheladellalma/Library/CloudStorage/OneDrive-UniversitàdegliStudidiMilano/bracken"

# Function to parse a single report file and reconstruct lineage
parse_report_file <- function(file_path) {
  # Get sample name from file name
  sample_name <- str_replace(basename(file_path), "\\.report$", "")
  
  # Read in file
  df <- read_tsv(file_path, col_names = FALSE, show_col_types = FALSE)
  colnames(df) <- c("pct_reads", "reads", "added_reads", "rank", "taxid", "name")
  
  # Trim leading whitespace from name
  df$name <- trimws(df$name)
  
  # Initialize empty lineage tracker
  current_lineage <- list(
    kingdom = NA_character_,
    phylum = NA_character_,
    class = NA_character_,
    order = NA_character_,
    family = NA_character_,
    genus = NA_character_,
    species = NA_character_
  )
  
  # Prepare lineage columns
  df <- df %>%
    mutate(kingdom = NA_character_,
           phylum = NA_character_,
           class = NA_character_,
           order = NA_character_,
           family = NA_character_,
           genus = NA_character_,
           species = NA_character_)
  
  # Loop through each row to assign lineage
  for (i in 1:nrow(df)) {
    rank <- df$rank[i]
    name <- df$name[i]
    
    if (rank == "K") current_lineage$kingdom <- name
    if (rank == "P") current_lineage$phylum  <- name
    if (rank == "C") current_lineage$class   <- name
    if (rank == "O") current_lineage$order   <- name
    if (rank == "F") current_lineage$family  <- name
    if (rank == "G") current_lineage$genus   <- name
    if (rank == "S") current_lineage$species <- name
    
    # Assign current lineage to this row
    df[i, c("kingdom", "phylum", "class", "order", "family", "genus", "species")] <- current_lineage
  }
  
  # Filter only species-level entries
  df_species <- df %>%
    filter(rank == "S") %>%
    select(species, reads, kingdom, phylum, class, order, family, genus) %>%
    mutate(sample = sample_name)
  
  return(df_species)
}

#### process all files ####
 # Directory containing all your Bracken/Kraken report files
report_dir <- "/Users/micheladellalma/Library/CloudStorage/OneDrive-UniversitàdegliStudidiMilano/bracken"

# Get all .txt files in that folder
report_files <- list.files(report_dir, pattern = "\\.report$", full.names = TRUE)

# Apply the parser to all files
all_data <- bind_rows(lapply(report_files, parse_report_file))

#### create count table ##### Wide count matrix: rows = species, columns = samples
count_matrix <- all_data %>%
  select(species, sample, reads) %>%
  pivot_wider(names_from = sample, values_from = reads, values_fill = 0)

#### add taxonomy info ####
taxonomy_info <- all_data %>%
  select(species, kingdom, phylum, class, order, family, genus) %>%
  distinct()

# Join taxonomy to count matrix
#final_table <- taxonomy_info %>%
#  left_join(count_matrix, by = "species")

colnames(taxonomy_info)
# not correct classification of the kingdom, probably k DOES NOT REFER TO kingdom
# now we will fix it

taxonomy_info <- taxonomy_info %>%
  mutate(kingdom = case_when(
    str_detect(kingdom, "Fungi|Metazoa") ~ "Eukaryota",
    str_detect(kingdom, "Bacillati|Pseudomonadati|Thermotogati|Methanobacteriati") ~ "Bacteria",
    str_detect(kingdom, "virae") ~ "Viruses",
    TRUE ~ "Unclassified"
  ))
