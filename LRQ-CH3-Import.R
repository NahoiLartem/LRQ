###############################################
# LE LANGUAGE R AU QUOTIDIEN
#
#  Fonction read.delim pour import du fichier
#  Rbnb de house
#  puis fread
#   pour excel nous présenterons un exemple avec readxl
################################################


#################################################
#
# Exercice avec la fonction read.delim
#
# Cette fonction renvoie le dataset dans un data.frame
# nous utiliserons ensuite fread  pour avoir le resultat en data.table
#################################################

# definition du repertoire de travail
setwd("/Users/apple/Documents/R programming/LRQ Livre")

install.packages("pacman")

#import des packages nécessaires
pacman::p_load('ggplot2', 'lattice', 'tibble', 'data.table', 'readxl', 'httr', 'curl', 'xlsx')

#Import du fichier house de airBnB depuis internet
houses <- read.delim(url("http://www.od-datamining.com/livreR/houses.csv"),
                     sep = ",",
                     stringsAsFactors = FALSE)

flats <- read.delim(url("http://www.od-datamining.com/livreR/flats.csv"),
                     sep = ",",
                     stringsAsFactors = FALSE)




as_tibble(houses) #Affichage

# import du fichier calendar avec typage explicite des colonnes
calendar <- read.delim(url("http://www.od-datamining.com/livreR/calendar.csv"),
                        sep = ",",
                        colClasses = c("integer",
                                       "Date",
                                       "numeric"),
                        stringsAsFactors = FALSE)

as_tibble(calendar) #affichage


#################################################
#
# Exercice avec la fonction fread
#
# 
# nous utilisons fread  pour avoir le resultat en data.table
# la gestion des imports est optimisee
#################################################

?fread
#fread(input, file, text, cmd, sep="auto", sep2="auto", dec=".", quote="\"",
#nrows=Inf, header="auto",
#na.strings=getOption("datatable.na.strings","NA"),  # due to change to ""; see NEWS
#stringsAsFactors=FALSE, verbose=getOption("datatable.verbose", FALSE),
#skip="__auto__", select=NULL, drop=NULL, colClasses=NULL,
#integer64=getOption("datatable.integer64", "integer64"),
#col.names,
#check.names=FALSE, encoding="unknown",
#strip.white=TRUE, fill=FALSE, blank.lines.skip=FALSE,
#key=NULL, index=NULL,
#showProgress=getOption("datatable.showProgress", interactive()),
#data.table=getOption("datatable.fread.datatable", TRUE),
#nThread=getDTthreads(verbose),
#logical01=getOption("datatable.logical01", FALSE),  # due to change to TRUE; see NEWS
#keepLeadingZeros = getOption("datatable.keepLeadingZeros", FALSE),
#autostart=NA
#)

# import du fichier houses.csv depuis internet
houses <- fread("http://www.od-datamining.com/livreR/houses.csv",
                sep = ",")
calendar <- fread("http://www.od-datamining.com/livreR/calendar.csv",
                  sep = ",",
                  colClasses = sapply(houses, class))
 
print(houses) options(max.print = 300) # l'option est setté en général




#################################################
##
## Import depuis le disk local
##
################################################


calendar <- fread("./data/calendar.csv",
                sep = ",")

flats <- fread("./data/flats.csv",
               sep = ",")


houses <- fread("./data/houses.csv",
               sep = ",")

other <- read_excel("./data/other.xlsx", sheet = 1)




#################################################
#
# Exercice avec la fonction read-excel (readxl)
#
# Cette fonction ne nécessite ni d'avoir java ou perl d'installé
# contrairement a d'autres package comme xlsx(java), XLConnect(java) ou gdata (perl)
#################################################



#?read_excel
#read_excel(path, 
#           sheet = NULL, # numero de feuille ou "nom"
#           range = NULL, #"Plage de cellules
#           col_names = TRUE, #skip du nombre de ligne
#           col_types = NULL, # vecteur type colonne
#           na = "", 
#           trim_ws = TRUE, 
#           skip = 0,
#           n_max = Inf, 
#           guess_max = min(1000, n_max), # nombre de valeurs
#           progress = readxl_progress(),
#           .name_repair = "unique")

# NB la fonction read_excel ne sait pas importer depuis internet, il est nécessaire d'utiliser GET et write_disk

#Import du fichier other.xlsx depuis internet
GET("http://www.od-datamining.com/livreR/other.xlsx",
    write_disk(fic <- tempfile(fileext = ".xlsx")))
# on importe fic
other <- read_excel(fic, sheet = 1)
?curl

install.packages('curl')
library(curl)

houses <- read.delim(url("http://www.od-datamining.com/livreR/houses.csv"),

install.packages('xlsx')
library(xlsx)

read.xlsx("http://www.od-datamining.com/livreR/houses.csv",
          as.data.frame=TRUE,
          header=TRUE,
          colClasses=NA)
                     
                     
                     