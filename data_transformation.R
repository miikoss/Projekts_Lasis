# Ielādēt nepieciešamās bibliotēkas
library(readxl)
library(dplyr)

# 1. solis: Nolasīt Excel failu

dati = read_excel("lasis_dati.xlsx")

# 2. solis: Pārbaudīt datu struktūru
print(colnames(dati))  # Pārbaudīt kolonnu nosaukumus
str(dati)              # Apskatīt datu struktūru

# 3. solis: Pārliecināties, ka 'Location' eksistē// nevajadzīgs solis
if (!"Location" %in% colnames(dati)) {
  stop("Kolonna 'Location' neeksistē datu kopā.")
}

# Pārvērst 'Location' par faktoru, ja vēlaties to uzskatīt par kategorisku
dati$Location <- as.factor(dati$Location)

# 4. solis: Datu transformācija un boxplotu izveide
for (kolonnas_nosaukums in colnames(dati)) {
  vertibas = dati[[kolonnas_nosaukums]]
  # 4.1 solis: Normālības tests un transformācija, ja skaitlisks
  if (is.numeric(vertibas) && all(vertibas > 0)) {
    log_vertibas = log(vertibas)
    # Veikt normālības testus
    shapiro_tests_log = shapiro.test(log_vertibas)
    print(shapiro_tests_log)
    # Pārliecināties, ka 'ad.test' ir definēts vai iekļauts no bibliotēkas
    if (exists("ad.test")) {
      ad_tests_log = ad.test(log_vertibas)
      print(ad_tests_log)
    } else {
      warning("ad.test funkcija netika atrasta; tiek izlaists Anderson-Darling tests.")
    }
    # 4.2 solis: Izveidot boxplotus
    boxplot(vertibas ~ dati$Location,  # Aizstāt 'Location' ar izvēlēto grupēšanas mainīgo
            main = paste("Boxplot of", kolonnas_nosaukums), 
            xlab = "Atrašanās vieta", 
            ylab = kolonnas_nosaukums)
  }
}
