# Elemental Carbon Attributable to Traffic (ECAT)

Example plots were generated based on article 'XX' 20XX. The objective is to understand the contribution of environmental exposures and community characteristics (e.g., ECAT, deprivation index, green space, drive time to medical center) on predicting rapid lung function decline in cystic fibrosis (CF). We mainly focus on Cincinnati area because data were collected from Cincinnati Children's Hospital Medical Center, OH, USA. 

# Plot explanation

* Geomarkers of interest: ECAT, deprivation index, green space, drive time
* Rate of Change Plot refers to the impact of geomarkers on rate of change for lung function in CF. The negative value denotes the percentage predicted decline per year in lung function (often measured by FEV1% predicted)
* Total Effect Plot refers to the total effect of geomarkers on lung function in CF stratified by age stages (e.g., early, middle, late). It was calculated by contribution of geomarker plus rate of change * age. 

# Notes

* More detailed formulas were recorded in Calculation.txt file
* Two plot.html files were executed by R version 4.0.2 (2020-06-22) with R package **tmap V3.3-2**, **rmarkdown V2.9**, **dplyr V1.0.5**,**leaflet V2.0.4.1**
* The system information: Darwin Kernel Version 20.3.0, x86_64

# Acknowledgement

The author is grateful to all of helps and supports from the team group: Andrew Vancil, Richard (Cole) Brokamp, Emrah Gecili, Rhonda Szczesniak, etc.  
