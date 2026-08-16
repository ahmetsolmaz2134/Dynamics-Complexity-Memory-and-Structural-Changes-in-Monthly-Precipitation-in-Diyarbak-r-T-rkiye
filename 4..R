# ==============================================================================
# SAMPLE ENTROPY (SampEn) - SAFE VERSION (NA HANDLED)
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("zoo")) install.packages("zoo")

library(readxl)
library(dplyr)
library(ggplot2)
library(zoo)

# 1. HATA GE????RMEZ (SAFE) SAMPLE ENTROPY FONKS??YONU
calc_sampen <- function(x, m = 2, r = 0.2 * sd(x, na.rm = TRUE)) {
  x <- x[!is.na(x)] # NA de??erleri temizle
  N <- length(x)
  
  # Yeterli veri yoksa, r NA ise veya r <= 0 ise NA d??nd??r
  if (N <= m + 1 || is.na(r) || r <= 0) return(NA)
  
  count_m <- 0
  count_m1 <- 0
  
  for (i in 1:(N - m)) {
    for (j in (i + 1):(N - m)) {
      
      # m boyutu i??in uzakl??k
      sub_i_m <- x[i:(i + m - 1)]
      sub_j_m <- x[j:(j + m - 1)]
      dist_m <- max(abs(sub_i_m - sub_j_m))
      
      # NA kontrol?? ile g??venli Kar????la??t??rma
      if (!is.na(dist_m) && dist_m <= r) {
        count_m <- count_m + 1
        
        # m + 1 boyutu i??in uzakl??k
        sub_i_m1 <- x[i:(i + m)]
        sub_j_m1 <- x[j:(j + m)]
        dist_m1 <- max(abs(sub_i_m1 - sub_j_m1))
        
        if (!is.na(dist_m1) && dist_m1 <= r) {
          count_m1 <- count_m1 + 1
        }
      }
    }
  }
  
  if (count_m == 0 || count_m1 == 0) return(NA)
  return(-log(count_m1 / count_m))
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

# 3. HAREKETL?? PENCERE HESAPLAMASI (120 AY / 10 YIL)
overall_sampen <- calc_sampen(df_clean$Precipitation, m = 2)

df_clean$Rolling_SampEn <- rollapply(
  df_clean$Precipitation,
  width = 120,
  FUN = function(w) calc_sampen(w, m = 2),
  fill = NA,
  align = "right"
)

# 4. G??RSELLE??T??RME
mean_rolling <- mean(df_clean$Rolling_SampEn, na.rm = TRUE)

fig_sampen <- ggplot(df_clean %>% filter(!is.na(Rolling_SampEn)), aes(x = Date, y = Rolling_SampEn)) +
  geom_line(color = "#1F77B4", linewidth = 1.0) +
  geom_hline(yintercept = overall_sampen, color = "#D62728", linetype = "dashed", linewidth = 0.8) +
  geom_hline(yintercept = mean_rolling, color = "#2CA02C", linetype = "dotted", linewidth = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "#FF7F0E", linewidth = 0.9) +
  labs(
    title = "120-Month Rolling Sample Entropy (SampEn) Dynamics",
    subtitle = "Evaluation of Hydroclimatic Complexity and Regularity over Time (m = 2, r = 0.2*SD)",
    x = "Timeline",
    y = "Sample Entropy (SampEn)"
  ) +
  theme_bw(base_size = 11)

print(fig_sampen)