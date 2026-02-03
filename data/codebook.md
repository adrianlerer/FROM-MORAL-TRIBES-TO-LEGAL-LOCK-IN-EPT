# Codebook: From Moral Tribes to Legal Lock-in

## Dataset Descriptions

---

## 1. legislative_outcomes_arg_chl_2015_2023.csv

Legislative productivity data for Argentina and Chile, 2015-2023.

| Variable | Type | Description |
|----------|------|-------------|
| year | integer | Calendar year (2015-2023) |
| country | string | "Argentina" or "Chile" |
| bills_introduced | integer | Total bills introduced in legislature |
| bills_passed | integer | Bills successfully enacted into law |
| bipartisan_bills | integer | Bills passed with cross-party support |
| bipartisan_pct | float | Percentage of passed bills with bipartisan support |
| gridlock_index | float | Binder (1999) gridlock measure: (introduced - passed) / introduced |
| impeachment_attempts | integer | Number of impeachment motions filed against executive |
| sessions_deadlock | binary | 1 = legislative session ended without budget approval |

**Sources:**
- Argentina: Honorable Congreso de la Nación (hcdn.gob.ar)
- Chile: Biblioteca del Congreso Nacional (bcn.cl)

---

## 2. judicial_discourse_sample.csv

Sample of Supreme/Constitutional Court opinions coded for moral language.

| Variable | Type | Description |
|----------|------|-------------|
| opinion_id | string | Unique identifier (format: COUNTRY_YEAR_###) |
| country | string | "Argentina" or "Chile" |
| year | integer | Year of opinion (2015-2023) |
| court | string | "CSJN" (Argentina) or "TC" (Chile) |
| case_type | string | Subject matter: labor, constitutional, social_security, emergency |
| total_words | integer | Total word count of opinion |
| purity_words | integer | Count of purity/sanctity terms (MFD adapted) |
| authority_words | integer | Count of authority/hierarchy terms (MFD adapted) |
| sacralization_index | float | (purity_words + authority_words) / total_words × 1000 |
| inalienable_count | integer | Occurrences of "inalienable/inalienables" |
| sacred_count | integer | Occurrences of "sacred/sagrado/sagrada" |
| empirical_citations | integer | References to empirical studies or data |
| cost_benefit_present | binary | 1 = opinion includes cost-benefit analysis |

**Coding Protocol:**
- Moral Foundations Dictionary (Graham et al. 2009) adapted for Spanish legal context
- Two independent coders; disagreements resolved by discussion
- Inter-coder reliability: κ = 0.78 (substantial agreement)

**Limitations:**
- This is a sample, not census of all opinions
- Dictionaries adapted from English; validation in Spanish pending
- Only 2 coders; larger validation needed

---

## 3. institutional_temperature_index.csv

Composite index of institutional "cooling" mechanisms.

| Variable | Type | Description |
|----------|------|-------------|
| dimension | string | Institutional feature being measured |
| argentina_score | float | Argentina score (0 = absent, 1 = fully present) |
| chile_score | float | Chile score (0 = absent, 1 = fully present) |
| cooling_effect | string | Estimated effect on memetic selection (+, ++, or +++) |
| notes | string | Description of scoring rationale |

**Dimensions:**
1. Supermajority requirement: Simple majority (0) vs supermajority (1)
2. Mixed commissions: No requirement (0) vs mandatory cross-party (1)
3. Cooling-off periods: Minimal delays (0) vs extended deliberation (1)
4. Expert testimony: Optional (0) vs mandatory for fiscal matters (1)
5. Referendum gates: No requirement (0) vs mandatory popular vote (1)
6. Impeachment threshold: Simple majority (0) vs supermajority (1)

**Total Index:** Sum of dimension scores. Range: 0 (hottest) to 6 (coldest).

---

## 4. chile_constitutional_polls.csv

Public opinion tracking for Chile's 2022-2023 constitutional processes.

| Variable | Type | Description |
|----------|------|-------------|
| date | date | Survey date (YYYY-MM-DD) |
| pollster | string | Organization: CEP, Cadem, Criteria, or "official_result" |
| process | string | "2022_convention" or "2023_expert" |
| approve_pct | float | Percentage approving proposed constitution |
| reject_pct | float | Percentage rejecting proposed constitution |
| undecided_pct | float | Percentage undecided |
| sample_size | integer | Survey sample size (NA for official results) |
| margin_error | float | Margin of error at 95% CI |

**Sources:**
- CEP: Centro de Estudios Públicos
- Cadem: Cadem Research
- Criteria: Criteria Research
- Official results: Servicio Electoral de Chile (servel.cl)

---

## Notes on Data Quality

1. **Legislative data**: Official sources; high reliability.
2. **Judicial coding**: Sample-based; inter-coder reliability reported.
3. **Temperature index**: Author-constructed; subjective elements acknowledged.
4. **Polling data**: Published surveys; official results verified.

## Citation

When using these data, please cite:

```
Lerer, I. A. (2025). From Moral Tribes to Legal Lock-in: An Evolutionary 
Dissolution of the Morality-Law Debate. SSRN Working Paper.
```

---

*Last updated: February 2025*
