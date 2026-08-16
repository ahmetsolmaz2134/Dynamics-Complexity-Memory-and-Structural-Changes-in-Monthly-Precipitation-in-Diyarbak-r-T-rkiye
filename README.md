# Dynamics, Complexity, Memory, and Structural Changes in Monthly Precipitation in Diyarbakır, Türkiye

## 🌧️ Key Results

This project investigates whether the monthly precipitation system of Diyarbakır has changed not only in magnitude, but also in its **temporal organization, complexity, memory, frequency structure, and statistical regimes**.

The analysis integrates conventional precipitation climatology with information-theoretical, nonlinear, long-memory, time-frequency, structural-break, regime, and distributional approaches.

---

## 📊 Main Results at a Glance

### Monthly Precipitation Dynamics

![Monthly precipitation dynamics](0d23e77b-2e12-4d8c-b46a-512d300de47a.png)

### Annual and Seasonal Precipitation Variability

![Annual precipitation variability](1a0fd506-aff1-4190-9579-9c4a092b7674.png)

### Precipitation Concentration

![Precipitation concentration](2864e3f5-cda2-41a5-a0bc-7f1301695d40.png)

---

# 🧠 Complexity Analysis

## Shannon Entropy

Shannon entropy is used to characterize the temporal distribution and concentration structure of precipitation.

![Shannon entropy](3a334a42-5b24-4469-8d1a-676b024834e5.png)

The analysis examines whether precipitation has become increasingly concentrated within particular periods of the year or whether its temporal distribution has become more diversified.

---

## Sample Entropy

Sample Entropy is used to quantify the temporal complexity and regularity of the precipitation sequence.

![Sample entropy](41105c8a-e7b7-44b8-8069-7ef97fa8dd96.png)

The temporal evolution of entropy provides an additional perspective on whether the internal organization of precipitation has remained stable or changed through time.

---

## Permutation Entropy

Permutation Entropy evaluates the ordinal structure of the precipitation sequence and provides a complementary measure of dynamical complexity.

![Permutation entropy](51a68513-8ab1-4ccc-a0b8-880815f7dc99.png)

Together, Shannon Entropy, Sample Entropy, and Permutation Entropy provide complementary information on the distributional and temporal complexity of the precipitation process.

---

# 🧠 Memory and Persistence

## Hurst Exponent

The Hurst exponent is used to investigate persistence and long-range dependence within the monthly precipitation series.

![Hurst exponent](6bbea741-414e-4324-ae9b-b46b770bac69.png)

The analysis evaluates whether precipitation exhibits persistent, approximately memoryless, or anti-persistent behavior.

Importantly, the Hurst exponent is interpreted as a measure of temporal dependence rather than direct evidence of a specific physical climate mechanism.

---

# 🌊 Time-Frequency Dynamics

## Continuous Wavelet Transform

Wavelet analysis investigates precipitation variability simultaneously in the time and frequency domains.

![Wavelet analysis](6e1a8c7c-4fd7-4617-8c91-73cf47c3d7be.png)

The Wavelet Power Spectrum is used to identify dominant temporal scales and to determine whether the intensity of particular periodicities changes through time.

This allows the precipitation series to be evaluated as a **non-stationary process operating across multiple temporal scales**.

---

# 🔴 Structural Changes

## Bayesian Change-Point Analysis

Bayesian change-point detection is used to identify statistically supported changes in the structure of the precipitation time series.

![Bayesian change points](7c34239e-8be0-4f77-94bc-f2f20aa6af44.png)

Rather than assuming a predetermined breakpoint, the analysis estimates the probability and location of potential structural changes from the observed precipitation record.

---

# 🔄 Precipitation Regimes

Following the identification of structural change points, different periods of the precipitation record are evaluated as potential hydroclimatic regimes.

Each regime is compared in terms of:

- Mean precipitation
- Variability
- Coefficient of variation
- Seasonality
- Concentration
- Entropy
- Persistence
- Temporal structure

![Precipitation regimes](8f1f5a5f-5189-4d57-a2dc-f8ea0dedd900.png)

The objective is to determine whether the precipitation system exhibits different statistical and dynamical characteristics across distinct periods.

---

# 📈 Distributional Changes

## Quantile Regression

Quantile regression is used to examine whether precipitation changes are uniform across the distribution.

The analysis considers multiple conditional quantiles, including:

- 10th percentile
- 25th percentile
- 50th percentile
- 75th percentile
- 90th percentile

![Quantile regression](8f1f5a5f-5189-4d57-a2dc-f8ea0dedd900.png)

