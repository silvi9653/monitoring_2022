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

#import all the images with lapply function
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
water2020<-crop(wsoil$Soil.Water.Index.with.T.5.2,ext) 
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


#import all the images with lapply function
rlist_temp<- list.files(pattern="LST") #create a list with a common pattern
rlist_temp

list_temp<-lapply(rlist_temp,raster) #plot the images
list_temp #view the information of the pictures

#make the stack, to have all of them togheter
temp<-stack(list_rast)
temp

#plot the images 
plot(temp, col=cl)

rlist_veg<- list.files(pattern="LAI300") #create a list with a common pattern
rlist_veg

list_veg<-lapply(rlist_veg,raster) #plot the images
list_veg #view the information of the pictures

#make the stack, to have all of them togheter
veg<-stack(list_veg)
veg

#plot the images 
plot(veg, col=cl)

par(mfrow=c(4,4))
plot(wsoil, col=cl)
plot(temp, col=cl)
plot(veg, col=cl)

ext<-c(-50,20,-100,0) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
crop_2011<-crop(wsoil$X2011.01.18,ext) 
crop_2020<-crop(veg$X2020.02.03,ext) 
par(mfrow=c(2,1))
plot(crop_2011, col=cl)
plot(crop_2020, col=cl)

ggplot()+geom_raster(wsoil, mapping=aes(x=x, y=y, fill=X2011.01.18))+
scale_fill_viridis()#asign the defoult viridis palette

gp1<-ggplot()+geom_raster(veg, mapping=aes(x=x, y=y, fill=X2019.01.24 ))+
scale_fill_viridis()#asign the defoult viridis palette
gp2<-ggplot()+geom_raster(veg, mapping=aes(x=x, y=y, fill=X2020.01.24 ))+
scale_fill_viridis()#asign the defoult viridis palette
gp1/gp2
