library(tidyverse)

# Load your saved data (in case you're starting fresh)
cftr_all_variants <- read_csv("data/cftr_clinvar_variants.csv")

# Count variants by classification
classification_counts <- cftr_all_variants %>%
  count(classification, sort = TRUE) %>%
  filter(!is.na(classification))

# Plot
fig4 <- ggplot(classification_counts, aes(x = reorder(classification, n), y = n)) +
  geom_col(fill = "#2c7fb8") +
  coord_flip() +
  labs(
    title = "Clinical Significance of CFTR Variants",
    subtitle = "6,466 variants recorded in ClinVar",
    x = NULL,
    y = "Number of variants"
  ) +
  theme_minimal(base_size = 13)

fig4

ggsave("figures/fig4_clinical_significance.png", fig4, width = 8, height = 6, dpi = 300)
