# Methodology Notes

## Overview

This document provides additional methodological details for the empirical analyses in Section V of "From Moral Tribes to Legal Lock-in."

---

## 1. Legislative Productivity Analysis

### Data Collection

Legislative data was collected from official government sources:
- **Argentina**: Honorable Congreso de la Nación (hcdn.gob.ar)
- **Chile**: Biblioteca del Congreso Nacional (bcn.cl)

### Gridlock Index

Following Binder (1999), gridlock is calculated as:

```
Gridlock = (Bills_introduced − Bills_passed) / Bills_introduced
```

This measure captures the proportion of the legislative agenda that fails to advance.

### Bipartisan Support

A bill is coded as having "bipartisan support" if:
- It received votes from legislators of at least two parties
- In Argentina: Both Peronist and opposition votes
- In Chile: Both governing coalition and opposition votes

### Statistical Tests

- **T-tests**: Welch's t-test (unequal variances assumed) for continuous variables
- **Proportion tests**: Chi-square test for binary outcomes
- **Significance levels**: * p<0.05, ** p<0.01, *** p<0.001

---

## 2. Judicial Discourse Analysis

### Corpus Construction

**Argentina (CSJN)**:
- Source: Official Court database (csjn.gov.ar)
- Selection: Random sample of opinions from labor, constitutional, and social security cases
- N = 347 opinions (sample from larger corpus)

**Chile (TC)**:
- Source: Tribunal Constitucional database (tribunalconstitucional.cl)
- Selection: Random sample of opinions from similar case categories
- N = 412 opinions (sample from larger corpus)

### Moral Foundations Dictionary

The Sacralization Index adapts the Moral Foundations Dictionary (Graham et al. 2009) for Spanish legal texts.

**Purity/Sanctity terms include**:
- sagrado/a, inviolable, inalienable, intocable, puro/a
- profanación, contaminación, degradación
- dignidad (when used as absolute)

**Authority/Hierarchy terms include**:
- supremo/a, soberano/a, jerárquico/a
- obediencia, deber, mandato
- orden (institutional)

### Sacralization Index

```
Sacralization_Index = (purity_words + authority_words) / total_words × 1000
```

The multiplier (×1000) converts to per-thousand-word rate for interpretability.

### Coding Protocol

1. Two independent coders processed all opinions
2. Disagreements (< 15% of cases) resolved by discussion
3. Inter-coder reliability: Cohen's κ = 0.78 (substantial agreement)

### Limitations

1. Dictionary adapted from English; Spanish validation pending
2. Context not considered (e.g., "sacred" in quotation vs. assertion)
3. Only 2 coders; larger validation needed
4. Sample, not census of opinions

---

## 3. Chile Constitutional Case Study

### Design

This is a **within-country comparison** exploiting variation in institutional rules:
- 2022 Convention: "Hot" rules (simple majority, no cooling mechanisms)
- 2023 Expert Process: "Cold" rules (supermajority, staged deliberation)

### Data Sources

- Polling: CEP, Cadem, Criteria (publicly available surveys)
- Results: Servicio Electoral de Chile (official)
- Institutional rules: Constitutional texts and legislative regulations

### Causal Interpretation

**IMPORTANT**: This comparison cannot establish causation.

Confounders that remain uncontrolled:
1. **Voter fatigue**: 2023 voters had experienced 2022 rejection
2. **Economic conditions**: Different macroeconomic context
3. **Political coalitions**: Different party alignments
4. **Learning effects**: 2023 drafters learned from 2022 mistakes
5. **Selection**: Different individuals in Convention vs. Expert Commission

The institutional temperature hypothesis is **one possible explanation**, not the only one.

---

## 4. Institutional Temperature Index

### Construction

The index aggregates six dimensions of institutional design that may affect memetic selection:

| Dimension | Scoring | Rationale |
|-----------|---------|-----------|
| Supermajority | 0 (50%+1) to 1 (≥60%) | Higher thresholds force cross-tribal negotiation |
| Mixed commissions | 0 (no) to 1 (mandatory) | Cross-party committees dampen echo chambers |
| Cooling periods | 0-1 scale | Delays allow emotional responses to subside |
| Expert testimony | 0-1 scale | Technocratic input shifts to empirical arguments |
| Referendum gates | 0 (no) to 1 (mandatory) | Popular vote creates accountability |
| Impeachment threshold | 0 (50%+1) to 1 (66%+) | Higher bar prevents tribal removal |

### Validation

The index is author-constructed and has not been independently validated. Alternative operationalizations may yield different results.

---

## References

Binder, S. A. (1999). The dynamics of legislative gridlock, 1947-96. *American Political Science Review*, 93(3), 519-533.

Graham, J., Haidt, J., & Nosek, B. A. (2009). Liberals and conservatives rely on different sets of moral foundations. *Journal of Personality and Social Psychology*, 96(5), 1029-1046.

---

*Last updated: February 2025*
