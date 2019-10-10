###############################################
# LE LANGUAGE R AU QUOTIDIEN
#
#  CHAPITRE 5 : LES VARIABLES
#  
#  
#   
################################################


#################################################
#
# Creation d'une table avec une nouvelle variable calculée
#
# 
# 
#################################################

# librairies a charger
library(data.table) # gestion des données optimisées
library(dplyr) # gestion des données simplifiées



# definition du repertoire de travail
setwd("/Users/apple/Documents/R programming/LRQ Livre")
flat_df <- as.data.frame(flats)


# chargement des datasets
calendar <- fread("./data/calendar.csv", sep = ",")
flats <- fread("./data/flats.csv",sep = ",")
houses <- fread("./data/houses.csv",sep = ",")
other <- read_excel("./data/other.xlsx", sheet = 1)

# creation de datasets de travail
flats_df <- as.data.frame(flats)
flats_dt <- flats
class(flats_df)
class(flats_dt)

# creation d'une variable calculée
flats_df$bpa <- flats$bedrooms / flats$accommodates
flats_df$ppa <- flats$price / flats$accommodates

# meme ration pour un datatable
flats_dt[,c("bpa", "ppa") :=.(bedrooms / accommodates,
                              price / accommodates)]

tail(flats_df)
tail(flats_dt)

#meme ratio avec dplyr

flats_dplyr <- flats_dt %>%
  mutate(bpa = bedrooms / accommodates,
         ppa = price / accommodates)
tail(flats_dplyr)

# renommer des variables 
cal <- calendar
colnames(cal) <- c("id", "date.location", "prix")
head(cal)

#renommmer des variables avec dplyr
cal <- cal %>% rename(listing_id = id,
                      date_location = date.location)
head(cal)

# renommer une seule variable 
colnames(cal)[3] <- "Prix en euro" 
head(cal)

# supprimer des variables : 

# creation du dataset a partir de houses
maisons <- houses
# verification des dimensions du dataset
dim(maisons)
# suppression de la colonne 
maisons$neighbourhood <- NULL
# vérifications
head(maisons)
dim(maisons)


# supression de plusieurs colonnes,
# écritures spécifiques aux data.tables
sapply(maisons, class)
maisons[,c("last_scraped",
        "host_since",
        "host_location") := NULL]

# suppression d'une colonne par dplyr
maisons <- select(maisons, -number_of_reviews)

dim(maisons)
