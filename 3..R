# ==============================================================================
# SHANNON ENTROPY AND PIELOU EVENNESS ANALYSIS (SAB??T HEX RENKL?? KOD)
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")

library(readxl)
library(dplyr)
library(ggplot2)

# 1. VER?? Y??KLEME VE TEM??ZLEME
cat("L??tfen a????lan pencereden Yagis.xlsx dosyas??n?? se??in...\n")
file_path <- file.choose()
df_raw <- read_excel(file_path, col_names = FALSE)
colnames(df_raw)[1:3] <- c("Year", "Month", "Precipitation")

df_clean <- df_raw %>%
  filter(Month != 13) %>%
  mutate(
    Year = as.numeric(Year),
    Month = as.numeric(Month),
    Precipitation = as.numeric(Precipitation)
  )

# 2. SHANNON ENTROP??S?? VE E????TL??K HESAPLAMA
H_max <- log(12) # Teorik Maksimum Entropi (~2.4849)

shannon_analysis <- df_clean %>%
  group_by(Year) %>%
  summarise(
    Annual_Precip = sum(Precipitation, na.rm = TRUE),
    
    # Shannon Entropisi: H = -sum(p_i * log(p_i))
    Shannon_H = -sum((Precipitation/sum(Precipitation, na.rm=TRUE)) * 
                       log(ifelse(Precipitation==0, 1, Precipitation/sum(Precipitation, na.rm=TRUE))), na.rm=TRUE),
    
    # Pielou E??itlik ??ndeksi: E = H / H_max
    Evenness_E = Shannon_H / H_max,
    .groups = "drop"
  ) %>%
  mutate(H_Anomaly = Shannon_H - mean(Shannon_H, na.rm = TRUE))

# 3. GRAF??KLER (HEX RENK KODLARI ??LE)

# Figure 1: Shannon Entropy (H) Zaman Serisi
p1 <- ggplot(shannon_analysis, aes(x = Year, y = Shannon_H)) +
  geom_line(color = "#000080", linewidth = 0.8) +
  geom_point(color = "#000080", size = 1.8) +
  geom_hline(yintercept = H_max, color = "#CC0000", linetype = "dashed", linewidth = 0.8) +
  geom_hline(yintercept = mean(shannon_analysis$Shannon_H), color = "#008000", linetype = "dotted", linewidth = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "#FF8C00", linewidth = 0.8) +
  annotate("text", x = min(shannon_analysis$Year) + 5, y = H_max - 0.05, 
           label = paste0("Theoretical Max H = ", round(H_max, 3)), color = "#CC0000", size = 3.5) +
  labs(title = "Shannon Entropy (H) Time Series & Trend", x = "", y = "Shannon Entropy (H)") +
  theme_bw(base_size = 11)

# Figure 2: Pielou's Evenness Index (E)
p2 <- ggplot(shannon_analysis, aes(x = Year, y = Evenness_E)) +
  geom_line(color = "#008080", linewidth = 0.8) +
  geom_point(color = "#008080", size = 1.8) +
  geom_hline(yintercept = mean(shannon_analysis$Evenness_E), color = "#008000", linetype = "dotted", linewidth = 0.8) +
  labs(title = "Pielou's Evenness Index (E = H / H_max)", x = "Year", y = "Evenness Index (E)") +
  ylim(0.5, 1.0) +
  theme_bw(base_size = 11)

# Figure 3: Shannon Entropy Anomaly
p3 <- ggplot(shannon_analysis, aes(x = Year, y = H_Anomaly, fill = H_Anomaly > 0)) +
  geom_bar(stat = "identity", width = 0.8) +
  scale_fill_manual(values = c("TRUE" = "#228B22", "FALSE" = "#B22222")) +
  geom_hline(yintercept = 0, color = "#000000", linewidth = 0.5) +
  labs(title = "Shannon Entropy Anomaly (H - Mean H)", x = "Year", y = "Entropy Anomaly") +
  theme_bw(base_size = 11) +
  theme(legend.position = "none")

# Grafikleri ??izdir
print(p1)
print(p2)
print(p3)