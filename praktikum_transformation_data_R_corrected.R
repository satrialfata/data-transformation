# Analisis Praktikum Data Transformasi (R)
# Dataset: mpg, diamonds, msleep, flights
# Menggunakan paket: ggplot2, dplyr, nycflights13

# ============================================================
# 0. Instalasi & Pemuatan Paket (Jalankan sekali jika belum)
# ============================================================
# install.packages("ggplot2") # Untuk dataset diamonds, msleep, dan mpg
# install.packages("dplyr")   # Untuk manipulasi data (filter, select, mutate, group_by, summarise)
# install.packages("nycflights13") # Untuk dataset flights

library(ggplot2)
library(dplyr)


# ============================================================
# 1. Dataset: mpg
# Deskripsi: Dataset berisi spesifikasi mobil dan efisiensi bahan bakar.
# Tugas:
# 1. Mengurutkan mobil berdasarkan `displ` (menaik & menurun)
# 2. Memilih kolom tertentu (`manufacturer`, `model`, `cty`, `hwy`)
# 3. Memfilter mobil dengan `displ` 2.0–4.0 liter dan `cty` >= 20
# 4. Mengelompokkan berdasarkan `class` dan menghitung rata-rata `cty`, `hwy` dan jumlah mobil.
# 5. Menambahkan kolom `mpg_avg` (rata-rata cty & hwy) dan klasifikasi efisiensi (High/Medium/Low).
# ============================================================

# Load dataset mpg dari ggplot2
data(mpg, package = "ggplot2")

# 1. Mengurutkan mobil berdasarkan `displ` (menaik & menurun)
mpg_asc <- mpg %>%
  arrange(displ)
cat("=== MPG Displacement Menaik (5 teratas) ===\n")
print(head(mpg_asc %>% select(manufacturer, model, displ, cty, hwy)))

mpg_desc <- mpg %>%
  arrange(desc(displ))
cat("\n=== MPG Displacement Menurun (5 teratas) ===\n")
print(head(mpg_desc %>% select(manufacturer, model, displ, cty, hwy)))

# 2. Memilih kolom tertentu (`manufacturer`, `model`, `cty`, `hwy`)
# Catatan: Kolom-kolom ini sudah tersedia langsung di dataset `mpg` dari `ggplot2`.
# `cty` adalah mpg kota, `hwy` adalah mpg jalan raya.
mpg_selected <- mpg %>%
  select(manufacturer, model, displ, cty, hwy, class)

cat("\n=== MPG Kolom Terpilih (5 teratas) ===\n")
print(head(mpg_selected))

# 3. Memfilter mobil dengan `displ` 2.0–4.0 liter dan `cty` >= 20
mpg_filtered <- mpg_selected %>%
  filter(displ >= 2.0, displ <= 4.0, cty >= 20)

cat(paste0("\nJumlah data MPG setelah filter: ", nrow(mpg_filtered), "\n"))
cat("=== MPG Setelah Filter (5 teratas) ===\n")
print(head(mpg_filtered))

# 4. Mengelompokkan berdasarkan `class` dan menghitung rata-rata `cty`, `hwy` dan jumlah mobil.
mpg_grouped <- mpg_filtered %>%
  group_by(class) %>%
  summarise(
    avg_cty = mean(cty, na.rm = TRUE),
    avg_hwy = mean(hwy, na.rm = TRUE),
    jumlah_mobil = n()
  ) %>%
  arrange(desc(avg_cty))

cat("\n=== MPG Rata-rata per Class ===\n")
print(mpg_grouped)

# 5. Menambahkan kolom `mpg_avg` dan klasifikasi efisiensi (High/Medium/Low).
mpg_final <- mpg_filtered %>%
  mutate(
    mpg_avg = (cty + hwy) / 2,
    efisiensi = case_when(
      mpg_avg >= 30 ~ "High",
      mpg_avg >= 25 ~ "Medium",
      TRUE ~ "Low"
    )
  )

cat("\n=== MPG Data Final dengan Efisiensi (10 teratas) ===\n")
print(head(mpg_final %>% select(manufacturer, model, cty, hwy, mpg_avg, efisiensi), 10))
cat("\n=== Distribusi Kategori Efisiensi MPG ===\n")
print(table(mpg_final$efisiensi))
cat("\n")