This approach allows the study to distinguish between changes affecting low, median, and high precipitation conditions.

---

# 🔬 Research Question

The central question of this project is:

> **Has the monthly precipitation system of Diyarbakır changed only in magnitude, or have its distribution, complexity, memory, frequency structure, and statistical regimes also changed over time?**

---

# 🎯 Research Objectives

The project addresses eight principal objectives:

1. Characterize the seasonal and interannual variability of monthly precipitation.
2. Quantify changes in precipitation concentration and temporal distribution.
3. Evaluate the temporal complexity of the precipitation sequence.
4. Investigate long-range dependence and persistence.
5. Identify dominant temporal scales using wavelet analysis.
6. Detect statistically supported structural changes.
7. Compare precipitation characteristics across different regimes.
8. Determine whether changes differ across the precipitation distribution.

---

# 🧪 Analytical Framework

```text
Monthly Precipitation
        │
        ▼
Data Quality Control
        │
        ▼
Climatological Analysis
        │
        ▼
Precipitation Concentration
        │
        ├───────────────┐
        ▼               ▼
Shannon Entropy     Quantile Structure
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
Wavelet Analysis
        │
        ▼
Bayesian Change Points
        │
        ▼
Precipitation Regimes
        │
        ▼
Integrated Interpretation

# 📚 Methodological Components

The methodological framework integrates conventional climatological statistics with advanced information-theoretical, nonlinear, long-memory, time-frequency, structural-change, and distributional approaches.

| Analytical Dimension | Method | Scientific Purpose |
|---|---|---|
| Precipitation magnitude | Climatological Statistics | Characterize the basic precipitation regime |
| Seasonality | Monthly and Seasonal Analysis | Identify the intra-annual precipitation structure |
| Precipitation concentration | Concentration Analysis | Quantify the temporal concentration of precipitation |
| Distributional complexity | Shannon Entropy | Evaluate precipitation distributional organization |
| Temporal complexity | Sample Entropy | Measure temporal regularity and complexity |
| Ordinal complexity | Permutation Entropy | Examine the ordering structure of precipitation |
| Memory | Hurst Exponent | Assess persistence and long-range dependence |
| Multi-scale variability | Continuous Wavelet Transform | Identify dominant temporal scales |
| Structural change | Bayesian Change-Point Detection | Detect statistically supported structural transitions |
| Regime dynamics | Regime Analysis | Compare precipitation characteristics between periods |
| Distributional change | Quantile Regression | Examine changes across different precipitation quantiles |

---

# 📊 Key Results and Visual Evidence

The following figures represent the principal analytical outputs of the project.

Rather than presenting the analysis only through numerical statistics, the project emphasizes graphical representation of precipitation dynamics, allowing temporal changes and structural characteristics to be evaluated visually.

## 1. Monthly Precipitation Climatology

The monthly climatological structure provides the baseline representation of precipitation seasonality in Diyarbakır.

![Monthly Precipitation Climatology](figures/monthly_precipitation_climatology.png)

**Interpretive focus:**

- Seasonal precipitation distribution
- Wet and dry periods
- Intra-annual precipitation variability
- Dominant precipitation months

---

## 2. Annual Precipitation Variability

Annual precipitation totals are examined to evaluate interannual variability and departures from the long-term precipitation regime.

![Annual Precipitation Variability](figures/annual_precipitation_variability.png)

**Interpretive focus:**

- Interannual variability
- Wet and dry years
- Long-term fluctuations
- Exceptional precipitation years

---

## 3. Monthly Precipitation Heatmap

The monthly precipitation heatmap provides a compact representation of the complete temporal structure of the dataset.

![Monthly Precipitation Heatmap](figures/monthly_precipitation_heatmap.png)

This visualization allows individual wet and dry periods to be identified while preserving the monthly structure of the original time series.

---

# 🧩 Precipitation Concentration

Precipitation concentration analysis investigates whether annual precipitation is distributed relatively evenly throughout the year or increasingly concentrated within particular months or seasons.

![Precipitation Concentration](figures/precipitation_concentration.png)

The main question is:

> **Has the temporal distribution of precipitation become more concentrated over time?**

This analysis is particularly important because two periods may have similar annual precipitation totals while exhibiting substantially different intra-annual distributions.

---

# 🧠 Complexity Analysis

## Shannon Entropy

Shannon Entropy is used to characterize the distributional organization of precipitation.

![Shannon Entropy](figures/shannon_entropy.png)

The analysis investigates whether precipitation distribution becomes more concentrated or more diversified through time.

---

## Sample Entropy

Sample Entropy (SampEn) is used to quantify the temporal complexity and regularity of the precipitation sequence.

![Sample Entropy](figures/sample_entropy.png)

The analysis focuses on whether the internal temporal organization of precipitation remains stable or changes through time.

Where appropriate, entropy will also be evaluated using moving-window approaches to investigate temporal changes in complexity.

---

## Permutation Entropy

Permutation Entropy evaluates the ordinal structure of the precipitation sequence.

![Permutation Entropy](figures/permutation_entropy.png)

This provides a complementary perspective on precipitation complexity by examining the ordering patterns of consecutive observations.

The combination of Shannon Entropy, Sample Entropy, and Permutation Entropy allows precipitation complexity to be examined from different methodological perspectives.

---

# 🧠 Memory and Persistence

## Hurst Exponent

The Hurst exponent is used to investigate persistence and long-range dependence within the precipitation time series.

![Hurst Exponent](figures/hurst_exponent.png)

The analysis evaluates whether the precipitation sequence demonstrates:

- Persistent behavior
- Approximately memoryless behavior
- Anti-persistent behavior

The Hurst exponent is interpreted as a statistical measure of temporal dependence and is not treated as direct evidence of a specific physical climate mechanism.

---

# 🌊 Time-Frequency Dynamics

## Continuous Wavelet Transform

Wavelet analysis is used to investigate precipitation variability simultaneously in the time and frequency domains.

![Wavelet Power Spectrum](figures/wavelet_power_spectrum.png)

The analysis identifies:

- Dominant temporal scales
- Periodic structures
- Changes in spectral power
- Non-stationary variability
- Time-dependent oscillatory behavior

The Wavelet Power Spectrum is particularly important because precipitation variability may occur at multiple temporal scales rather than at a single dominant frequency.

---

# 🔴 Structural Changes

## Bayesian Change-Point Analysis

Bayesian Change-Point Detection is used to identify potential structural transitions within the precipitation series.

![Bayesian Change Points](figures/bayesian_change_points.png)

The analysis investigates whether the statistical behavior of precipitation changes at specific points in time.

Potential structural changes may involve:

- Mean precipitation
- Variance
- Temporal dependence
- Distributional characteristics

Change points are interpreted probabilistically rather than as predetermined dates.

---

# 🔄 Precipitation Regime Analysis

Following the identification of statistically supported structural changes, the precipitation record is evaluated across different temporal regimes.

![Precipitation Regimes](figures/precipitation_regimes.png)

For each regime, the following characteristics can be compared:

- Mean precipitation
- Standard deviation
- Coefficient of variation
- Seasonality
- Precipitation concentration
- Shannon Entropy
- Sample Entropy
- Permutation Entropy
- Hurst exponent
- Dominant temporal scales

The objective is to determine whether different periods of the precipitation record exhibit distinct statistical and dynamical characteristics.

---

# 📈 Distributional Changes

## Quantile Regression

Quantile Regression is used to investigate whether precipitation changes are uniform across the distribution.

The analysis considers multiple conditional quantiles:

- Q10
- Q25
- Q50
- Q75
- Q90

![Quantile Regression](figures/quantile_regression.png)

This approach allows the study to distinguish between changes in:

- Low precipitation conditions
- Median precipitation conditions
- High precipitation conditions

The central question is:

> **Are precipitation changes occurring uniformly across the distribution, or are particular parts of the precipitation distribution changing more strongly?**

---

# 🔬 Integrated Analytical Framework

The project combines the individual analyses into a single multidimensional framework.

```text
                    MONTHLY PRECIPITATION
                            │
                            ▼
                 DATA QUALITY CONTROL
                            │
                            ▼
              CLIMATOLOGICAL CHARACTERISTICS
                            │
                            ▼
              SEASONALITY & CONCENTRATION
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
      DISTRIBUTIONAL                  TEMPORAL
       STRUCTURE                    COMPLEXITY
             │                             │
      Shannon Entropy              Sample Entropy
                                    Permutation Entropy
             │                             │
             └──────────────┬──────────────┘
                            ▼
                   MEMORY / PERSISTENCE
                            │
                     Hurst Exponent
                            │
                            ▼
                  TIME-FREQUENCY STRUCTURE
                            │
                    Wavelet Analysis
                            │
                            ▼
                   STRUCTURAL CHANGES
                            │
                 Bayesian Change Points
                            │
                            ▼
                  PRECIPITATION REGIMES
                            │
                            ▼
                   QUANTILE BEHAVIOR
                            │
                            ▼
              INTEGRATED HYDROCLIMATIC
                     INTERPRETATION
