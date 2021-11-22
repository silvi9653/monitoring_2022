#R code for estimating energy in ecosystems
#install.packeges("raster")
#set the library and working directory
library(raster)
setwd("C:/lab/")

#install rgdal library, for view the picture defor1_ and defor2_
#install.packages("rgdal")
library(rgdal)
#creat brick object for import picture
L1992<-brick("defor1_.png")
#to see the information of the file we use
L1992
#Bands: defor1_.1, defor1_.2, defor1_.3 
#plotRGB the picture
#defor1_.1 =NIR, defor1_.2 =red, defor1_.3 =green
plotRGB(L1992,r=1, g=2, b=3, stretch="Lin")#NIR on red band
plotRGB(L1992,r=2, g=1, b=3, stretch="Lin")#NIR on green band
plotRGB(L1992,r=2, g=3, b=1, stretch="Lin")#NIR on blue band

#day 2............
L2006<-brick("defor2_.png")# import second picture from 2006 
L2006
plotRGB(L2006, r=1, g=2, b=3,  stretch="Lin")#plotting the file
#use par function 
par(mfrow=c(2,1))#create the multiframe
#plot the two picture
plotRGB(L1992,r=1, g=2, b=3, stretch="Lin")
plotRGB(L2006, r=1, g=2, b=3,  stretch="Lin")

dev.off()

#DVI high value for forest pixel and low value for not vegeteted pixel
#calculation of energy in 1992
dvi1992<-L1992$defor1_.1-L1992$defor1_.2 #create the matematical relation
dvicl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#create the color ramp palette
#yellow use for catch the eyes view 
plot(dvi1992, col=dvicl)#plotting the images

#calculation of energy in 2006
dvi2006<-L2006$defor2_.1-L2006$defor2_.2 #create the matematical relation
plot(dvi2006, col=dvicl)#plotting the images

#create the multiframe
par(mfrow=c(2,1))
#plot the two picture
plot(dvi1992, col=dvicl)
plot(dvi2006, col=dvicl)

#differencing two images of energy in two different time
dvidif<-dvi1992-dvi2006 #create the object
difcl<-colorRampPalette(c("blue","white","red"))(100) #create the color ramp palette
#plot the images
plot(dvidif, col=difcl)


