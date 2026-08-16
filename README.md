# Dynamics, Complexity, Memory, and Structural Changes in Monthly Precipitation in Diyarbakır, Türkiye

## Abstract

This project investigates the temporal dynamics of monthly precipitation in Diyarbakır, southeastern Türkiye, using an integrated statistical, information-theoretical, nonlinear, and time-frequency analytical framework.

Conventional precipitation studies generally focus on linear trends, mean changes, or conventional homogeneity and trend tests. However, precipitation is a complex hydroclimatic variable characterized by seasonality, temporal dependence, nonlinear variability, intermittency, and changes occurring at multiple temporal scales.

Therefore, this study moves beyond a conventional trend-oriented framework and examines whether the statistical structure of precipitation has changed over time. Particular attention is given to precipitation concentration, temporal complexity, long-range dependence, frequency-scale variability, structural breakpoints, precipitation regimes, and changes across different parts of the precipitation distribution.

The analysis is conducted using a continuous monthly precipitation time series for Diyarbakır. The methodological framework integrates precipitation climatology, precipitation concentration analysis, Shannon entropy, Sample Entropy, Permutation Entropy, Hurst exponent analysis, Continuous Wavelet Transform, Bayesian change-point detection, regime analysis, and quantile regression.

The primary objective is not simply to determine whether precipitation has increased or decreased, but to investigate whether the **behavioral structure of the precipitation system has changed through time**.

---

## 1. Research Motivation

Precipitation variability represents one of the most important components of regional hydroclimatic systems. Changes in precipitation do not necessarily occur only through changes in the long-term mean. The temporal distribution, concentration, persistence, complexity, periodicity, and statistical structure of precipitation may also change.

A conventional trend analysis may therefore provide an incomplete representation of hydroclimatic change.

For example, two periods may have similar annual precipitation totals while exhibiting substantially different temporal structures:

- precipitation may become concentrated in fewer months;
- low-precipitation months may become more frequent;
- high-precipitation events may become more variable;
- temporal dependence may strengthen or weaken;
- dominant periodicities may change;
- the complexity of the precipitation sequence may increase or decrease;
- and the statistical regime of the precipitation series may shift.

This project addresses these dimensions through a multidimensional analysis of the Diyarbakır monthly precipitation series.

---

# 2. Main Research Question

> **Has the monthly precipitation system of Diyarbakır changed only in magnitude, or have its distribution, complexity, memory, frequency structure, and statistical regimes also changed over time?**

---

# 3. Specific Research Questions

### RQ1
How does monthly precipitation vary seasonally and interannually in Diyarbakır?

### RQ2
Has the intra-annual concentration and distribution of precipitation changed over time?

### RQ3
Has the temporal complexity of the precipitation series changed?

### RQ4
Does the precipitation series exhibit long-range dependence or persistence?

### RQ5
Which temporal scales dominate the variability of monthly precipitation?

### RQ6
Are there statistically identifiable structural change points within the precipitation series?

### RQ7
Do different precipitation regimes exhibit different statistical and dynamical characteristics?

### RQ8
Are changes concentrated around the center of the precipitation distribution, or are the lower and upper quantiles changing differently?

---

# 4. Study Area

The study focuses on **Diyarbakır, southeastern Türkiye**.

Diyarbakır is characterized by a pronounced seasonal precipitation regime and substantial interannual variability. Its geographical position within southeastern Türkiye makes the region particularly relevant for investigating changes in precipitation seasonality, concentration, persistence, and temporal structure.

The study uses monthly total precipitation rather than relying exclusively on annual precipitation totals. This allows the temporal organization of precipitation within individual years to be investigated.

---

# 5. Data

The core dataset consists of:

- **Variable:** Monthly total precipitation
- **Unit:** mm
- **Spatial coverage:** Diyarbakır
- **Temporal resolution:** Monthly
- **Data structure:** Continuous time series

The dataset will undergo quality-control procedures before statistical analysis.

### Data Quality Control

The preprocessing stage includes:

1. Chronological ordering of observations
2. Missing-value identification
3. Duplicate observation detection
4. Physically implausible value checks
5. Zero-precipitation assessment
6. Temporal continuity assessment
7. Descriptive statistical evaluation

No analytical method will be applied before the temporal integrity of the dataset is evaluated.

---

# 6. Analytical Framework

The project follows a sequential analytical framework:

```text
Monthly Precipitation
        │
        ▼
Data Quality Control
        │
        ▼
Descriptive Climatology
        │
        ▼
Seasonality & Precipitation Concentration
        │
        ▼
Shannon Entropy
        │
        ▼
Sample Entropy
        │
        ▼
Permutation Entropy
        │
        ▼
Hurst Exponent
        │
        ▼
Continuous Wavelet Transform
        │
        ▼
Bayesian Change-Point Detection
        │
        ▼
Precipitation Regime Analysis
        │
        ▼
Quantile Regression
        │
        ▼
Integrated Hydroclimatic Interpretation
