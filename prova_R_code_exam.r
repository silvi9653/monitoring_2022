#This is the code for the final exam
#download images from copernicus program
#Soil Water Index - 10-daily SWI 12.5km Global V3
#I want to analyze who the vegetation condition the soilwater content and the temperature  

#import all the library 
#install.packages("ncdf4")
#install.packages("raster")
#install.packages("viridis")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("patchwork")
library(ncdf4)
library(raster)
library(viridis)
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

#plot the images of july
#first create a color ramp palette
cl<-colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(wsoil, col=cl)

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

rlist_veg1<- list.files(pattern="LAI") #create a list with a common pattern
rlist_veg1

list_veg1<-lapply(rlist_veg1,raster) #plot the images
list_veg1 #view the information of the pictures

#make the stack, to have all of them togheter
veg1<-stack(list_veg1)
veg1

rlist_veg2<- list.files(pattern="FCOVER") #create a list with a common pattern
rlist_veg2

list_veg2<-lapply(rlist_veg2,raster) #plot the images
list_veg2 #view the information of the pictures

#make the stack, to have all of them togheter
veg2<-stack(list_veg2)
veg2

rlist_veg3<- list.files(pattern="NDVI") #create a list with a common pattern
rlist_veg3

list_veg3<-lapply(rlist_veg3,raster) #plot the images
list_veg3 #view the information of the pictures

#make the stack, to have all of them togheter
veg3<-stack(list_veg3)
veg3

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
