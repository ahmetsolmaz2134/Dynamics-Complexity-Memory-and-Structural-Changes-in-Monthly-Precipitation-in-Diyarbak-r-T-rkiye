# ==============================================================================
# QUANTILE REGRESSION ANALYSIS (HATA D??ZELT??LM???? & TAM KOD)
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("quantreg")) install.packages("quantreg")
if (!require("gridExtra")) install.packages("gridExtra")

library(readxl)
library(dplyr)
library(ggplot2)
library(quantreg)
library(gridExtra)

# 1. VER?? Y??KLEME VE HAZIRLIK
graphics.off() # ??nceki grafik ayarlar??n?? temizle

file_path <- file.choose()
df_raw <- read_excel(file_path, col_names = FALSE)
colnames(df_raw)[1:3] <- c("Year", "Month", "Precipitation")

df_clean <- df_raw %>%
  filter(Month != 13) %>%
  mutate(
    Year = as.numeric(Year),
    Month = as.numeric(Month),
    Precipitation = as.numeric(Precipitation),
    Date = as.Date(paste(Year, Month, "01", sep = "-"))
  ) %>%
  filter(!is.na(Precipitation)) %>%
  arrange(Date)

# Y??ll??k Toplam Ya?????? Serisi
df_annual <- df_clean %>%
  group_by(Year) %>%
  summarise(Total_Precip = sum(Precipitation), .groups = "drop")

# 2. TEK??L KUANT??L MODELLEMES?? VE BOOTSTRAP G??VEN ARALIKLARI
taus <- c(0.10, 0.25, 0.50, 0.75, 0.90)
qr_results <- data.frame()

# OLS Klasik Ortalama Trend
ols_fit <- lm(Total_Precip ~ Year, data = df_annual)
ols_slope <- coef(ols_fit)["Year"]
ols_se <- summary(ols_fit)$coefficients["Year", "Std. Error"]
ols_ci <- c(ols_slope - 1.96 * ols_se, ols_slope + 1.96 * ols_se)

# Her bir kuantil i??in ayr?? model fit etme
set.seed(42) # Bootstrap tekrarlanabilirli??i
for (tau_val in taus) {
  fit_single <- suppressWarnings(
    rq(Total_Precip ~ Year, tau = tau_val, data = df_annual)
  )
  
  sum_single <- summary(fit_single, se = "boot", R = 1000)
  coef_matrix <- sum_single$coefficients
  
  slope <- coef_matrix["Year", "Value"]
  se    <- coef_matrix["Year", "Std. Error"]
  p_val <- coef_matrix["Year", "Pr(>|t|)"]
  
  qr_results <- rbind(qr_results, data.frame(
    Tau = tau_val,
    Slope = slope,
    Lower_CI = slope - 1.96 * se,
    Upper_CI = slope + 1.96 * se,
    P_Value = p_val
  ))
}

cat("\n================ QUANTILE REGRESSION SUMMARY (mm/year) ================\n")
cat(sprintf("OLS Mean Trend Slope : %.3f mm/year (95%% CI: %.3f, %.3f)\n", ols_slope, ols_ci[1], ols_ci[2]))
print(qr_results)
cat("========================================================================\n")

# 3. AKADEM??K G??RSELLE??T??RME

# Panel A: Zaman Serisi ??zerinde Kuantil Trend ??izgileri
p1 <- ggplot(df_annual, aes(x = Year, y = Total_Precip)) +
  geom_line(color = "#7F8C8D", linewidth = 0.6, alpha = 0.5) +
  geom_point(color = "#2C3E50", size = 1.8, alpha = 0.8) +
  geom_quantile(quantiles = taus, aes(color = as.factor(after_stat(quantile))), linewidth = 1.0) +
  geom_smooth(method = "lm", se = FALSE, color = "#000000", linetype = "dashed", linewidth = 0.8) +
  scale_color_manual(
    name = "Quantiles (tau)",
    values = c("0.1" = "#C0392B", "0.25" = "#E67E22", "0.5" = "#F1C40F", "0.75" = "#27AE60", "0.9" = "#2980B9"),
    labels = c("Q10 (Extreme Dry)", "Q25 (Dry)", "Q50 (Median)", "Q75 (Wet)", "Q90 (Extreme Wet)")
  ) +
  labs(
    title = "Quantile Regression Analysis: Annual Precipitation Distribution Dynamics",
    subtitle = "Comparing Quantile Trends against OLS Mean Trend (Black Dashed Line)",
    x = NULL,
    y = "Precipitation (mm)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 9.5),
    legend.position = "right",
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6)
  )

# Panel B: Kuantil E??im Katsay??lar?? ve OLS Kar????la??t??rmas?? (Hata D??zeltildi)
p2 <- ggplot(qr_results, aes(x = Tau, y = Slope)) +
  # OLS 95% G??ven Aral?????? Band?? (Annotate ile D??zeltildi)
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = ols_ci[1], ymax = ols_ci[2], fill = "#BDC3C7", alpha = 0.4) +
  geom_hline(yintercept = ols_slope, color = "#000000", linetype = "dashed", linewidth = 0.9) +
  
  # Kuantil E??im G??ven Aral?????? ve ??izgisi
  geom_ribbon(aes(ymin = Lower_CI, ymax = Upper_CI), fill = "#2980B9", alpha = 0.25) +
  geom_line(color = "#2980B9", linewidth = 1.1) +
  geom_point(color = "#1A5276", size = 3) +
  geom_hline(yintercept = 0, color = "#C0392B", linetype = "dotted", linewidth = 0.7) +
  
  scale_x_continuous(breaks = taus, labels = c("Q10", "Q25", "Q50", "Q75", "Q90")) +
  labs(
    subtitle = "Quantile Slope Coefficients (mm/year) with 95% Confidence Intervals vs. OLS Mean Trend",
    x = "Quantile Spectrum (tau)",
    y = "Trend Slope (mm/year)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 9.5),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6)
  )

# 4. GRAF??KLER?? B??RLE??T??R VE KAYDET
fig_quantreg <- grid.arrange(p1, p2, ncol = 1, heights = c(2, 1.2))

ggsave("Figure_Quantile_Regression_Trends.png", plot = fig_quantreg, width = 10, height = 7.5, dpi = 300)

cat("\nKuantil Regresyonu analizi sorunsuz tamamland??. 'Figure_Quantile_Regression_Trends.png' dosyas?? kaydedildi.\n")