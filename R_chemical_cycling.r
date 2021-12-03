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

#plot the image and assign a color palette
cl<- colorRampPalette(c("red","orange","yellow"))(100)
plot(EN01,col=cl)

#Exercise: import the last images the end of March No2 and plot it
EN13<- raster("EN_0013.png")
plot(EN13,col=cl)

#make a multiframe with 2 rows and 1 column
par(mfrow=c(2,1))
plot(EN01,col=cl)
plot(EN13,col=cl)

#import the other images
EN02<- raster("EN_0002.png")
EN03<- raster("EN_0003.png")
EN04<- raster("EN_0004.png")
EN05<- raster("EN_0005.png")
EN06<- raster("EN_0006.png")
EN07<- raster("EN_0007.png")
EN08<- raster("EN_0008.png")
EN09<- raster("EN_0009.png")
EN10<- raster("EN_0010.png")
EN11<- raster("EN_0011.png")
EN12<- raster("EN_0012.png")

# use par (multiframe) for plotting images
par(mfrow=c(4,4))
plot(EN01,col=cl)
plot(EN02,col=cl)
plot(EN03,col=cl)
plot(EN04,col=cl)
plot(EN05,col=cl)
plot(EN06,col=cl)
plot(EN07,col=cl)
plot(EN08,col=cl)
plot(EN09,col=cl)
plot(EN10,col=cl)
plot(EN11,col=cl)
plot(EN12,col=cl)
plot(EN13,col=cl)
#not use this way, it's very long

# otherwise for plotting the images in one shot
# use stack function
#put the all images in a raster stack
EN<-stack(EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)
#plot the stack all togheter
plot(EN,col=cl)

#plot the first image of the stack
EN #to see the name of the first image in stack object
plot(EN$EN_0001,col=cl)

#rgb space 
plotRGB(EN,r=1, g=7, b=13, stretch="Lin")#put the number of the images january, february and march 
#yellow - white componement always present for agricoltural activity in pianura padana 


#day2......
# import the data in one shot use function lapply
#create a list
#list.file function required the path"."; we can ommit that with setwd
rlist <- list.files(pattern = "EN")
rlist
#apply the lapply function
list_rast <- lapply(rlist, raster)
list_rast
#use the stack for set all data in raster
EN_stack<- stack(list_rast)
EN_stack
#plot them toghether 
plot(EN_stack,col=cl)

#Exercise plot only the first image of stack
plot(EN_stack$EN_0001,col=cl)

#difference between the first and the last images
cldif<-colorRampPalette(c("blue","white","red"))(100)#create color ramp palette
plot(EN_stack$EN_0001-EN_stack$EN_0013,col=cldif)#plot the new image

#out of topic part
#automated source function #for run the code in R immidiatly
#create a text file with the program and save in the EN folder (extension ".r")
dev.off()#for clean the window in r
#import the program without copy-paste
source("automatic_source_import.r")
#the final images pop-up
#finish out of topic

