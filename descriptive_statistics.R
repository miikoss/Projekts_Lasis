# Ielādējam nepieciešamās bibliotēkas
library(dplyr)
library(psych)
library(writexl)  # Pievienojam 'writexl' bibliotēku

# Aprakstošā statistika (vidējais, mediāna, standartnovirze, minimums, maksimums, škerība, ekscess)
dati = read_excel("lasis_dati.xlsx")
aprakstosa_statistika = dati %>%
  select(Mirex, Hexachlorobenzene, HCH_gamma, Heptachlor_Epoxide, Dieldrin,
         Endrin, Total_Chlordane, Total_DDT, Dioxin, Total_Pesticides, Total_PCBs) %>%
  psych::describe()

# Pamatstatistika
pamatraditaji = dati %>%
  select(Mirex, Hexachlorobenzene, HCH_gamma, Heptachlor_Epoxide, Dieldrin,
         Endrin, Total_Chlordane, Total_DDT, Dioxin, Total_Pesticides, Total_PCBs) %>%
  summary()

# Izveidojam Excel failu ar divām lapām
write_xlsx(list("Aprakstošā Statistika" = aprakstosa_statistika, 
                "Pamatrādītāji" = as.data.frame(pamatraditaji)), 
           path = "rezultati_lasis.xlsx")  # Saglabājam kā 'rezultati.xlsx'

