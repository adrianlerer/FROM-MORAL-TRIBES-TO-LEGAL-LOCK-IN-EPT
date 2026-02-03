# ==============================================================================
# 03_chile_case_study.R
# Chile Constitutional Process 2019-2023: Hot vs Cold Institutions
# Author: Ignacio Adrian Lerer
# ==============================================================================

source("R/00_setup.R")

# Load polling data
polls <- read_csv("data/chile_constitutional_polls.csv")

# Load institutional temperature data
temp_index <- read_csv("data/institutional_temperature_index.csv")

# ==============================================================================
# 2022 Convention (Hot Rules) vs 2023 Expert Process (Cold Rules)
# ==============================================================================

polls_2022 <- polls %>% filter(process == "2022_convention")
polls_2023 <- polls %>% filter(process == "2023_expert")

# Track approval trajectory
cat("=== 2022 Convention (Hot Rules) ===\n")
cat("Starting approval:", polls_2022 %>% filter(date == min(date)) %>% pull(approve_pct), "%\n")
cat("Final result:", polls_2022 %>% filter(pollster == "official_result") %>% pull(approve_pct), "%\n")
cat("Change:", 
    polls_2022 %>% filter(pollster == "official_result") %>% pull(approve_pct) -
    polls_2022 %>% filter(date == min(date)) %>% pull(approve_pct), 
    "percentage points\n\n")

cat("=== 2023 Expert Process (Cold Rules) ===\n")
cat("Starting approval:", polls_2023 %>% filter(date == min(date)) %>% pull(approve_pct), "%\n")
cat("Final result:", polls_2023 %>% filter(pollster == "official_result") %>% pull(approve_pct), "%\n")
cat("Change:", 
    polls_2023 %>% filter(pollster == "official_result") %>% pull(approve_pct) -
    polls_2023 %>% filter(date == min(date)) %>% pull(approve_pct), 
    "percentage points\n")

# ==============================================================================
# Visualize approval trajectories
# ==============================================================================

polls_filtered <- polls %>% 
  filter(pollster != "official_result") %>%
  mutate(date = as.Date(date))

# Add final results as points
final_results <- polls %>%
  filter(pollster == "official_result") %>%
  mutate(date = as.Date(date))

p_trajectory <- ggplot(polls_filtered, aes(x = date, y = approve_pct, color = process)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  geom_point(data = final_results, aes(x = date, y = approve_pct), 
             shape = 18, size = 4) +
  geom_hline(yintercept = 50, linetype = "dashed", color = "gray50") +
  scale_color_manual(
    values = c("2022_convention" = "#E41A1C", "2023_expert" = "#377EB8"),
    labels = c("2022 Convention (Hot)", "2023 Expert (Cold)")
  ) +
  labs(
    title = "Chile Constitutional Approval: Hot vs Cold Institutional Design",
    subtitle = "2022 Convention (simple majority, no cooling) vs 2023 Expert Process (supermajority, staged)",
    x = "Date",
    y = "Approval (%)",
    color = "Process",
    caption = "Diamond markers = final referendum results. Dashed line = 50% threshold."
  ) +
  theme_paper() +
  ylim(30, 75)

print(p_trajectory)

ggsave("output/figures/chile_approval_trajectory.png", p_trajectory, 
       width = 10, height = 6, dpi = 300)

# ==============================================================================
# Institutional Temperature Comparison
# ==============================================================================

cat("\n=== Institutional Temperature Index ===\n")
print(temp_index)

# Temperature difference
temp_diff <- temp_index %>%
  filter(dimension == "total_temperature_index") %>%
  mutate(diff = chile_score - argentina_score)

cat("\nTemperature differential (Chile - Argentina):", temp_diff$diff, "\n")
cat("Chile is", temp_diff$diff, "points 'colder' than Argentina\n")

# ==============================================================================
# Summary for paper
# ==============================================================================

summary_chile <- tibble(
  Process = c("2022 Convention", "2023 Expert Process"),
  Rules = c("Hot (50%+1, no cooling)", "Cold (60%, expert draft, staged)"),
  Initial_Approval = c(67, 48),
  Final_Result = c(38.1, 55.8),
  Change = c(-28.9, +7.8),
  Outcome = c("Rejected", "Approved")
)

cat("\n=== Summary Table ===\n")
print(summary_chile)

write_csv(summary_chile, "output/tables/chile_constitutional_summary.csv")

# ==============================================================================
# Interpretation note
# ==============================================================================

cat("\n=== INTERPRETATION CAVEAT ===\n")
cat("The institutional temperature hypothesis offers ONE possible explanation.\n")
cat("Alternative explanations that cannot be ruled out:\n")
cat("  - Voter fatigue\n")
cat("  - Changed economic conditions (2022 vs 2023)\n")
cat("  - Different political coalition dynamics\n")
cat("  - Learning effects from 2022 rejection\n")
cat("Causal inference would require controlled comparison, which is impossible here.\n")
