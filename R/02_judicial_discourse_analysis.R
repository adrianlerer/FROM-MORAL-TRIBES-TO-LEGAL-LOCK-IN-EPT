# ==============================================================================
# 02_judicial_discourse_analysis.R
# Replicates Table 3: Judicial Moral Language
# Author: Ignacio Adrian Lerer
# ==============================================================================

source("R/00_setup.R")

# Load data
jud_data <- read_csv("data/judicial_discourse_sample.csv")

# Split by country
arg <- jud_data %>% filter(country == "Argentina")
chl <- jud_data %>% filter(country == "Chile")

# ==============================================================================
# Summary statistics
# ==============================================================================

summary_judicial <- jud_data %>%
  group_by(country) %>%
  summarise(
    n_opinions = n(),
    sacralization_median = median(sacralization_index),
    sacralization_mean = mean(sacralization_index),
    sacralization_sd = sd(sacralization_index),
    inalienable_mean = mean(inalienable_count),
    inalienable_sd = sd(inalienable_count),
    sacred_mean = mean(sacred_count),
    sacred_sd = sd(sacred_count),
    empirical_mean = mean(empirical_citations),
    empirical_sd = sd(empirical_citations),
    cost_benefit_pct = mean(cost_benefit_present) * 100
  )

print(summary_judicial)

# ==============================================================================
# Statistical tests (Table 3)
# ==============================================================================

# Test 1: Sacralization Index (Mann-Whitney U for median comparison)
wilcox_sacral <- wilcox.test(arg$sacralization_index, chl$sacralization_index)
d_sacral <- calc_cohens_d(arg$sacralization_index, chl$sacralization_index)

# Test 2: "Inalienable" frequency
t_inalienable <- t.test(arg$inalienable_count, chl$inalienable_count, var.equal = FALSE)
d_inalienable <- calc_cohens_d(arg$inalienable_count, chl$inalienable_count)

# Test 3: "Sacred/Sagrado" frequency
t_sacred <- t.test(arg$sacred_count, chl$sacred_count, var.equal = FALSE)
d_sacred <- calc_cohens_d(arg$sacred_count, chl$sacred_count)

# Test 4: Empirical citations
t_empirical <- t.test(arg$empirical_citations, chl$empirical_citations, var.equal = FALSE)
d_empirical <- calc_cohens_d(arg$empirical_citations, chl$empirical_citations)

# Test 5: Cost-benefit analysis present (chi-square)
chi_cb <- chisq.test(table(jud_data$country, jud_data$cost_benefit_present))

# ==============================================================================
# Build Table 3
# ==============================================================================

table3 <- tibble(
  Metric = c(
    "Sacralization Index (median)",
    "\"Inalienable\" per opinion",
    "\"Sacred\"/\"Sagrado\" frequency",
    "Empirical citations (mean)",
    "Cost-benefit analysis present"
  ),
  Argentina = c(
    sprintf("%.1f", median(arg$sacralization_index)),
    sprintf("%.1f", mean(arg$inalienable_count)),
    sprintf("%.1f", mean(arg$sacred_count)),
    sprintf("%.1f", mean(arg$empirical_citations)),
    sprintf("%.0f%%", mean(arg$cost_benefit_present) * 100)
  ),
  Chile = c(
    sprintf("%.1f", median(chl$sacralization_index)),
    sprintf("%.1f", mean(chl$inalienable_count)),
    sprintf("%.1f", mean(chl$sacred_count)),
    sprintf("%.1f", mean(chl$empirical_citations)),
    sprintf("%.0f%%", mean(chl$cost_benefit_present) * 100)
  ),
  Cohens_d = c(
    sprintf("%.2f", d_sacral),
    sprintf("%.2f", d_inalienable),
    sprintf("%.2f", d_sacred),
    sprintf("%.2f", d_empirical),
    "—"
  ),
  p_value = c(
    ifelse(wilcox_sacral$p.value < 0.001, "<0.001***", sprintf("%.3f", wilcox_sacral$p.value)),
    ifelse(t_inalienable$p.value < 0.001, "<0.001***", sprintf("%.3f", t_inalienable$p.value)),
    ifelse(t_sacred$p.value < 0.001, "<0.001***", sprintf("%.3f", t_sacred$p.value)),
    ifelse(t_empirical$p.value < 0.001, "<0.001***", sprintf("%.3f", t_empirical$p.value)),
    ifelse(chi_cb$p.value < 0.001, "<0.001***", sprintf("%.3f", chi_cb$p.value))
  )
)

print(table3)

# ==============================================================================
# Save results
# ==============================================================================

write_csv(table3, "output/tables/table3_judicial_discourse.csv")

# LaTeX version
if (requireNamespace("kableExtra", quietly = TRUE)) {
  table3_latex <- kableExtra::kbl(
    table3,
    format = "latex",
    booktabs = TRUE,
    caption = "Judicial Moral Language"
  ) %>%
    kableExtra::kable_styling(latex_options = c("hold_position"))
  
  writeLines(table3_latex, "output/tables/table3_judicial_discourse.tex")
}

cat("\nTable 3 saved to output/tables/\n")

# ==============================================================================
# Effect size interpretation
# ==============================================================================

cat("\n=== Effect Size Interpretation ===\n")
cat("Cohen's d > 0.5 indicates medium-to-large effect size\n")
cat("Sacralization Index d =", round(d_sacral, 2), 
    ifelse(abs(d_sacral) > 0.5, "(medium-large)", "(small)"), "\n")
cat("Empirical citations d =", round(d_empirical, 2), 
    ifelse(abs(d_empirical) > 0.5, "(medium-large)", "(small)"), "\n")
