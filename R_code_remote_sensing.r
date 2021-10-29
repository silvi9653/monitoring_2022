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
