# ==============================================================================
# 00_setup.R
# From Moral Tribes to Legal Lock-in: Replication Materials
# Author: Ignacio Adrian Lerer
# Date: February 2025
# ==============================================================================

# Required packages
required_packages <- c(
  "tidyverse",
  "effectsize",
  "kableExtra",
  "ggplot2",
  "scales",
  "broom",
  "here"
)

# Install missing packages
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

invisible(lapply(required_packages, install_if_missing))

# Set working directory to project root
if (requireNamespace("here", quietly = TRUE)) {
  setwd(here::here())
}

# Create output directories if they don't exist
dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

# Set global options
options(
  scipen = 999,
  digits = 3,
  dplyr.summarise.inform = FALSE
)

# Custom theme for plots
theme_paper <- function() {
  theme_minimal() +
    theme(
      text = element_text(family = "serif"),
      plot.title = element_text(size = 12, face = "bold"),
      axis.title = element_text(size = 10),
      legend.position = "bottom"
    )
}

# Function to calculate Cohen's d
calc_cohens_d <- function(x, y) {
  nx <- length(x)
  ny <- length(y)
  mx <- mean(x, na.rm = TRUE)
  my <- mean(y, na.rm = TRUE)
  sx <- sd(x, na.rm = TRUE)
  sy <- sd(y, na.rm = TRUE)
  
  pooled_sd <- sqrt(((nx - 1) * sx^2 + (ny - 1) * sy^2) / (nx + ny - 2))
  d <- (mx - my) / pooled_sd
  return(d)
}

# Function for Gridlock Index (Binder 1999)
calc_gridlock <- function(bills_introduced, bills_passed) {
  (bills_introduced - bills_passed) / bills_introduced
}

cat("Setup complete. All packages loaded.\n")
cat("Working directory:", getwd(), "\n")
