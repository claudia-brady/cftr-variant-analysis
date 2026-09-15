library(biomaRt)
enseml <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
cftr_info <- getBM(
  attributes = c("ensembl_gene_id","external_gene_name", "chromosome_name", "start_position", "end_position", "strand"),
  filters = "external_gene_name",
  values = "CFTR",
  mart = ensembl
)
View(cftr_info)
