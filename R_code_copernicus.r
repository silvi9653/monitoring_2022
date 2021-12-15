#R code for uploading and visualizing copernicus data in R
#Use of copernicus data
#we download Cryosphere - Snow Cover Extent 1km v1 in data 14-12-2021
#install.packages("ncdf4")
#install.packages("raster")
library(ncdf4)
library(raster)
#set the working directory
setwd("C:/lab/copernicus")

#upload the data 
#single layer so we use a raster function
snow20211214<-raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214 #call the objects to see the information of the picture
#plot the images
plot(snow20211214)
