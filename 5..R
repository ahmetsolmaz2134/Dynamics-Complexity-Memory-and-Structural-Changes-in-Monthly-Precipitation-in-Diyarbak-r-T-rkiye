# ==============================================================================
# PERMUTATION ENTROPY (NPE) - D??ZELT??LM???? VE ??Y??LE??T??R??LM???? G??RSELLE??T??RME
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("zoo")) install.packages("zoo")

library(readxl)
library(dplyr)
library(ggplot2)
library(zoo)

# 1. SAF R NORMALIZE PERMUTATION ENTROPY FONKS??YONU
calc_permen <- function(x, m = 3, tau = 1) {
  x <- x[!is.na(x)]
  N <- length(x)
  max_idx <- N - (m - 1) * tau
  
  if (max_idx < 1) return(NA)
  
  patterns <- vector("character", max_idx)
  for (i in 1:max_idx) {
    vec <- x[seq(i, i + (m - 1) * tau, by = tau)]
    patterns[i] <- paste(order(vec), collapse = "-")
  }
  
  counts <- table(patterns)
  probs <- counts / sum(counts)
  pe <- -sum(probs * log(probs))
  max_pe <- log(factorial(m))
  return(pe / max_pe)
}

# 2. VER?? Y??KLEME VE ????LEME
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

# 3. HAREKETL?? PENCERE HESAPLAMASI (120 AY)
overall_npe <- calc_permen(df_clean$Precipitation, m = 3, tau = 1)

df_clean$Rolling_NPE <- rollapply(
  df_clean$Precipitation,
  width = 120,
  FUN = function(w) calc_permen(w, m = 3, tau = 1),
  fill = NA,
  align = "right"
)

df_plot <- df_clean %>% filter(!is.na(Rolling_NPE))
mean_rolling_npe <- mean(df_plot$Rolling_NPE)

# 4. YAYIN KAL??TES??NDE D??ZELT??LM???? GRAF??K
fig_permen <- ggplot(df_plot, aes(x = Date, y = Rolling_NPE)) +
  # Trend G??lgesi ve ??izgisi
  geom_smooth(method = "loess", span = 0.3, color = "#E67E22", fill = "#F2D7D5", alpha = 0.4, linewidth = 0.8) +
  geom_line(color = "#6C3483", linewidth = 0.85) +
  
  # Referans ??izgileri
  geom_hline(yintercept = overall_npe, color = "#C0392B", linetype = "dashed", linewidth = 0.8) +
  geom_hline(yintercept = mean_rolling_npe, color = "#1E8449", linetype = "dotted", linewidth = 0.8) +
  
  # Dinamik Konumland??r??lm???? Metin Etiketi (Hata Vermez)
  annotate(
    "text", 
    x = min(df_plot$Date), 
    y = overall_npe, 
    label = paste0(" Genel NPE: ", round(overall_npe, 3)), 
    color = "#C0392B", 
    fontface = "bold", 
    size = 3.8, 
    hjust = 0, 
    vjust = -0.6
  ) +
  
  # Tarih Eksen Bi??imlendirmesi
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  
  # Ba??l??klar ve Eksenler
  labs(
    title = "120-Month Rolling Normalized Permutation Entropy (NPE)",
    subtitle = "Temporal Ordering Complexity & Ordinal Pattern Dynamics (m = 3, tau = 1)",
    x = "Timeline",
    y = "Normalized Permutation Entropy (NPE)"
  ) +
  
  # Tema Tasar??m??
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 10),
    axis.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.7)
  )

# ??izdir ve Y??ksek ????z??n??rl??kte Kaydet
print(fig_permen)
ggsave("Figure_Permutation_Entropy_Rolling.png", plot = fig_permen, width = 10, height = 5.5, dpi = 300)