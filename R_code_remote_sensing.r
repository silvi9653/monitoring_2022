# R code for ecosystem monitoring by remote sensing
# first of all, install a new packages
# raster packages to manage: https://cran.r-project.org/web/packages/raster/index.html
# install.packages("arg1,arg2")

install.packages("raster")

# for use the packages use function: library()
library(raster)
#set working directory
setwd("C:/lab/")
#we are going to import satellite data 
#create a brick object 
L2011<-brick("p224r63_2011.grd")
L2011
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : p224r63_2011.grd 
#names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
#min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
#max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 

plot(L2011)
#B1 is the reflectance in the blue band
#B2 is the reflectance in the green band
#B3 is the reflectance in the red band
#change color palette; (c)=array; (numer)= toness of the palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(L2011,col=cl)
#assign rgb color
plotRGB(L2011, r=3, g=2, b=1, stretch="Lin")

#....day2 
#B1 is the reflectance in the blue band
#B2 is the reflectance in the green band
#B3 is the reflectance in the red band
#B4 is the reflectance in the NIR band

#plot the single band by name B2_sre (spectro reflection)
plot(L2011$B2_sre)

cl<- colorRampPalette(c("black","grey","light grey"))(100)
plot(L2011$B2_sre, col=cl)

#change the colorRampPalette with dark green and light green, e.g. clg
clg<- colorRampPalette(c("dark green","green","light green"))(100)
plot(L2011$B2_sre, col=clg)

#do the same with blue band
clb<- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(L2011$B1_sre, col=clb)

#chain two images in multiframe graph
par(mfrow=c(1,2)) #the first number is the namer of the row in the multiframe the second number of column
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)

#chain two images in multiframe graph two rows and one column
par(mfrow=c(2,1))
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)

#dev.off() to clean the workspace on R

# day 3.....

plot(L2011$B1_sre)
#assign the color in the blue band
clb<- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(L2011$B1_sre, col=clb)    

#chain two images in multiframe graph
par(mfrow=c(1,2)) #the first number is the namer of the row in the multiframe the second number of column
plot(L2011$B1_sre, col=clb)
clg<- colorRampPalette(c("dark green","green","light green"))(100)
plot(L2011$B2_sre, col=clg)

# Exercise: invert the number of rows and the colomn
par(mfrow=c(2,1))
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)

# Exercise: plot the first four band with two rows and two colums
par(mfrow=c(2,2))
plot(L2011$B1_sre, col=clb)
plot(L2011$B2_sre, col=clg)
clr<- colorRampPalette(c("dark red","red","pink"))(100) #light red not exist we usde pink instead
plot(L2011$B3_sre, col=clr)
clNIR<- colorRampPalette(c("red","orange","yellow"))(100) #color for NIR
plot(L2011$B4_sre, col=clNIR)

dev.off()
#RGB setting
plotRGB(L2011,r=3, g=2, b=1, stretch="Lin")#linear stretch, the number in the function is for the 3 band  

#use NIR band, witch the vegetation reflect a lot
plotRGB(L2011,r=4, g=3, b=2, stretch="Lin") # we have exclude the blue band and transfert the other band

#change the channel to plot the NIR band
plotRGB(L2011,r=3, g=4, b=2, stretch="Lin") # we can see change of humidity inside the forest
plotRGB(L2011,r=3, g=2, b=4, stretch="Lin") # yellow part cutted forest

# multiframe
par(mfrow=c(2,2))
plotRGB(L2011,r=3, g=2, b=1, stretch="Lin")
plotRGB(L2011,r=4, g=3, b=2, stretch="Lin")#false color
plotRGB(L2011,r=3, g=4, b=2, stretch="Lin") #false color
plotRGB(L2011,r=3, g=2, b=4, stretch="Lin")#false color

#day 4......final day on this topic forest reserve

#RGB stretch
plotRGB(L2011,r=3, g=2, b=1, stretch="Lin")
plotRGB(L2011,r=3, g=2, b=1, stretch="Hist") # stretching the value so there are more evidence the difference

#create a brick object 
L1988<-brick("p224r63_1988.grd")
L1988
#use multiframe to see 1988 and 2011 picture
par(mfrow=c(2,1))
plotRGB(L1988,r=3, g=2, b=1, stretch="Lin")
plotRGB(L2011,r=3, g=2, b=1, stretch="Lin")
#put the NIR in  blue channel
par(mfrow=c(2,1))
plotRGB(L1988,r=3, g=2, b=4, stretch="Lin")
plotRGB(L2011,r=3, g=2, b=4, stretch="Lin")
  
  
  
