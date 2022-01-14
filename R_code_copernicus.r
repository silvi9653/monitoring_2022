#R code for uploading and visualizing copernicus data in R
#Use of copernicus data
#we download Cryosphere - Snow Cover Extent 1km v1 in data 14-12-2021
#https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
#install.packages("ncdf4")
#install.packages("raster")
#install.packages("viridis")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("patchwork")
library(ncdf4) #for import the copernicus file 
library(raster) #for work with raster file
library(viridis) # for plot the color palette
library(RStoolbox)#useful for remote sensing image processing
library(ggplot2) # for create graphics
library(patchwork) #for multiframe graphics
#set the working directory
setwd("C:/lab/copernicus")

#upload the data 
#single layer so we use a raster function
snow20211214<-raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
#to see how many layer are inside copernicus file
#snow20211214<-brick("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
#in this case it's sign 1 layer so we use raster function
snow20211214 #call the objects to see the information of the picture
#plot the image
plot(snow20211214)

#day2....
#make the color rampe palette
cl<-colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(snow20211214, col=cl) #assign color to the image and plot it

#use viridis packages for color palette also for colorblind people its nice 
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# here we use these functions library(viridis); library(RStoolbox); library(ggplot2)
#first create ggplot with geom_raster(x, mapping=aea(x=,y=,fill=))+scale_fill_viridis() for the raster images 
snow20211214 #fill name in the information of the picture: Snow.Cover.Extent
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent))#defoult color

ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+
scale_fill_viridis()#asign the defoult viridis palette

#change the palette
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+
scale_fill_viridis(option="cividis")#to change the different palette in viridis function

#use argument ggtitle("")
ggplot()+geom_raster(snow20211214, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent ))+
scale_fill_viridis(option="cividis")+ggtitle("cividis palette")

#day3....
#download another data in the coperincus site
#we download Cryosphere - Snow Cover Extent 1km v1 in data 29-08-2021
# snow20210829<-raster("c_gls_SCE_202108290000_NHEMI_VIIRS_V1.0.1.nc") #import the new picture

# instead import all data together with lapply function
rlist<- list.files(pattern="SCE") #create a list with a common pattern
#important! remamber list.file(pattern="")
rlist #call the object to verify if we do all right 

list_rast<-lapply(rlist,raster) #plot the images
list_rast #view the information of the pictures

#make the stack, to have all of them togheter
snow<-stack(list_rast)
snow #to see the name in the stack
#create a object for the two pictures
s_summer<-snow$Snow.Cover.Extent.1
s_winter<-snow$Snow.Cover.Extent.2

#use ggplot and patchwork function
#create the ggplot of the two images with viridis palette
gp1<-ggplot()+geom_raster(s_summer, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent.1))+
scale_fill_viridis()+ggtitle("Snow cover in August")

gp2<-ggplot()+geom_raster(s_winter, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent.2))+
scale_fill_viridis()+ggtitle("Snow cover in Dicember")

#see the two picture in a multiframe
gp1+gp2
#one in top of the other
gp1/gp2

#how to zoom in the our region
#see the range of coordinates in the pictures
#longitute from 0 to 20 
#latitude from 30 to 50
#using crop function
ext<-c(0,20,30,50) #create the extenction of coordiantes first
#crop use the stack and than extarct the images
stack_cropped<-crop(snow,ext) 
#insted we can do for the two picture separately
ssummer_cropped <- crop(s_summer, ext)
swinter_cropped <- crop(s_winter, ext)
#now create the ggplot
gp1<-ggplot()+geom_raster(ssummer_cropped, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent.1))+
scale_fill_viridis()+ggtitle("Snow cover in August in Italy")

gp2<-ggplot()+geom_raster(swinter_cropped, mapping=aes(x=x, y=y, fill=Snow.Cover.Extent.2))+
scale_fill_viridis()+ggtitle("Snow cover in Dicember in Italy")

#at last call it with patchwork
gp1+gp2
gp1/gp2 #one in top of the other






