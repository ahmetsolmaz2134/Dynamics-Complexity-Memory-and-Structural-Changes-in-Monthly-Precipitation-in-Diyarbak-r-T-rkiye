# Dynamics, Complexity, Memory, and Structural Changes in Monthly Precipitation in Diyarbakır, Türkiye

## Overview

This repository presents an integrated statistical analysis of the temporal dynamics, complexity, memory, concentration, and structural changes of monthly precipitation in **Diyarbakır, Türkiye**.

The study goes beyond conventional precipitation trend analysis by examining precipitation as a complex temporal system characterized by seasonality, persistence, nonlinear variability, multiple temporal scales, and structural changes.

The analytical framework combines descriptive statistics, precipitation concentration analysis, entropy-based complexity measures, Hurst exponent analysis, wavelet analysis, Bayesian change-point detection, precipitation regime analysis, and quantile-based assessment.

---

## Research Objectives

The study aims to:

- characterize the seasonal structure of monthly precipitation;
- quantify temporal variability and precipitation concentration;
- investigate the complexity and regularity of precipitation dynamics;
- assess long-term memory and persistence;
- identify dominant temporal scales of precipitation variability;
- detect potential structural and regime changes;
- investigate distributional changes across precipitation quantiles;
- provide an integrated interpretation of precipitation dynamics.

---

# Key Results

The analysis indicates that monthly precipitation in Diyarbakır exhibits a **strongly seasonal, heterogeneous, persistent, and structurally variable temporal behavior**.

### Main findings

- Precipitation is strongly concentrated within particular periods of the annual cycle, demonstrating pronounced seasonality.
- Monthly precipitation exhibits substantial temporal variability rather than a uniform distribution through time.
- Entropy-based indicators demonstrate that precipitation dynamics contain varying degrees of complexity and temporal irregularity.
- Hurst-based analysis provides evidence regarding persistence and long-term memory within the precipitation series.
- Wavelet analysis reveals variability occurring across multiple temporal scales.
- Bayesian change-point analysis identifies periods in which the statistical structure of precipitation changes.
- Regime analysis suggests that precipitation can be characterized by distinct temporal states rather than a single homogeneous regime.
- Quantile-based analysis indicates that precipitation changes may differ across the distribution and therefore cannot be fully represented by changes in the mean alone.

### Overall interpretation

The results suggest that precipitation in Diyarbakır should be interpreted as a **complex and non-stationary hydroclimatic system**.

The observed characteristics indicate that precipitation change involves more than a simple increase or decrease in rainfall. Changes in seasonality, concentration, complexity, persistence, temporal scale, and structural regimes may occur simultaneously.

---

# Key Figures

## 1. Monthly Precipitation Dynamics

![Monthly precipitation dynamics](monthly_precipitation_dynamics.png)

The temporal distribution of monthly precipitation illustrates the pronounced seasonal structure and interannual variability of rainfall.

---

## 2. Annual Precipitation Variability

![Annual precipitation variability](annual_precipitation_variability.png)

Annual precipitation variability provides an overview of changes in total precipitation and highlights periods of relatively wet and dry conditions.

---

## 3. Monthly Precipitation Heatmap

![Monthly precipitation heatmap](monthly_precipitation_heatmap.png)

The heatmap provides a compact representation of the seasonal and interannual organization of precipitation.

---

## 4. Precipitation Concentration

![Precipitation concentration](precipitation_concentration.png)

The concentration analysis evaluates how precipitation is distributed throughout the annual cycle and identifies periods contributing disproportionately to total rainfall.

---

## 5. Entropy-Based Complexity

![Entropy analysis](entropy_analysis.png)

Entropy-based measures are used to characterize uncertainty, regularity, and complexity within the precipitation time series.

---
# Hurst Exponent and Long-Term Memory

![Hurst exponent analysis](hurst_exponent.png)

The Hurst exponent is used to investigate persistence and long-range dependence in precipitation variability.

Values indicating persistent behavior suggest that temporal conditions may influence subsequent observations, while lower persistence indicates a more irregular temporal structure.

