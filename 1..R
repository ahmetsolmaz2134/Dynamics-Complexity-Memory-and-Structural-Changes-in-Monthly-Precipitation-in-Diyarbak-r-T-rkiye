# 1. S??tun isimlerini tan??mlayal??m
colnames(df_raw)[1:3] <- c("Yil", "Ay", "Yagis")

# 2. 13. Aylar?? ????karal??m ve say??sal tipe d??n????t??relim
df <- df_raw %>%
  filter(Ay != 13) %>%
  mutate(
    Yil = as.numeric(Yil),
    Ay = as.numeric(Ay),
    Yagis = as.numeric(Yagis)
  )

# 3. ??ngilizce Ay Etiketleri
month_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
df$Month_Name <- factor(month_labels[df$Ay], levels = month_labels)

# 4. Ayl??k ??statistikler ve Grafik (Monthly Climatology)
monthly_summary <- df %>%
  group_by(Month_Name) %>%
  summarise(
    Mean = mean(Yagis, na.rm = TRUE),
    Sd   = sd(Yagis, na.rm = TRUE)
  )

ggplot(monthly_summary, aes(x = Month_Name, y = Mean)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "navy", width = 0.7) +
  geom_errorbar(aes(ymin = pmax(0, Mean - Sd), ymax = Mean + Sd), width = 0.2, color = "darkred") +
  labs(title = "Monthly Climatology (Mean Precipitation & Std Dev)", x = "Month", y = "Precipitation (mm)") +
  theme_minimal(base_size = 12)