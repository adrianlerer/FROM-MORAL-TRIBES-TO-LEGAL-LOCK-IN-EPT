# ==============================================================================
# 01_legislative_analysis.R
# Replicates Table 2: Legislative Outcomes (2015-2023)
# Author: Ignacio Adrian Lerer
# ==============================================================================

source("R/00_setup.R")

# Load data
leg_data <- read_csv("data/legislative_outcomes_arg_chl_2015_2023.csv")

# Split by country
arg <- leg_data %>% filter(country == "Argentina")
chl <- leg_data %>% filter(country == "Chile")

# ==============================================================================
# Summary statistics
# ==============================================================================

summary_stats <- leg_data %>%
  group_by(country) %>%
  summarise(
    n_years = n(),
    bills_passed_mean = mean(bills_passed),
    bills_passed_sd = sd(bills_passed),
    bipartisan_pct_mean = mean(bipartisan_pct),
    bipartisan_pct_sd = sd(bipartisan_pct),
    gridlock_mean = mean(gridlock_index),
    gridlock_sd = sd(gridlock_index),
    impeachment_mean = mean(impeachment_attempts),
    deadlock_pct = mean(sessions_deadlock) * 100
  )

print(summary_stats)

# ==============================================================================
# Statistical tests (Table 2)
# ==============================================================================

# Test 1: Bills passed per year
t_bills <- t.test(arg$bills_passed, chl$bills_passed, var.equal = FALSE)

# Test 2: Bipartisan support percentage
t_bipartisan <- t.test(arg$bipartisan_pct, chl$bipartisan_pct, var.equal = FALSE)

# Test 3: Gridlock Index
t_gridlock <- t.test(arg$gridlock_index, chl$gridlock_index, var.equal = FALSE)

# Test 4: Impeachment attempts (Welch's t-test)
t_impeach <- t.test(arg$impeachment_attempts, chl$impeachment_attempts, var.equal = FALSE)

# Test 5: Sessions ending in deadlock (proportion test)
prop_deadlock <- prop.test(
  c(sum(arg$sessions_deadlock), sum(chl$sessions_deadlock)),
  c(nrow(arg), nrow(chl))
)

# ==============================================================================
# Build Table 2
# ==============================================================================

table2 <- tibble(
  Metric = c(
    "Bills passed per year (mean)",
    "Bills with cross-party support (%)",
    "Gridlock Index (Binder 1999)",
    "Impeachment attempts per term",
    "Legislative sessions ending in deadlock"
  ),
  Argentina = c(
    sprintf("%.1f", mean(arg$bills_passed)),
    sprintf("%.1f", mean(arg$bipartisan_pct)),
    sprintf("%.2f", mean(arg$gridlock_index)),
    sprintf("%.1f", mean(arg$impeachment_attempts)),
    sprintf("%.0f%%", mean(arg$sessions_deadlock) * 100)
  ),
  Chile = c(
    sprintf("%.1f", mean(chl$bills_passed)),
    sprintf("%.1f", mean(chl$bipartisan_pct)),
    sprintf("%.2f", mean(chl$gridlock_index)),
    sprintf("%.1f", mean(chl$impeachment_attempts)),
    sprintf("%.0f%%", mean(chl$sessions_deadlock) * 100)
  ),
  Diff = c(
    sprintf("%.1f", mean(arg$bills_passed) - mean(chl$bills_passed)),
    sprintf("%.1f pp", mean(arg$bipartisan_pct) - mean(chl$bipartisan_pct)),
    sprintf("+%.2f", mean(arg$gridlock_index) - mean(chl$gridlock_index)),
    sprintf("+%.1f", mean(arg$impeachment_attempts) - mean(chl$impeachment_attempts)),
    sprintf("+%.0f pp", (mean(arg$sessions_deadlock) - mean(chl$sessions_deadlock)) * 100)
  ),
  p_value = c(
    ifelse(t_bills$p.value < 0.001, "<0.001***", sprintf("%.3f", t_bills$p.value)),
    ifelse(t_bipartisan$p.value < 0.001, "<0.001***", sprintf("%.3f", t_bipartisan$p.value)),
    ifelse(t_gridlock$p.value < 0.001, "<0.001***", sprintf("%.3f", t_gridlock$p.value)),
    ifelse(t_impeach$p.value < 0.01, "<0.01**", sprintf("%.3f", t_impeach$p.value)),
    ifelse(prop_deadlock$p.value < 0.001, "<0.001***", sprintf("%.3f", prop_deadlock$p.value))
  )
)

print(table2)

# ==============================================================================
# Save results
# ==============================================================================

write_csv(table2, "output/tables/table2_legislative_outcomes.csv")

# LaTeX version
if (requireNamespace("kableExtra", quietly = TRUE)) {
  table2_latex <- kableExtra::kbl(
    table2,
    format = "latex",
    booktabs = TRUE,
    caption = "Legislative Outcomes (2015-2023)"
  ) %>%
    kableExtra::kable_styling(latex_options = c("hold_position"))
  
  writeLines(table2_latex, "output/tables/table2_legislative_outcomes.tex")
}

cat("\nTable 2 saved to output/tables/\n")

# ==============================================================================
# Effect sizes
# ==============================================================================

cat("\n=== Effect Sizes ===\n")
cat("Bills passed - Cohen's d:", calc_cohens_d(chl$bills_passed, arg$bills_passed), "\n")
cat("Bipartisan % - Cohen's d:", calc_cohens_d(chl$bipartisan_pct, arg$bipartisan_pct), "\n")
cat("Gridlock - Cohen's d:", calc_cohens_d(arg$gridlock_index, chl$gridlock_index), "\n")
