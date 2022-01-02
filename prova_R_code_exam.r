#This is the code for the final exam
#download images from copernicus program
#Soil Water Index - 10-daily SWI 12.5km Global V3
#I choose the first 10 days for each month in the 2021

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

list_rast<-lapply(rlist,brick) #plot the images
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

list_temp<-lapply(rlist_temp,brick) #plot the images
list_temp #view the information of the pictures

#make the stack, to have all of them togheter
temp<-stack(list_rast)
temp

#plot the images 
plot(temp, col=cl)

rlist_veg<- list.files(pattern="FCOVER") #create a list with a common pattern
rlist_veg

list_veg<-lapply(rlist_veg,brick) #plot the images
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

ext<-c(-50,0,-100,0) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
crop_2011<-crop(veg$X2011.02.03,ext) 
crop_2020<-crop(veg$X2020.02.03,ext) 
par(mfrow=c(2,1))
plot(crop_2011, col=cl)
plot(crop_2020, col=cl)
