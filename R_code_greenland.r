#Ice melt in Greenland
#proxy:LST

#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("patchwork")
#install.packages("viridis")
library(raster) #for work with raster file
library(RStoolbox) #useful for remote sensing image processing
library(ggplot2) # for create graphics
library(patchwork) #for multiframe graphics
library(viridis)# for plot the color palette

#set the working directory
setwd("C:/lab/greenland")

#upload all the images with lapply
rlist<-list.files(pattern="lst")
rlist #see the elements of the list

#upload the images
list_rast<-lapply(rlist, raster) #raster because the images have single layer
list_rast #see the information of the images

#make the stack of the file
grl<-stack(list_rast)

#plot the images
#first create a color ramp palette
cl<-colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(grl, col=cl)#assign the color palette

#use ggplot with the package ggplot2 and RStoolbox
#create a ggplot of the first and final images 2000 vs. 2015 
#use palette of viridis function "magma"
gp1<-ggplot()+geom_raster(grl$lst_2000, mapping=aes(x=x, y=y, fill=lst_2000))+
scale_fill_viridis(option="magma")+ggtitle("LST in 2000")

gp2<-ggplot()+geom_raster(grl$lst_2015, mapping=aes(x=x, y=y, fill=lst_2015))+
scale_fill_viridis(option="magma")+ggtitle("LST in 2015")

#use the packages patchwork for create a multiframe with the two images
# gp1/gp2 one in top of the other
gp1+gp2 

#create a histogram
hist(grl$lst_2000) #general distribution 
hist(grl$lst_2015) #strange situation with two pics

#plot the frequency graphical representation in a multiframe
par(mfrow=c(1,2)) # (nrow,ncol)
hist(grl$lst_2000)
hist(grl$lst_2015)

#now do this for all the graphics
par(mfrow=c(2,2)) 
hist(grl$lst_2000)
hist(grl$lst_2005)
hist(grl$lst_2010)
hist(grl$lst_2015)

dev.off() #clear the divice
#see the distribution of value 
#first plot the two images 
plot(grl$lst_2010, grl$lst_2015)
#y=b*x+a  witch b=1 a=0
#use abline(a,b) function
abline(0,1,col="red")

#create a limit
plot(grl$lst_2010, grl$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
#the point upper the red line are the value in 2015 higer than 2010

# EXERCISE: make a plot with all the histograms and all regretion
par(mfrow=c(4,3))
hist(grl$lst_2000)
hist(grl$lst_2005)
hist(grl$lst_2010)
hist(grl$lst_2015)
plot(grl$lst_2010, grl$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(grl$lst_2010, grl$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000))
plot(grl$lst_2010, grl$lst_2000, xlim=c(12500,15000), ylim=c(12500,15000))
plot(grl$lst_2015, grl$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000))
plot(grl$lst_2015, grl$lst_2000, xlim=c(12500,15000), ylim=c(12500,15000))
plot(grl$lst_2005, grl$lst_2000, xlim=c(12500,15000), ylim=c(12500,15000))
#finish

#simple and faster way to do
#use th stack with the function pairs=create a scatterplot matrix
pairs(grl)



