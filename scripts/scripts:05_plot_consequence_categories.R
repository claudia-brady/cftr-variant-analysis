library(tidyverse)

cftr_all_variants <- read_csv("data/cftr_clinvar_variants.csv")

# Consequence field can have multiple values separated by "; " - split and count
consequence_counts <- cftr_all_variants %>%
  filter(!is.na(consequence), consequence != "") %>%
  separate_rows(consequence, sep = "; ") %>%
  count(consequence, sort = TRUE)

fig3 <- ggplot(consequence_counts, aes(x = reorder(consequence, n), y = n)) +
  geom_col(fill = "#41ab5d") +
  coord_flip() +
  labs(
    title = "Molecular Consequence of CFTR Variants",
    subtitle = "Types of change caused by each variant", x = NULL,
    y = "Number of variants"
  ) +
  theme_minimal(base_size = 13)

fig3

ggsave("figures/fig3_consequence_categories.png", fig3, width = 8, height = 6, dpi = 300)
