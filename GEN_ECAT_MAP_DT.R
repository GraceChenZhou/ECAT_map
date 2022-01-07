#Project: ECAT
#Author:Grace Zhou
#Reference: Andrew
#Purpose: Prepare data to plot
#Date: 2021.10.27
################################################################################
rm(list=ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(dplyr)
library(tmap)


indata=readRDS('DATA/ecat_map_data.rds')

#Remove records with all NAs

na_rows = indata %>%
  select(-geom) %>%
  is.na() %>%
  rowSums()

na_row_all=which(na_rows==max(na_rows))
indata1=indata %>%
  filter(rownames(.)!=na_row_all)

which(is.na(indata1$drive_time))
names(indata1)

#Mutate variables
indata2=indata1 %>% 
  mutate(contrib_ecat=ecat*ecat_coeff,
         contrib_depind=dep_index*depind_coeff,
         contrib_green=green*0.01*green_coeff,
         contrib_drive=drive_level*drive_coeff,
         change_ecat=ecat*ecat_age_coeff,
         change_depind=dep_index*depind_age_coeff,
         change_green=green*0.01*green_age_coeff,
         change_drive=drive_level*drive_age_coeff,
         contrib_total=rowSums(across(starts_with("contrib_"))),
         change_total=rowSums(across(starts_with("change_"))))


indata3=indata2 %>% 
  mutate(early=12.9, middle=16.3,late=18.5,
         early_eff_ecat=contrib_ecat+change_ecat*early,
         middle_eff_ecat=contrib_ecat+change_ecat*middle,
         late_eff_ecat=contrib_ecat+change_ecat*late,
         early_eff_depind=contrib_depind+change_depind*early,
         middle_eff_depind=contrib_depind+change_depind*middle,
         late_eff_depind=contrib_depind+change_depind*late,
         early_eff_green=contrib_green+change_green*early,
         middle_eff_green=contrib_green+change_green*middle,
         late_eff_green=contrib_green+change_green*late,
         early_eff_drive=contrib_drive+change_drive*early,
         middle_eff_drive=contrib_drive+change_drive*middle,
         late_eff_drive=contrib_drive+change_drive*late,
         early_eff_total=rowSums(across(starts_with("early_"))),
         middle_eff_total=rowSums(across(starts_with("middle_"))),
         late_eff_total=rowSums(across(starts_with("late_"))))


saveRDS(indata3,'plotData.rds')

###############################################################################

#https://walker-data.com/census-r/mapping-census-data-with-r.html
#https://spatialanalysis.github.io/workshop-notes/multiple-dataset-gis-operations-visualization.html

indata=readRDS('plotData.rds')

library(tigris)
library(sp)
library(rgeos)
library(leaflet)
library(sf)
library(tmap)
library(mapview)
options(tigris_use_cache = TRUE)
################################################################################
countyShp <- tigris::counties(year=2020, state = 'OH', cb = TRUE)

Hamilton <- countyShp[grep("Hamilton", countyShp$NAME), ]

leaflet(Hamilton) %>% addTiles() %>% addPolygons(fillOpacity = 0, color = "red") # display Hamilton region

################################################################################

st_crs(indata) #EPSG:3735 
Hamilton1=st_transform(Hamilton,3735)
st_crs(Hamilton1) #Make sure its EPSG=3735 as well

sf_join <- sf::st_join(indata, Hamilton1, join = st_intersects) #subset data
Hamilton.data <- sf_join[grep("Hamilton", sf_join$NAME), ]
saveRDS(Hamilton.data,'DATA/Hamilton_Data.rds')

################################################################################

OH.zip <- tigris::zctas(cb=FALSE, state='OH',year=2010) #extract zipcode
mapview::mapview(OH.zip) #display all zips for OH

Hamilton.zip<- sf::st_join(Hamilton, OH.zip, join = st_intersects) #subset zip code
selected.zip=Hamilton.zip$ZCTA5CE10 #zip for Hamilton county
Hamilton.zip <- tigris::zctas(cb=TRUE,starts_with = selected.zip)
mapview::mapview(Hamilton.zip)
saveRDS(Hamilton.zip,'DATA/Hamilton_Zipcode.rds')

################################################################################
#Appendix (for my brain strom records)
# uas <- urban_areas()
# cincy_ua <- uas[grep("Cincinnati", uas$NAME10), ]
# leaflet(cincy_ua) %>% addTiles() %>% addPolygons(fillOpacity = 0, color = "red")

# df1 <- zctas(year=2010,state='Ohio')
# head(df1)
# names(df1)
# 
# df2 = df1 %>% mutate(start=as.numeric(substr(ZCTA5CE10,1,2)))
# unique(df2$start)
# 
# df3 <- zctas(cb=TRUE,starts_with = c('45','44','43')) 
# mapview(df3)
# 
# selected.zip=c('45224','45223','45211','45238','45205',
#                '45214','45225','45232','45220','45219',
#                '45203','45202','45206','45207','45229',
#                '45217','45216','45237','45212','45213',
#                '45209','45208','45226','45227','45230')
# 
# length(selected.zip)
# df4 <- tigris::zctas(cb=TRUE,starts_with = selected.zip) 
# mapview::mapview(df4)
# 
# unique(df2$start)

# selected.zip=c('45202', '45203', '45219', '45214', '45206', '45225', '45220', '45229', '45207')
# 
# length(selected.zip)
# Cincy.zip <- tigris::zctas(cb=TRUE,starts_with = selected.zip)
# mapview::mapview(Cincy.zip)
# 
# st_crs(indata) #EPSG:3735 
# Cincy.zip1=st_transform(Cincy.zip,3735)
# st_crs(Cincy.zip1)
# 
# sf_join <- sf::st_join(indata, Cincy.zip1, join = st_intersects)
# subData=sf_join %>% filter(ZCTA5CE10 %in% selected.zip)
# saveRDS(subData,'subData_zip.rds')
# saveRDS(Cincy.zip1,'Cincy_zip.rds')

# st_crs(sf_join)
# selected.zip=sf_join$ZCTA5CE10
# Cincy.zip <- tigris::zctas(cb=TRUE,starts_with = selected.zip)
# mapview::mapview(Cincy.zip)
# st_crs(indata) #EPSG:3735 
# Cincy.zip1=st_transform(Cincy.zip,3735)
# saveRDS(OH.zip1,'Hamilton_zip.rds')