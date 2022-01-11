#This is the code for the final exam
#I want to analyze how the vegetation prensence in the Amazonia forest condition the soilwater content.
#I compare the first ten days of the 2014 and the 2021 to analyze the deforestation problem in this region
#download images from copernicus program
#Soil Water Index - 10-daily SWI 12.5km Global V3
#LAI 300m V1

# install and import all the library 
#install.packages("ncdf4")
#install.packages("raster")
#install.packages("viridis")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("patchwork")
library(ncdf4) #for import the copernicus file 
library(raster) #for work with raster file
library(viridis) # for plot the color palette
library(RStoolbox) #useful for remote sensing image processing 
library(ggplot2)  # for create graphics 
library(patchwork) #for multiframe graphics

#set the working directory
setwd("C:/lab/exam")

#import images of soilwater with lapply function
rlist<- list.files(pattern="SWI10") #create a list with a common pattern
rlist 

list_rast<-lapply(rlist,raster) #plot the images
list_rast #view the information of the pictures

#make the stack, to have all of them togheter
wsoil<-stack(list_rast)
wsoil 

#create a palette first
cl<- colorRampPalette(c("darkblue","blue","lightblue"))(100)
#plot the images 
plot(wsoil, col=cl)

# now crop them in the Amazon Forest
ext<-c(-100,0,-50,20) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
water2014<-crop(wsoil$Soil.Water.Index.with.T.5.1,ext) 
water2021<-crop(wsoil$Soil.Water.Index.with.T.5.2,ext) 
water2014 #call the object to see the name information
#plot the images with ggplot()
gp1<-ggplot()+geom_raster(water2014, mapping=aes(x=x, y=y, fill=Soil.Water.Index.with.T.5.1 ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2014")
gp2<-ggplot()+geom_raster(water2021, mapping=aes(x=x, y=y, fill=Soil.Water.Index.with.T.5.2))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2021")
#put one in top of the other
gp1/gp2

difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#create the color ramp palette
#yellow use for catch the eyes view 
waterdif<-water2014-water2021
plot(waterdif, col=difcl)#plotting the images

#upload LAI data
LAI2014<-raster("c_gls_LAI300_201401100000_GLOBE_PROBAV_V1.0.1.nc")
LAI2021<-raster("c_gls_LAI300_202101100000_GLOBE_OLCI_V1.1.1.nc")
#now crop them in the Amazon Forest
cLAI2014<-crop(LAI2014,ext) 
cLAI2021<-crop(LAI2021,ext) 
cLAI2014 #call to see the name 
cLAI2021
#plot the crop images
LAIgp1<-ggplot()+geom_raster(cLAI2014, mapping=aes(x=x, y=y, fill=Leaf.Area.Index.333m  ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("LAI in 2014")
LAIgp2<-ggplot()+geom_raster(cLAI2021, mapping=aes(x=x, y=y, fill=Leaf.Area.Index.333m ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("LAI in 2021")
#put one images in top of the other
LAIgp1/LAIgp2

LAIdif<-cLAI2014-cLAI2021
plot(LAIdif, col=difcl)#plotting the images

#upload the data of temperature
#single layer so we use a raster function
temp2021<-raster("c_gls_LST10-DC_202101010000_GLOBE_GEO_V1.2.1.nc")
# now crop them in the Amazon Forest
c2021<-crop(temp2021,ext) 
c2011 #call to see the name 
#plot the crop images
tgp1<-ggplot()+geom_raster(cn2021, mapping=aes(x=x, y=y, fill=LST.Error.Bar ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Temperature in january 2021")

tgp1



# How to esport map images
#png("NDVI 2019 difference.png")
#cldif <- colorRampPalette(c("blue","white","red"))(100)
#plot(difNDVI2019, col=cldif, main="Difference in NDVI - 2019")
#plot(coastlines, add=T)
#dev.off()
