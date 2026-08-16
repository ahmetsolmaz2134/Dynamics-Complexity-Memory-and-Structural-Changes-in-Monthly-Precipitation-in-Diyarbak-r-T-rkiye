# ==============================================================================
# CONTINUOUS WAVELET TRANSFORM (CWT) - TEM??Z GRAF??K D??ZEN??
# ==============================================================================

if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("WaveletComp")) install.packages("WaveletComp")

library(readxl)
library(dplyr)
library(ggplot2)
library(WaveletComp)

# 1. VER?? Y??KLEME VE ????LEME
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

my_data <- data.frame(
  date = df_clean$Date,
  Precipitation = df_clean$Precipitation
)

# 2. WAVELET HESAPLAMASI
wt_result <- analyze.wavelet(
  my_data,
  my.series = "Precipitation",
  loess.span = 0,
  dt = 1/12,
  dj = 1/20,
  lowerPeriod = 1/6,
  upperPeriod = 8,
  make.pval = TRUE,
  n.sim = 100
)

# 3. GRAF??K EKRANINI SIFIRLAMA (??ST ??STE B??NME HATA ENGELLEY??C??)
graphics.off()

# 4. RSTUDIO EKRANINA TEM??Z ????Z??M
wt.image(
  wt_result,
  color.key = "quantile",
  n.levels = 250,
  legend.params = list(
    lab = "Wavelet Power Spectrum",
    lab.line = 2.5
  ),
  periodlab = "Period (Years)",
  timelab = "Timeline",
  main = "Continuous Wavelet Power Spectrum (Diyarbakir Precipitation)",
  graphics.reset = TRUE
)

# 5. DOSYAYA Y??KSEK ????Z??N??RL??KL?? KAYIT (300 DPI)
png("Figure_Wavelet_Power_Spectrum.png", width = 11, height = 6.5, units = "in", res = 300)
wt.image(
  wt_result,
  color.key = "quantile",
  n.levels = 250,
  legend.params = list(
    lab = "Wavelet Power Spectrum",
    lab.line = 2.5
  ),
  periodlab = "Period (Years)",
  timelab = "Timeline",
  main = "Continuous Wavelet Power Spectrum (Diyarbakir Precipitation)",
  graphics.reset = TRUE
)
dev.off()

cat("\n================ CWT ANAL??Z?? BA??ARIYLA TAMAMLANDI ================\n")
cat("Grafik RStudio ekran??nda temiz bir ??ekilde g??sterildi ve 'Figure_Wavelet_Power_Spectrum.png' olarak kaydedildi.\n")