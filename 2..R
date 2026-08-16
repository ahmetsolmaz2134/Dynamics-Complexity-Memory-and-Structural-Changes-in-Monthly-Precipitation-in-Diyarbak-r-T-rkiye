# ==============================================================================
# HYDROCLIMATOLOGICAL ANALYSIS: PRECIPITATION CONCENTRATION & SEASONALITY
# Script Purpose: Computation of PCI, Shannon-based Entropy, and Seasonal Distribution
# Data Requirement: Monthly precipitation series (Column 1: Year, Column 2: Month, Column 3: Precip mm)
# ==============================================================================

# 1. DEPENDENCIES & ENVIRONMENT SETUP
required_packages <- c("readxl", "dplyr", "tidyr", "ggplot2")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

# Set global academic theme parameters
theme_academic <- function() {
  theme_bw(base_size = 11) +
    theme(
      panel.grid.minor = element_blank(),
      axis.title = element_text(face = "bold"),
      plot.title = element_text(face = "bold", hjust = 0.5, size = 12),
      legend.title = element_text(face = "bold"),
      legend.position = "bottom"
    )
}

# 2. CORE HYDROLOGICAL FUNCTIONS
# Precipitation Concentration Index (Oliver, 1980)
calculate_pci <- function(p) {
  p_sum <- sum(p, na.rm = TRUE)
  if (p_sum == 0) return(NA)
  return(100 * sum(p^2, na.rm = TRUE) / (p_sum^2))
}

# Shannon Entropy & Concentration Index (Shannon, 1948)
calculate_shannon_concentration <- function(p) {
  p_sum <- sum(p, na.rm = TRUE)
  if (p_sum == 0) return(NA)
  p_rel <- p / p_sum
  p_rel <- p_rel[p_rel > 0] # Filter zero values for log calculation
  H <- -sum(p_rel * log(p_rel))
  H_max <- log(12)
  E <- H / H_max
  return(1 - E)
}

# 3. DATA IMPORT & PREPROCESSING
# Select file via dialog window to prevent working directory path errors
cat("Please select the 'Yagis.xlsx' file from the pop-up window...\n")
file_path <- file.choose()

df_raw <- read_excel(file_path, col_names = FALSE)
colnames(df_raw)[1:3] <- c("Year", "Month", "Precipitation")

# Filter out non-standard 13th month entries and format data types
df_clean <- df_raw %>%
  filter(Month != 13) %>%
  mutate(
    Year = as.numeric(Year),
    Month = as.numeric(Month),
    Precipitation = as.numeric(Precipitation),
    Season = factor(
      case_when(
        Month %in% c(12, 1, 2) ~ "Winter",
        Month %in% c(3, 4, 5)  ~ "Spring",
        Month %in% c(6, 7, 8)  ~ "Summer",
        TRUE                   ~ "Autumn"
      ),
      levels = c("Winter", "Spring", "Autumn", "Summer")
    )
  )

# 4. ANNUAL CONCENTRATION METRICS COMPUTATION
annual_metrics <- df_clean %>%
  group_by(Year) %>%
  summarise(
    Annual_Total = sum(Precipitation, na.rm = TRUE),
    PCI = calculate_pci(Precipitation),
    Shannon_Concentration = calculate_shannon_concentration(Precipitation),
    .groups = "drop"
  )

# Seasonal totals and percentage shares
seasonal_shares <- df_clean %>%
  group_by(Year, Season) %>%
  summarise(Seasonal_Total = sum(Precipitation, na.rm = TRUE), .groups = "drop") %>%
  group_by(Year) %>%
  mutate(Share_Pct = (Seasonal_Total / sum(Seasonal_Total)) * 100)

# 5. PUBLICATION-READY GRAPHICS (ggplot2)

# Figure 1: PCI Time Series with Threshold Lines
fig1_pci <- ggplot(annual_metrics, aes(x = Year, y = PCI)) +
  geom_line(color = "gray30", linewidth = 0.7) +
  geom_point(color = "darkorange3", size = 1.8) +
  geom_hline(yintercept = 10, linetype = "dashed", color = "forestgreen", linewidth = 0.6) +
  geom_hline(yintercept = 15, linetype = "dashed", color = "goldenrod3", linewidth = 0.6) +
  geom_hline(yintercept = 20, linetype = "dashed", color = "firebrick3", linewidth = 0.6) +
  annotate("text", x = min(annual_metrics$Year)+2, y = 9.5, label = "Uniform (<10)", color = "forestgreen", size = 3) +
  annotate("text", x = min(annual_metrics$Year)+2, y = 14.5, label = "Moderate (11-15)", color = "goldenrod3", size = 3) +
  annotate("text", x = min(annual_metrics$Year)+2, y = 19.5, label = "High (>16-20)", color = "firebrick3", size = 3) +
  labs(
    title = "Precipitation Concentration Index (PCI) Dynamics",
    x = "Year", y = "PCI Value"
  ) +
  theme_academic()

# Figure 2: Shannon Concentration Index
fig2_shannon <- ggplot(annual_metrics, aes(x = Year, y = Shannon_Concentration)) +
  geom_line(color = "gray30", linewidth = 0.7) +
  geom_point(color = "purple4", size = 1.8) +
  geom_hline(yintercept = mean(annual_metrics$Shannon_Concentration, na.rm=TRUE), 
             linetype = "dotted", color = "black", linewidth = 0.8) +
  labs(
    title = "Shannon-Based Concentration Index (1 - E)",
    x = "Year", y = "Concentration Index (0 = Uniform, 1 = Maximum)"
  ) +
  theme_academic()

# Figure 3: Seasonal Distribution Breakdown
fig3_seasonal <- ggplot(seasonal_shares, aes(x = Year, y = Share_Pct, fill = Season)) +
  geom_bar(stat = "identity", width = 0.85) +
  scale_fill_manual(
    values = c("Winter" = "#2b5c8f", "Spring" = "#469b76", "Autumn" = "#e69f00", "Summer" = "#d55e00")
  ) +
  labs(
    title = "Annual Seasonal Precipitation Breakdown (%)",
    x = "Year", y = "Precipitation Share (%)", fill = "Season:"
  ) +
  theme_academic()

# 6. EXPORTING HIGH-RESOLUTION FIGURES (300 DPI)
ggsave("Figure_1_PCI_Timeseries.png", plot = fig1_pci, width = 8, height = 4.5, dpi = 300)
ggsave("Figure_2_Shannon_Index.png", plot = fig2_shannon, width = 8, height = 4.5, dpi = 300)
ggsave("Figure_3_Seasonal_Breakdown.png", plot = fig3_seasonal, width = 8, height = 5, dpi = 300)

# 7. CONSOLE SUMMARY OUTPUT
cat("\n=================== HYDROLOGICAL METRICS SUMMARY ===================\n")
cat(sprintf("Mean PCI Value                  : %.2f (Std Dev: %.2f)\n", mean(annual_metrics$PCI), sd(annual_metrics$PCI)))
cat(sprintf("Mean Shannon Concentration (1-E): %.3f\n", mean(annual_metrics$Shannon_Concentration)))
cat("====================================================================\n")

print(fig1_pci)
print(fig2_shannon)
print(fig3_seasonal)