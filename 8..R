# ==============================================================================
# BAYESIAN CHANGE-POINT ANALYSIS (BCP)
# Hydroclimatic Regime Shift & Structural Break Detection
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("gridExtra")) install.packages("gridExtra")
if (!require("bcp")) install.packages("bcp")

library(readxl)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(bcp)

# 1. VER?? Y??KLEME VE ????LEME
graphics.off() # Grafik ekran??n?? temizle

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

# 2. YILLIK VE AYLIK SER?? HAZIRLI??I
# Bayesyen de??i??im analizi hem ayl??k hem de y??ll??k toplam ya??????lar ??zerinde ko??ulabilir
df_annual <- df_clean %>%
  group_by(Year) %>%
  summarise(
    Total_Precip = sum(Precipitation),
    Mean_Precip  = mean(Precipitation),
    .groups = "drop"
  )

# 3. BAYESIAN CHANGE-POINT (BCP) MODELLEMES?? (YILLIK TOPLAM YA??I??)
set.seed(42) # MCMC tekrarlanabilirli??i i??in
bcp_fit <- bcp(y = df_annual$Total_Precip, burnin = 1000, mcmc = 10000)

# Sonu??lar?? DataFrame'e aktarma
df_annual$Posterior_Prob <- bcp_fit$posterior.prob
df_annual$Posterior_Mean <- bcp_fit$posterior.mean[, 1]
df_annual$Posterior_SD   <- bcp_fit$posterior.var[, 1]^0.5

# %95 Credible Intervals (Sonsal G??ven Aral??????)
df_annual$CI_Lower <- df_annual$Posterior_Mean - 1.96 * df_annual$Posterior_SD
df_annual$CI_Upper <- df_annual$Posterior_Mean + 1.96 * df_annual$Posterior_SD

# 4. ??STAT??ST??KSEL ??ZET VE Y??KSEK OLASILIKLI KIRILMA NOKTALARI
significant_breaks <- df_annual %>% 
  filter(Posterior_Prob >= 0.50) %>%
  arrange(desc(Posterior_Prob))

cat("\n================ BAYESIAN CHANGE-POINT SUMMARY ================\n")
if(nrow(significant_breaks) > 0) {
  cat("Posterior De??i??im Olas??l?????? P >= 0.50 Olan Y??llar:\n")
  print(significant_breaks[, c("Year", "Posterior_Prob", "Posterior_Mean")])
} else {
  cat("P >= 0.50 e??i??ini a??an tekil bir y??ll??k k??r??lma tespit edilmedi.\n")
}
cat("=================================================================\n")

# 5. AKADEM??K G??RSELLE??T??RME (????ne Grafi??i + Rejim Kaymas??)

# Panel A: Orijinal Ya?????? ve Bayesyen Rejim Ortalamalar??
p1 <- ggplot(df_annual, aes(x = Year)) +
  geom_line(aes(y = Total_Precip), color = "#95A5A6", linewidth = 0.6, alpha = 0.7) +
  geom_point(aes(y = Total_Precip), color = "#7F8C8D", size = 1.5, alpha = 0.8) +
  geom_ribbon(aes(ymin = CI_Lower, ymax = CI_Upper), fill = "#2980B9", alpha = 0.2) +
  geom_line(aes(y = Posterior_Mean), color = "#2980B9", linewidth = 1.2) +
  labs(
    title = "Bayesian Change-Point Analysis: Annual Precipitation Regimes",
    subtitle = "Observed Precipitation, Posterior Mean Regimes, and 95% Credible Intervals",
    x = NULL,
    y = "Precipitation (mm)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 9.5),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6)
  )

# Panel B: De??i??im Noktas?? Sonsal Olas??l??klar?? (Posterior Change Probabilities)
p2 <- ggplot(df_annual, aes(x = Year, y = Posterior_Prob)) +
  geom_segment(aes(xend = Year, yend = 0), color = "#C0392B", linewidth = 0.8) +
  geom_point(color = "#C0392B", size = 2) +
  geom_hline(yintercept = 0.50, linetype = "dashed", color = "#2C3E50", linewidth = 0.7) +
  annotate("text", x = min(df_annual$Year), y = 0.53, label = "Threshold (P = 0.50)", 
           color = "#2C3E50", fontface = "italic", size = 3, hjust = 0) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  labs(
    x = "Year",
    y = "Posterior Probability P(Change)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6)
  )

# 6. PANELLER?? B??RLE??T??RME VE KAYDETME
fig_bcp <- grid.arrange(p1, p2, ncol = 1, heights = c(2, 1))

ggsave("Figure_Bayesian_Change_Point.png", plot = fig_bcp, width = 10, height = 7, dpi = 300)

cat("\nBayesyen De??i??im Noktas?? Grafi??i 'Figure_Bayesian_Change_Point.png' olarak ba??ar??yla kaydedildi.\n")