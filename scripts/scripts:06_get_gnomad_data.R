library(tidyverse)
library(httr)
library(jsonlite)

# gnomAD's GraphQL endpoint
gnomad_query <- '
{
  gene(gene_symbol: "CFTR", reference_genome: GRCh38) {
    variants(dataset: gnomad_r4) {
      variant_id
      pos
      consequence
      hgvsp
      genome {
        af
        ac
        an
      }
    }
  }
}
'

response <- POST(
  url = "https://gnomad.broadinstitute.org/api",
  body = list(query = gnomad_query),
  encode = "json",
  content_type_json()
)

gnomad_data <- content(response, as = "parsed", simplifyVector = FALSE)

# Check it worked - should show a list, not an error
str(gnomad_data, max.level = 2)
