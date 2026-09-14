library(rentrez)
library(tidyverse)

# Search ClinVar for CFTR variants
cftr_search <- entrez_search(
  db = "clinvar",
  term = "CFTR[gene]",
  retmax = 500
)

# Check how many variants were found
cftr_search$count
# Get the actual ClinVar IDs from the search
cftr_ids <- cftr_search$ids

# Pull summaries for a manageable batch first (first 100) to test
cftr_summary <- entrez_summary(db = "clinvar", id = cftr_ids[1:100])

# Look at what one record contains
cftr_summary[[1]]

# Extract key fields into a tidy data frame
cftr_variants <- map_dfr(cftr_summary, function(x) {
  tibble(
    uid = x$uid,
    title = x$title,
    classification = x$germline_classification$description,
    protein_change = x$protein_change,
    consequence = paste(x$molecular_consequence_list, collapse = "; "),
    location = x$location_sort
  )
})

View(cftr_variants)
