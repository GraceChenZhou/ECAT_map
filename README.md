# Elemental Carbon Attributable to Traffic (ECAT)

Example plots were generated based on article 'XX' 20XX. The objective is to understand the contribution of environmental exposures and community characteristics (e.g., ECAT, deprivation index, green space, drive time to medical center) on predicting rapid lung function decline in cystic fibrosis (CF). We mainly focus on Cincinnati area because data were collected from Cincinnati Children's Hospital Medical Center, OH, USA. 

# Plot explanation

* Geomarkers of interest: ECAT, deprivation index, green space, drive time
* Rate of Change Plot (COUNTY_ROC.html) refers to the impact of geomarkers on rate of change for lung function in CF. The negative value denotes the percentage predicted decline per year in lung function (often measured by FEV1% predicted)
* Total Effect Plot (COUNTY_TE.html) refers to the total effect of geomarkers on lung function in CF stratified by age stages (e.g., early, middle, late). It was calculated by contribution of geomarker plus rate of change * age. 

# Notes
* All relevant data sets can be found under folder DATA
* GEN_ECAT_MAP_DT.r is the code used to generate proper data for maps 
* .rmd files are used to generate .html files
* Detailed formulas are recorded in Calculation.txt file
* ECAT_refs.bib is for inserting citations
* R version 4.0.2 (2020-06-22)
* R packages 
  + **tmap v3.3-2**
  + **rmarkdown v2.9**
  + **dplyr v1.0.5**
  + **leaflet v2.0.4.1**
  + **tigris v1.5**
  + **sp v1.4-4**
  + **rgeos v0.5-5**
  + **sf v0.9-7**
  + **mapview v2.10.0**
* System information: Darwin Kernel Version 20.3.0, x86_64

# Acknowledgement

The author is grateful to all of helps and supports from the team group: Andrew Vancil, Richard (Cole) Brokamp, Emrah Gecili, Rhonda Szczesniak, etc.  
