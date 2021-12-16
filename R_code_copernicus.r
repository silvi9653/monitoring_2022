#R code for uploading and visualizing copernicus data in R
#Use of copernicus data
#we download Cryosphere - Snow Cover Extent 1km v1 in data 14-12-2021
#https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
#install.packages("ncdf4")
#install.packages("raster")
#install.packages("viridis")
#install.packages("RStoolbox")
#install.packages("ggplot2")
library(ncdf4)
library(raster)
library(viridis)
library(RStoolbox)
library(ggplot2)
#set the working directory
setwd("C:/lab/copernicus")

#upload the data 
#single layer so we use a raster function
snow20211214<-raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
#to see how many layer are inside copernicus file
#snow20211214<-brick("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
#in this case it's sign 1 layer so we use raster function
snow20211214 #call the objects to see the information of the picture
#plot the images
plot(snow20211214)

#day2....
#make the color rampe palette
cl<-colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(snow20211214, col=cl)

#use viridis packages for color palette also for colorblind people its nice 
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# here we use these functions library(viridis); library(RStoolbox); library(ggplot2)
#first create ggplot with geom_raster(x, mapping=aea(x=,y=,fill=))+scale_fill_viridis() for the raster images 
snow20211214 #fill name in the information of the picture: Snow.Cover.Extent
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent))#defoult color
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+scale_fill_viridis()#asign the defoult viridis palette
#change the palette
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+scale_fill_viridis(option="cividis")#to change the different palette in viridis function
#use argument ggtitle("")
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+scale_fill_viridis(option="cividis")+ggtitle("cividis palette")

#day3....
#download another data in the coperincus site
#we download Cryosphere - Snow Cover Extent 1km v1 in data 29-08-2021


