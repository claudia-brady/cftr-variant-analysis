library(rentrez)
library(tidyverse)
library(stringr)

# Fetch the CFTR mRNA reference record (NM_000492.4) in GenBank format
cftr_gb <- entrez_fetch(
  db = "nuccore",
  id = "NM_000492.4",
  rettype = "gb",
  retmode = "text"
)

# Look at the raw text so we can find the exon/CDS structure
cat(substr(cftr_gb, 1, 3000))
# CFTR's RefSeqGene record (genomic, with exon annotations)
cftr_genomic <- entrez_fetch(
  db = "nuccore",
  id = "NG_016465.4",
  rettype = "gb",
  retmode = "text"
)

# Look for the FEATURES section, specifically "exon" entries
cat(substr(cftr_genomic, 1, 5000))
library(tidyverse)

# CFTR exon coordinates - directly from NCBI RefSeqGene NG_016465.4
# Source: mRNA join() feature, verified against exon /number= annotations
cftr_exons <- tibble(
  exon_number = 1:27,
  start = c(19180, 43470, 48251, 70116, 73493, 74465, 75765, 79317, 81233,
            87858, 98681, 126956, 129570, 131151, 134147, 142043, 142749,
            145891, 149736, 150798, 153830, 166739, 181655, 192059,
            203905, 204676, 206125),
  end = c(19364, 43580, 48359, 70331, 73582, 74628, 75890, 79563, 81325,
          88040, 98872, 127050, 129656, 131874, 134275, 142080, 142999,
          145970, 149886, 151025, 153930, 166987, 181810, 192148,
          204077, 204781, 207882)
) %>%
  mutate(exon_length = end - start,
         intron_before = start - lag(end))

View(cftr_exons)

write_csv(cftr_exons, "data/cftr_exon_structure.csv")