# ============================================================
# 2. Dataset: diamonds
# Deskripsi: Dataset tentang kualitas berlian dan harga (dari paket ggplot2).
# Tugas:
# 1. Pilih kolom: cut, color, clarity, carat, price.
# 2. Filter cut = "Ideal" atau "Premium" dan price > 5000.
# 3. Urutkan berdasarkan carat menurun.
# 4. Kelompokkan berdasarkan cut, hitung rata-rata price dan jumlah berlian.
# 5. Tambahkan kolom baru price_per_carat = price / carat.
# ============================================================

data(diamonds)

# 1. Pilih kolom
diamonds_sel <- diamonds %>%
  select(cut, color, clarity, carat, price)

# 2. Filter
diamonds_filt <- diamonds_sel %>%
  filter(cut %in% c("Ideal", "Premium"), price > 5000)

# 3. Urutkan descending carat
diamonds_sorted <- diamonds_filt %>%
  arrange(desc(carat))

# 4. Kelompokkan dan agregasi
diamonds_grouped <- diamonds_sorted %>%
  group_by(cut) %>%
  summarise(average_price = mean(price), count = n())

# 5. Kolom baru
diamonds_final <- diamonds_sorted %>% 
  mutate(price_per_carat = price / carat)

cat("=== DIAMONDS ===\n")
print(head(diamonds_final))
print(diamonds_grouped)
cat("\n")


# ============================================================
# 3. Dataset: msleep
# Deskripsi: Dataset tentang pola tidur mamalia (dari paket ggplot2).
# Tugas:
# 1. Pilih kolom: name, order, sleep_total, bodywt.
# 2. Filter sleep_total >= 10 jam.
# 3. Urutkan berdasarkan bodywt menurun.
# 4. Kelompokkan berdasarkan order, hitung jumlah spesies, rata-rata tidur, berat maksimum.
# 5. Tambahkan kolom sleep_efficiency = "High" jika sleep_total > 12 jam, else "Low".
# ============================================================

data(msleep, package = "ggplot2")

# 1. Pilih kolom
msleep_sel <- msleep %>% select(name, order, sleep_total, bodywt)

# 2. Filter
msleep_filt <- msleep_sel %>% filter(sleep_total >= 10)

# 3. Urutkan menurun bodywt
msleep_sorted <- msleep_filt %>% arrange(desc(bodywt))

# 4. Kelompokkan dan agregasi
msleep_grouped <- msleep_sorted %>% group_by(order) %>%
  summarise(species_count = n(),
            average_sleep = mean(sleep_total),
            max_bodywt = max(bodywt))

# 5. Kolom baru sleep_efficiency
msleep_final <- msleep_sorted %>% 
  mutate(sleep_efficiency = ifelse(sleep_total > 12, "High", "Low"))

cat("=== MSLEEP ===\n")
print(head(msleep_final))
print(msleep_grouped)
cat("\n")


# ============================================================
# 4. Dataset: flights
# Deskripsi: Dataset penerbangan NYC (dari paket nycflights13).
# Tugas:
# 1. Pilih kolom: year, month, day, dep_delay, arr_delay, distance, air_time.
# 2. Filter dep_delay >= 60 atau arr_delay >= 60.
# 3. Urutkan berdasarkan distance menurun.
# 4. Kelompokkan berdasarkan month, hitung rata-rata dep_delay dan arr_delay.
# 5. Tambahkan kolom time_gain = dep_delay - arr_delay dan speed = distance / air_time * 60.
# ============================================================

library(nycflights13) # Muat paket nycflights13

df_flights <- nycflights13::flights # Gunakan dataset flights dari paket

# 1. Pilih kolom
flights_sel <- df_flights %>% select(year, month, day, dep_delay, arr_delay, distance, air_time)

# 2. Filter
flights_filt <- flights_sel %>% filter(dep_delay >= 60 | arr_delay >= 60)

# 3. Urutkan distance menurun
flights_sorted <- flights_filt %>% arrange(desc(distance))

# 4. Kelompokkan per month
flights_grouped <- flights_sorted %>% group_by(month) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE),
            avg_arr_delay = mean(arr_delay, na.rm = TRUE))

# 5. Kolom baru
flights_final <- flights_sorted %>%
  mutate(time_gain = dep_delay - arr_delay,
         speed = distance / air_time * 60)

cat("=== FLIGHTS ===\n")
print(head(flights_final))
print(flights_grouped)
cat("\n")
