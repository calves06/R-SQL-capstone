# extracts species and weights for a given year from portal rodent 
# database; makes a fancy plot and saves the plot to a file
# install packages!
install.packages("RSQLite")
library(RSQLite)
library(ggplot2)

# get command-line arguments
args <- commandArgs(TRUE)
if (length(args)==0) {
  stop("Script requires a year argument", call.=FALSE)
} else if (length(args)==1) {
  year <- args[1]
}

print(paste("Getting data for year",year)) #this is helpful w/ queries below.

# create a connection to the database
# 
# change path here --
SWC_mammals.sqlite <- "C:/Users/calve/Dropbox/Catie's Dropbox Files/UNC-CH/Statistics Resources/Software Carpentry Workshop/SoftwareCarpentry/SWC_mammals.sqlite"
conn <- dbConnect(drv = SQLite(), dbname= SWC_mammals.sqlite)

# some database functions for listing tables and fields
dbListTables(conn)
dbListFields(conn,"surveys")

# constructing a query
query_string <- "SELECT count(*) FROM surveys"
result <- dbGetQuery(conn,query_string)
head(result)

# write a query that gets the non-null weights for 
# all species in this year
query_string <- "SELECT year,species_id,weight FROM surveys WHERE weight IS NOT NULL 
            GROUP BY year,species_id"
result <- dbGetQuery(conn,query_string)
head(result)

# plot the data and save to a png file
ggplot()
outputfilename <- ".png"
ggsave(outputfilename)
