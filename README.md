# From Moral Tribes to Legal Lock-in: Replication Materials

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

This repository contains data and code for replicating the empirical analyses in:

> Lerer, I. A. (2025). "From Moral Tribes to Legal Lock-in: An Evolutionary Dissolution of the Morality-Law Debate." SSRN Working Paper.

**Important Note:** The comparative evidence presented in Section V is illustrative rather than confirmatory. These analyses explore correlations consistent with the theoretical framework but cannot establish causation. Multiple confounders remain uncontrolled.

## Repository Structure

```
├── README.md
├── LICENSE
├── data/
│   ├── legislative_outcomes_arg_chl_2015_2023.csv
│   ├── judicial_discourse_sample.csv
│   ├── institutional_temperature_index.csv
│   ├── chile_constitutional_polls.csv
│   └── codebook.md
├── R/
│   ├── 00_setup.R
│   ├── 01_legislative_analysis.R
│   ├── 02_judicial_discourse_analysis.R
│   ├── 03_chile_case_study.R
│   └── 04_generate_tables.R
├── output/
│   ├── tables/
│   └── figures/
└── docs/
    ├── codebook.md
    └── methodology_notes.md
```

## Data Sources

| Dataset | Source | Years | N |
|---------|--------|-------|---|
| Legislative outcomes (Argentina) | Honorable Congreso de la Nación | 2015-2023 | 9 sessions |
| Legislative outcomes (Chile) | Biblioteca del Congreso Nacional | 2015-2023 | 9 sessions |
| Judicial discourse (Argentina) | CSJN - Corte Suprema de Justicia | 2015-2023 | 347 opinions |
| Judicial discourse (Chile) | Tribunal Constitucional | 2015-2023 | 412 opinions |
| Chile constitutional polls | CEP, Cadem, Criteria | 2021-2023 | 24 surveys |

## Requirements

```r
# R version 4.2.0 or higher
install.packages(c(
  "tidyverse",
  "effectsize",
  "kableExtra",
  "ggplot2",
  "scales",
  "broom"
))
```

## Replication Instructions

1. Clone the repository:
```bash
git clone https://github.com/alerer/moral-tribes-legal-lockin.git
cd moral-tribes-legal-lockin
```

2. Run setup script:
```r
source("R/00_setup.R")
```

3. Run analyses in order:
```r
source("R/01_legislative_analysis.R")      # Table 2
source("R/02_judicial_discourse_analysis.R") # Table 3
source("R/03_chile_case_study.R")           # Section 5.4
source("R/04_generate_tables.R")            # All tables
```

## Key Results

### Table 2: Legislative Outcomes (2015-2023)

| Metric | Argentina | Chile | Diff | p-value |
|--------|-----------|-------|------|---------|
| Bills passed per year (mean) | 12.3 | 87.4 | −75.1 | <0.001*** |
| Bills with cross-party support (%) | 18.2 | 64.7 | −46.5 pp | <0.001*** |
| Gridlock Index (Binder 1999) | 0.78 | 0.34 | +0.44 | <0.001*** |

### Table 3: Judicial Moral Language

| Metric | Argentina | Chile | Cohen's d | p-value |
|--------|-----------|-------|-----------|---------|
| Sacralization Index (median) | 8.4 | 3.2 | 0.67 | <0.001*** |
| Empirical citations (mean) | 1.2 | 4.7 | −0.62 | <0.001*** |

## Limitations

1. **Illustrative, not confirmatory**: The Argentina-Chile comparison cannot establish causation.
2. **Uncontrolled confounders**: Political history, economic conditions, party structure differences.
3. **Text analysis limitations**: Dictionaries adapted from English; only 2 coders for validation.
4. **Sample sizes**: Judicial corpus is a sample, not census.
5. **Interpretation caveat**: p-values should be interpreted cautiously given exploratory nature.

## Citation

```bibtex
@article{lerer2025moral,
  title={From Moral Tribes to Legal Lock-in: An Evolutionary Dissolution of the Morality-Law Debate},
  author={Lerer, Ignacio Adrian},
  journal={SSRN Working Paper},
  year={2025},
  doi={10.2139/ssrn.XXXXXXX}
}
```

## Contact

- **Author**: Ignacio Adrian Lerer
- **Email**: adrian@lerer.com.ar
- **ORCID**: [0009-0007-6378-9749](https://orcid.org/0009-0007-6378-9749)

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

---

*Last updated: February 2025*
