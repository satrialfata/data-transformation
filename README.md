# Data Transformation Praktikum

Proyek ini berisi kode R dan Jupyter Notebook untuk praktikum transformasi data menggunakan library `dplyr` dan `ggplot2`.

## Isi Repositori
- `praktikum_transformation_data_R_corrected.R`: Script R utama yang melakukan manipulasi data pada dataset `mpg`, `diamonds`, `msleep`, dan `nycflights13::flights`.
- `praktikum_transformation_data.ipynb`: Notebook Jupyter untuk analisis dan eksperimen interaktif.

## Dataset & Operasi Transformasi Data
1. **mpg**: Sorting `displ`, filtering efisiensi bahan bakar, grouping per `class`, dan penambahan atribut efisiensi.
2. **diamonds**: Filtering potongan `Ideal`/`Premium` & harga, grouping per `cut`, serta kalkulasi `price_per_carat`.
3. **msleep**: Filtering durasi tidur, sorting `bodywt`, grouping per `order`, dan pengkategorian `sleep_efficiency`.
4. **flights**: Filtering keterlambatan (`dep_delay`, `arr_delay`), grouping per `month`, serta penambahan atribut `time_gain` dan `speed`.

## Prasyarat & Paket R
- R (v4.0+)
- Paket R: `ggplot2`, `dplyr`, `nycflights13`

```R
install.packages(c("ggplot2", "dplyr", "nycflights13"))
```