---

# Wavelet Analysis

![Wavelet analysis](wavelet_analysis.png)

Wavelet analysis investigates precipitation variability across different temporal scales.

This approach makes it possible to identify periods in which short-, intermediate-, or longer-term fluctuations become particularly important.

The analysis therefore complements conventional time-domain statistics by examining the frequency characteristics of precipitation variability.

---

# Bayesian Change-Point Detection

![Bayesian change point analysis](bayesian_change_points.png)

Bayesian change-point analysis is applied to identify potential structural changes in the precipitation series.

Detected change points may indicate transitions between periods characterized by different statistical properties.

These results provide an important basis for evaluating precipitation non-stationarity.

---

# Precipitation Regimes

![Precipitation regimes](precipitation_regimes.png)

Regime analysis is used to distinguish periods with different precipitation characteristics.

The identification of distinct regimes provides an additional perspective on temporal heterogeneity and helps determine whether precipitation behavior can be represented by a single statistical state.

---

# Quantile-Based Analysis

![Quantile regression](quantile_regression.png)

Quantile-based analysis examines precipitation behavior across different portions of the distribution.

This approach is particularly useful because changes in average precipitation may not adequately describe changes occurring at low or high precipitation levels.

---

# Integrated Analytical Framework

The complete analytical workflow can be summarized as follows:

```text
                 MONTHLY PRECIPITATION DATA
                            │
                            ▼
                Data Preparation & QC
                            │
                            ▼
              Seasonal & Temporal Analysis
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
      Concentration      Entropy         Variability
             │              │              │
             └──────────────┼──────────────┘
                            ▼
                   Complexity Analysis
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
          Hurst          Wavelet       Change Points
             │              │              │
             └──────────────┼──────────────┘
                            ▼
                    Regime Analysis
                            │
                            ▼
                  Quantile Analysis
                            │
                            ▼
              INTEGRATED INTERPRETATION
                            │
                            ▼
          PRECIPITATION DYNAMICS & STRUCTURE
# Scientific Interpretation

The integrated analysis indicates that precipitation in Diyarbakır is not adequately described by a simple increasing or decreasing trend.

Instead, the precipitation system exhibits multiple interacting characteristics, including:

- pronounced seasonality;
- considerable interannual variability;
- temporal concentration;
- changing complexity;
- persistence and long-term memory;
- variability across multiple temporal scales;
- potential structural breaks;
- distinct precipitation regimes;
- and distributional differences across quantiles.

These characteristics indicate that precipitation should be considered a **dynamic and non-stationary hydroclimatic system**.

The combined evidence from entropy, Hurst exponent, wavelet, change-point, regime, and quantile analyses provides a more comprehensive interpretation than conventional mean-based precipitation statistics alone.

---

# Main Findings at a Glance

| Component | Main Interpretation |
|---|---|
| Seasonality | Precipitation shows a pronounced seasonal structure |
| Temporal variability | Considerable interannual and monthly fluctuations are present |
| Concentration | Rainfall is unevenly distributed throughout the annual cycle |
| Entropy | Precipitation exhibits measurable complexity and irregularity |
| Hurst exponent | Temporal persistence and memory characteristics are detectable |
| Wavelet analysis | Variability occurs across multiple temporal scales |
| Change-point analysis | Potential structural transitions are identified |
| Regime analysis | Distinct precipitation states can be distinguished |
| Quantile analysis | Changes may differ across the precipitation distribution |

---

# Methodological Workflow

The complete workflow follows a sequential analytical structure:

```text
Monthly Precipitation
        │
        ▼
Data Preparation
        │
        ▼
Quality Control
        │
        ▼
Seasonal Analysis
        │
        ▼
Temporal Variability
        │
        ├───────────────┐
        ▼               ▼
Concentration       Entropy
                        │
                        ▼
                   Complexity
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
      Hurst          Wavelet       Change Point
        │               │               │
        └───────────────┼───────────────┘
                        ▼
                 Regime Analysis
                        │
                        ▼
                Quantile Analysis
                        │
                        ▼
              Integrated Assessment
