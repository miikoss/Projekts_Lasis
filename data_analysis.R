# Ielādēt nepieciešamās bibliotēkas
library(readxl)
library(nortest)
library(ggplot2)

# Ielādēt datus no Excel faila
dati = read_excel("lasis_dati.xlsx")

# Parādīt pirmās datu rindas, lai saprastu to struktūru
print(head(dati))

# Izveidojiet PDF failu, lai saglabātu visus attēlus
pdf("all_plots.pdf")  # Tas izveidos PDF ar nosaukumu 'all_plots.pdf' jūsu darba direktorijā

# Cikls cauri katrai skaitliskajai kolonnai analīzei un zīmēšanai
for (kolonnas_nosaukums in colnames(dati)) {
  vertibas = dati[[kolonnas_nosaukums]]  # Iegūt kolonnas vērtības
  
  # Pārbaudīt, vai kolonnā ir skaitliskas vērtības pirms analīzes
  if (is.numeric(vertibas)) {
    cat("\nAnalizējam:", kolonnas_nosaukums, "\n")
    
    # Veikt normalitātes testus
    shapiro_tests = shapiro.test(vertibas)  # Shapiro-Wilk normalitātes tests
    print(shapiro_tests)  # Izdrukājam rezultātus

    ad_tests = ad.test(vertibas)  # Anderson-Darling normalitātes tests
    print(ad_tests)  # Izdrukājam rezultātus

    # Izveidot histogrammu un saglabāt to PDF
    hist(vertibas, main = paste("Histogramma par", kolonnas_nosaukums), xlab = kolonnas_nosaukums, breaks = 30)

    # Izveidot QQ grafiku un saglabāt to PDF
    qqnorm(vertibas)  # QQ diagramma
    qqline(vertibas, col = "red")  # QQ līnija
  } else {
    cat(kolonnas_nosaukums, "nav skaitliska un tiks izlaista.\n")  # Ja kolonna nav skaitliska, izdrukājam ziņu
  }
}

# Aizveram PDF ierīci
dev.off()
