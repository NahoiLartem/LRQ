###############################################
# LE LANGUAGE R AU QUOTIDIEN
#
#  CHAPITRE 4 : LES INDEXS
#  
#  fonction haskey et setkey
################################################



# haskey fonctionne pour les datatables
class(flats)
# flats est un data.table

haskey(flats)  # on remarque le retour à FALSE indiquant l'absence d'index
setkey(flats, zipcode)
haskey(flats) 
setkey(flats, NULL) # on supprime l'index
haskey(flats) 

#################################################
#
# Evaluation du cout de création d'un index
#
# Utilisation de la fonction microbenchmark
# 
#################################################

install.packages("microbenchmark")
library(microbenchmark)
library(data.table)
haskey(flats)  # on remarque le retour à FALSE indiquant l'absence d'index
setkey(flats, zipcode)
haskey(flats) 
microbenchmark(summary(flats["75014",]$price), times=1000L) # il est nécessaire pour cette synthaxe d'avoir un index de renseigné.
setkey(flats, NULL) # on supprime l'index
haskey(flats) 




##################################################
##
##    Tirage d'échantillons
##
##################################################

# Fonction sample du package base avec ou sans remise
set.seed(42)

flats[sample(1:nrow(flats), 5),.(id, zipcode, price)]


library(dplyr)
sample_n(flats[,.(id, zipcode, price)],5)  #nécessite dplyr

sample_frac(flats[,.(id, zipcode, price)], 0.0001) #nécessite dplyr







