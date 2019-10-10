###############################################
# LE LANGUAGE R AU QUOTIDIEN
#
#  CHAPITRE 4 : LES SELECTIONS
#  
#  Premiere partie sur la fonction which
#   seconde partie sur la fonction subset
################################################


#################################################
#
# EFonction Wich pour effectuer une selection de ligne
#
# 
# 
#################################################

# definition du repertoire de travail
setwd("/Users/apple/Documents/R programming/LRQ Livre/code")

install.packages("pacman")

#import des packages nécessaires
pacman::p_load('data.table','ggplot2', 'lattice', 'tibble', 'data.table', 'readxl', 'httr', 'curl', 'xlsx')

# Maisons louées plus de 1000e la nuit
houses[which(houses$price > 1000),
       .(id, price, review_scores_rating)]

#"^75//d{3}$"
# Maisons du 14e arrondissement de Paris avec plus de 4 chambres


#fonctions head and tail
head(calendar);
tail(houses)

#fonction lapply et sapply et de statistiques sommaires
class(calendar)
class(calendar$date)
lapply(calendar, class) #le resultat de lapply est un vecteur
sapply(calendar, class) # le résultat de sapply est une liste
str(calendar) # str pour structure, hybride entre class et head elle donne les dimensions et le type des objets ainsi que les premieres valeurs

summary(calendar)
summary(calendar$date)

glimpse(calendar) #glimpse est une fonction du package tibble
#elle peut s'utiliser sur les data.frame (donc aussi les data.table)
# affiche une liste de vairable, son type et ses valeurs
glimpse(calendar$price)

# Taille et noms associés à un objet
dim(calendar) #renvoi la dimension de l'objet calendar
nrow(calendar) # renvoi le nombre de ligne de calendar
ncol(calendar) 


houses[which(houses$zipcode == "75014"  & 
               houses$bedrooms > 4),
       .(id, price, zipcode, beds)]


# maison avec 10 a 12 chambres, 6 a 12 salles de bains

houses[which(houses$bedrooms %in% 10:12 |
          houses$bathrooms %in% 6:10),
.(id, price, zipcode, bedrooms, bathrooms)]

#statistiques sur les résevations avant le (data)
# opération lente a cause de la conversion de texte en date

summary(calendar[which(as.Date(calendar$date) <= "2016-10-31"),])




#################################################
#
# Fonction Subset
#
# La fonction subset est une fonction standard et de data.table
# Elle est plus synthetique que which car on a pas a rappeler le nom du data frame sur chaque colonne testée
#################################################

library(tibble)

#Maisons louées plus de 1000 e la nuit
subset(houses, price > 1000,
       c(id, price, review_scores_rating))


#Maisons louées plus de 1000 e la nuit avec une note renseignée
subset(houses, price > 1000 & ! is.na(review_scores_rating),
       c(id, price, review_scores_rating))

as.tibble(subset(houses,
                 cancellation_policy %in% 
                   c("moderate", "flexible") &
                   price > 500,
                 c(amenities, listing_url, host_id, host_name,
                   host_since, host_location, number_of_reviews, review_scores_rating)))

summary(subset(calendar, as.Date(calendar$date) <= "2016-10-31"))




#################################################
#
# Filtre avec la fonction dplyr
#
# La fonction dplyr propose plusieurs fonctions pour 
# réaliser des extractions de données fliter, slice pour les lignes et select pour les colonnes
#dplyr morcele les opérations sur les données en petites fonctions
# il est souvent nécessaire d'imbriquer ces fonctions
# on peut aussi les enchainer avec l'operateur %>% 
# NB dans ce cas on précisoin l'objet source dans la premiere fonction appelée
#################################################

library(dplyr)

# selection de la premiere colonne par l'indice
calendar %>%
  select(1)
# selection des colonnes dont le nom des colonnes se termine par "id"
colnames(flats %>% select(ends_with("id")))

# selection des colonnes dont le nom des colonnes commence par "pr"
colnames(flats %>% select(starts_with("pr")))

# selection des colonnes contenant "host"
colnames(flats %>% select(contains("host")))

#selection explicite de 3 colonnes 
colnames(flats %>% select("id", "price", "bedrooms"))

# utilisation de slice au lieu de select
# slide utilise le numéro d'indice.

#selection des maisons loués plus de 1000 e la nuit
houses %>% filter(price > 1000) %>%
  select("id", "price", zipcode)

# maisons sur le 14 loué plus de 1000e la nuit
houses %>% filter(price > 1000, zipcode == 75014) %>%
  select("id", price, zipcode)

# maisons du 14e loué plus de 800 e la nuit dont la condition d'annulation est flexible ou modérée
houses %>% filter(price > 800, cancellation_policy %in% 
                    c("moderate", "flexible")) %>%
  select("id", price, zipcode, cancellation_policy)

# statistique de réservation pour les paartements loués avant le 31/10/16
summary(calendar %>% filter(as.Date(calendar$date) <= "2016-10-31"))


################################################
###
###FILTRE SUR UN DATA TABLE
###
################################################

library(data.table)

houses[price > 1000, .(id, price, review_scores_rating)]

# maison louées plus de 1000 e avec un avis de renseigné
houses[price > 1000 & ! is.na(review_scores_rating), .(id, price, review_scores_rating)]

#maison du 14e avec plus de 4 chamvres 
houses[zipcode == "75014" & bedrooms > 4, .(id, price, review_scores_rating, bedrooms, zipcode)]

#maisons avec 10 et 12 chambres et entre 6 et 10 salles de bains
houses[ between(bedrooms, 10, 12) | between(bathrooms, 6, 10), .(id, price, review_scores_rating, bedrooms, bathrooms, zipcode)]

# résumé des statistiques usr les réservations du 31_10_2016
summary(calendar[as.Date(date) <= "2016-10-31"])

# statistique de réservation pour les paartements loués avant le 31/10/16
summary(calendar %>% filter(as.Date(calendar$date) <= "2016-10-31"))

list <- calendar[as.Date(date) <= "2016-10-31"]