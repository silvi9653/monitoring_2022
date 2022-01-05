#This is the code for the final exam
#download images from copernicus program
#Soil Water Index - daily SWI 12.5km Global V3
#I want to analyze how the vegetation prensence in the Amazonia forest condition the soilwater content and the temperature  

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
library(RStoolbox) 
library(ggplot2) 
library(patchwork)

#set the working directory
setwd("C:/lab/exam")

#import images of soilwater with lapply function
rlist<- list.files(pattern="SWI") #create a list with a common pattern
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
water2011<-crop(wsoil$Soil.Water.Index.with.T.5.1,ext) 
water2011<-crop(wsoil$Soil.Water.Index.with.T.5.2,ext) 
water2011 #call the object to see the name information
#plot the images with ggplot()
gp1<-ggplot()+geom_raster(water2011, mapping=aes(x=x, y=y, fill=Soil.Water.Index.with.T.5.1 ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2011")
gp2<-ggplot()+geom_raster(water2020, mapping=aes(x=x, y=y, fill=Soil.Water.Index.with.T.5.2))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2020")
#put one in top of the other
gp1/gp2

difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#create the color ramp palette
#yellow use for catch the eyes view 
waterdif<-water2011-water2011
plot(waterdif, col=difcl)#plotting the images

#upload the data of temperature
#single layer so we use a raster function
temp2011n<-raster("c_gls_LST_201101180100_GLOBE_GEO_V1.2.1.nc")
temp2011d<-raster("c_gls_LST_201101181300_GLOBE_GEO_V1.2.1.nc")
# now crop them in the Amazon Forest
ext<-c(-100,0,-50,20) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
cn2011<-crop(temp2011n,ext) 
cd2011<-crop(temp2011d,ext) 
cn2011 #call to see the name 
cd2011
#plot the crop images
tgp1<-ggplot()+geom_raster(cn2011, mapping=aes(x=x, y=y, fill=LST.Error.Bar ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Temperature at 1 am")
tgp2<-ggplot()+geom_raster(cd2011, mapping=aes(x=x, y=y, fill=LST.Error.Bar))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Temprature at 1 pm")
#put one images in top of the other
tgp1/tgp2
#calculate the gradient of temperature
temp2011<-cd2011-cn2011 #create the matematical relation
plot(temp2011, col=difcl)#plotting the images

#upload LAI data
LAI2014<-raster("c_gls_LAI300_201401100000_GLOBE_PROBAV_V1.0.1.nc")
LAI2020<-raster("c_gls_LAI300_202001100000_GLOBE_PROBAV_V1.0.1.nc")
ext<-c(-100,0,-50,20) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
cLAI2014<-crop(LAI2014,ext) 
cLAI2020<-crop(LAI2020,ext) 
cLAI2014 #call to see the name 
cLAI2020
#plot the crop images
LAIgp1<-ggplot()+geom_raster(cLAI2014, mapping=aes(x=x, y=y, fill=Leaf.Area.Index.333m  ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("LAI in 2014")
LAIgp2<-ggplot()+geom_raster(cLAI2020, mapping=aes(x=x, y=y, fill=Leaf.Area.Index.333m ))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("LAI in 2020")
#put one images in top of the other
LAIgp1/LAIgp2

LAIdif<-cLAI2014-cLAI2020
plot(LAIdif, col=difcl)#plotting the images
