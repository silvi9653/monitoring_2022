#R code for estimating energy in ecosystems
#install.packeges("raster")
#set the library and working directory
library(raster)
setwd("C:/lab/")

#install rgdal library, for view the picture defor1_ and defor2_
#install.packages("rgdal")
library(rgdal)
#creat brick object
L1992<-brick("defor1_.png")
#to see the information of the file we use
L1992
#Bands: defor1_.1, defor1_.2, defor1_.3 
#plotRGB
#defor1_.1 =NIR, defor1_.2 =red, defor1_.3 =green
plotRGB(L1992,r=1, g=2, b=3, stretch="Lin")#NIR on red band
plotRGB(L1992,r=2, g=1, b=3, stretch="Lin")#NIR on green band
plotRGB(L1992,r=2, g=3, b=1, stretch="Lin")#NIR on blue band
 
L2006<-brick("defor2_.png")
