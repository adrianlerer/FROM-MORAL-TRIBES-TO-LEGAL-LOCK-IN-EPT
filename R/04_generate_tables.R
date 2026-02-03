# ==============================================================================
# 04_generate_tables.R
# Generate all tables for the paper
# Author: Ignacio Adrian Lerer
# ==============================================================================

cat("Generating all tables...\n\n")

# Run all analysis scripts
source("R/01_legislative_analysis.R")
cat("\n--- Legislative analysis complete ---\n\n")

source("R/02_judicial_discourse_analysis.R")
cat("\n--- Judicial discourse analysis complete ---\n\n")

source("R/03_chile_case_study.R")
cat("\n--- Chile case study complete ---\n\n")

# ==============================================================================
# Generate Table 1: Institutional Temperature Index
# ==============================================================================

temp_data <- read_csv("data/institutional_temperature_index.csv")

table1 <- temp_data %>%
  filter(dimension != "total_temperature_index") %>%
  select(
    Dimension = dimension,
    Argentina = argentina_score,
    Chile = chile_score,
    `Cooling Effect` = cooling_effect
  ) %>%
  mutate(
    Dimension = case_when(
      Dimension == "supermajority_requirement" ~ "Supermajority requirement",
      Dimension == "mixed_commissions" ~ "Mixed commissions",
      Dimension == "cooling_off_periods" ~ "Cooling-off periods",
      Dimension == "expert_testimony_requirement" ~ "Expert testimony requirement",
      Dimension == "mandatory_referendum_gates" ~ "Mandatory referendum gates",
      Dimension == "impeachment_threshold" ~ "Impeachment threshold",
      TRUE ~ Dimension
    )
  )

# Add total row
total_row <- temp_data %>%
  filter(dimension == "total_temperature_index") %>%
  transmute(
    Dimension = "TOTAL TEMPERATURE INDEX",
    Argentina = argentina_score,
    Chile = chile_score,
    `Cooling Effect` = paste0("Δ = ", chile_score - argentina_score)
  )

table1 <- bind_rows(table1, total_row)

write_csv(table1, "output/tables/table1_temperature_index.csv")

cat("\nTable 1: Institutional Temperature Index\n")
print(table1)

# ==============================================================================
# Summary of all outputs
# ==============================================================================

cat("\n\n========================================\n")
cat("ALL TABLES GENERATED SUCCESSFULLY\n")
cat("========================================\n\n")

cat("Output files:\n")
cat("  - output/tables/table1_temperature_index.csv\n")
cat("  - output/tables/table2_legislative_outcomes.csv\n")
cat("  - output/tables/table3_judicial_discourse.csv\n")
cat("  - output/tables/chile_constitutional_summary.csv\n")
cat("  - output/figures/chile_approval_trajectory.png\n")

cat("\nLaTeX versions (if kableExtra installed):\n")
cat("  - output/tables/table2_legislative_outcomes.tex\n")
cat("  - output/tables/table3_judicial_discourse.tex\n")
