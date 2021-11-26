#R code for chemical cycling study
#time series of NO2 change in Europe during the lockdown

#install.packeges("raster")
#set the library and working directory
library(raster)
setwd("C:/lab/EN/")

#import data -> brick function
#for several file use the raster function for create a single layer
# use the function raster()
EN01<- raster("EN_0001.png")

#what is the range of the data
EN01

#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 432, 768, 331776  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : EN_0001.png 
#names      : EN_0001 
#values     : 0, 255  (min, max) #8 bit file image resolution ->2^8=256 potential value

#plot the image
cl<- colorRampPalette(c("red","orange","yellow"))(100)
plot(EN01,col=cl)

#Exercise: import the last images the end of March No2 and plot it
EN013<- raster("EN_0013.png")
plot(EN013,col=cl)

#make a multiframe with 2 rows and 1 column
par(mfrow=c(2,1))
plot(EN01,col=cl)
plot(EN013,col=cl)

#import the other images
EN02<- raster("EN_0002.png")
EN03<- raster("EN_0003.png")
EN04<- raster("EN_0004.png")
EN05<- raster("EN_0005.png")
EN06<- raster("EN_0006.png")
EN07<- raster("EN_0007.png")
EN08<- raster("EN_0008.png")
EN09<- raster("EN_0009.png")
EN010<- raster("EN_0010.png")
EN011<- raster("EN_0011.png")
EN012<- raster("EN_0012.png")

