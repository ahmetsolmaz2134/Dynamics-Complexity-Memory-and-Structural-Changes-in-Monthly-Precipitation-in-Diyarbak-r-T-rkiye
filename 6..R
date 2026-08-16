# ==============================================================================
# HURST EXPONENT ANALYSIS (R/S Analysis & DFA Sensitivity Check)
# Hydroclimatological Long-Range Dependence (Memory) Analysis
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("zoo")) install.packages("zoo")

library(readxl)
library(dplyr)
library(ggplot2)
library(zoo)

# 1. SAF R R/S ANALYSIS FONKS??YONU
calc_hurst_rs <- function(x) {
  x <- x[!is.na(x)]
  N <- length(x)
  if (N < 32) return(NA)
  
  # Pencere boyutlar?? (2'nin kuvvetleri veya logaritmik aral??k)
  min_w <- 8
  max_w <- floor(N / 2)
  sizes <- unique(floor(exp(seq(log(min_w), log(max_w), length.out = 15))))
  
  rs_list <- c()
  n_list <- c()
  
  for (n in sizes) {
    num_blocks <- floor(N / n)
    if (num_blocks < 1) next
    
    rs_blocks <- c()
    for (b in 1:num_blocks) {
      block <- x[((b - 1) * n + 1):(b * n)]
      mean_b <- mean(block)
      sd_b <- sd(block)
      
      if (!is.na(sd_b) && sd_b > 0) {
        cum_dev <- cumsum(block - mean_b)
        R <- max(cum_dev) - min(cum_dev)
        S <- sd_b
        rs_blocks <- c(rs_blocks, R / S)
      }
    }
    if (length(rs_blocks) > 0) {
      rs_list <- c(rs_list, mean(rs_blocks))
      n_list <- c(n_list, n)
    }
  }
  
  if (length(rs_list) < 4) return(NA)
  fit <- lm(log(rs_list) ~ log(n_list))
  return(as.numeric(coef(fit)[2]))
}

# 2. SAF R DFA (DETRENDED FLUCTUATION ANALYSIS) FONKS??YONU
calc_hurst_dfa <- function(x) {
  x <- x[!is.na(x)]
  N <- length(x)
  if (N < 32) return(NA)
  
  # Birikimli profili olu??tur
  y <- cumsum(x - mean(x))
  
  min_w <- 8
  max_w <- floor(N / 4)
  sizes <- unique(floor(exp(seq(log(min_w), log(max_w), length.out = 15))))
  
  f_n <- c()
  n_list <- c()
  
  for (n in sizes) {
    num_blocks <- floor(N / n)
    if (num_blocks < 1) next
    
    sse <- 0
    total_pts <- 0
    
    for (b in 1:num_blocks) {
      idx <- ((b - 1) * n + 1):(b * n)
      y_block <- y[idx]
      t_block <- 1:n
      
      # Trendi temizle (Linear Detrending)
      fit_b <- lm(y_block ~ t_block)
      res <- residuals(fit_b)
      
      sse <- sse + sum(res^2)
      total_pts <- total_pts + n
    }
    
    if (total_pts > 0) {
      f_n <- c(f_n, sqrt(sse / total_pts))
      n_list <- c(n_list, n)
    }
  }
  
  if (length(f_n) < 4) return(NA)
  fit <- lm(log(f_n) ~ log(n_list))
  return(as.numeric(coef(fit)[2]))
}

# 3. VER?? Y??KLEME VE ????LEME
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

# 4. GENEL VE HAREKETL?? PENCERE HESAPLAMALARI (120 AY / 10 YIL)
overall_H_rs  <- calc_hurst_rs(df_clean$Precipitation)
overall_H_dfa <- calc_hurst_dfa(df_clean$Precipitation)

window_size <- 120

df_clean$Rolling_Hurst_RS <- rollapply(
  df_clean$Precipitation,
  width = window_size,
  FUN = calc_hurst_rs,
  fill = NA,
  align = "right"
)

df_clean$Rolling_Hurst_DFA <- rollapply(
  df_clean$Precipitation,
  width = window_size,
  FUN = calc_hurst_dfa,
  fill = NA,
  align = "right"
)

# 5. ??STAT??ST??KSEL ??ZET
cat("\n=================== HURST EXPONENT MEMORY SUMMARY ===================\n")
cat(sprintf("Overall R/S Hurst Exponent (H_RS)   : %.4f\n", overall_H_rs))
cat(sprintf("Overall DFA Hurst Exponent (H_DFA)  : %.4f (Sensitivity Check)\n", overall_H_dfa))
cat(sprintf("120-Month Rolling H_RS Mean         : %.4f\n", mean(df_clean$Rolling_Hurst_RS, na.rm = TRUE)))
cat(sprintf("120-Month Rolling H_DFA Mean        : %.4f\n", mean(df_clean$Rolling_Hurst_DFA, na.rm = TRUE)))
cat("=====================================================================\n")

# 6. G??RSELLE??T??RME (R/S vs DFA DYNAMICS)
df_plot <- df_clean %>% filter(!is.na(Rolling_Hurst_RS) & !is.na(Rolling_Hurst_DFA))

fig_hurst <- ggplot(df_plot, aes(x = Date)) +
  # Hareketli Hurst ??izgileri
  geom_line(aes(y = Rolling_Hurst_RS, color = "R/S Analysis (H)"), linewidth = 0.9) +
  geom_line(aes(y = Rolling_Hurst_DFA, color = "DFA Method (alpha)"), linewidth = 0.9, linetype = "twodash") +
  
  # Kritik Referans ??izgileri
  geom_hline(yintercept = 0.5, color = "#2C3E50", linetype = "solid", linewidth = 0.8) +
  geom_hline(yintercept = overall_H_rs, color = "#2980B9", linetype = "dashed", linewidth = 0.7) +
  
  # Rastgelelik E??i??i Etiketi
  annotate("text", x = min(df_plot$Date), y = 0.5, label = " H = 0.5 (Random Memory / White Noise)", 
           color = "#2C3E50", fontface = "italic", size = 3.5, hjust = 0, vjust = -0.5) +
  
  # Renk ve Lejant Ayarlar??
  scale_color_manual(
    name = "Metodoloji",
    values = c("R/S Analysis (H)" = "#2980B9", "DFA Method (alpha)" = "#D35400")
  ) +
  
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  
  labs(
    title = "120-Month Rolling Hurst Exponent (Long-Range Dependence Dynamics)",
    subtitle = "Comparison of Classical R/S Analysis and Detrended Fluctuation Analysis (DFA)",
    x = "Timeline",
    y = "Hurst Exponent (H / alpha)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 10),
    axis.title = element_text(face = "bold"),
    legend.position = "top",
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.7)
  )

# Grafi??i ??izdir ve Kaydet
print(fig_hurst)
ggsave("Figure_Hurst_Exponent_Rolling.png", plot = fig_hurst, width = 10, height = 5.5, dpi = 300)