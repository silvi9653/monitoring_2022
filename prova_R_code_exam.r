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
rlist<- list.files(pattern="SWI10") #create a list with a common pattern
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

