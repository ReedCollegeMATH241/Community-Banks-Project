library(foreign)
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(rvest))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(maps))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(ggmap))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(maptools))
suppressPackageStartupMessages(library(ggthemes))

clean.text <- function(text){
  text <- gsub("[^[:alnum:]]", "", text)
  text <- gsub(" ", "", text)
  text <- tolower(text)
  return(text)
}

cbsb <- read.dta("/Users/eparment/Dropbox/Senior Year/Stats/cb_cu_sb20072011_controls2005 march 5.dta")

US <- readOGR(dsn=".", 
              layer="gz_2010_us_050_00_500k", 
              verbose=FALSE) 

US@data <- US@data %>% mutate(county=paste(STATE,COUNTY,sep=""))
View(US@data)

# Convert shapefile to ggplot'able object
US.map <- fortify(US, region="county") %>% tbl_df() %>%
  rename(fipscnty=id)


ggplot(US.map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white") +
  geom_path(col="black", size=0.5) +
  coord_map() +
  theme_bw()
