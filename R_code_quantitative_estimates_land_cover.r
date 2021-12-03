#R_code_quantitative_estimates_land_cover
#install new packages
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")
library(RStoolbox)
library(ggplot2)
#call library raster and set the working directory
library(raster)
setwd("C:/lab/")
#use lapplay for import due images
# first create a list the files available
rlist<-list.files(pattern="defor")
rlist #to see the component of the object
#second import the images togheter with lapplay
list_rast<-lapply(rlist,brick)
list_rast #to see the information of the images
#plot the first images
plot(list_rast[[1]])
#plot RGB first images
#defor: NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=2, b=3) #NIR is teh first band we put it in red componement
#assign a simple name 
l1992<-list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3)
#do the same thing with the second picture
l2006<-list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3)

#library(RStollbox)
#unsupervised classification
l1992c<-unsuperClass(l1992, nClasses=2)
l1992c
plot(l1992c$map)#plot the images
#how many pixel is forest or agricoltural in my map
#value 1 = agricoultural areas and water
#value2 = forest
#use function freq function
freq(l1992c$map)
# number of pixel of 1  35293
# number of pixel of 2 305999
# total of pixel 341292
#propotion
propagri<-35293/341292
propforest<-305999/341292
# agricolture wather : 0.10341 = 10%
# forest: 0.89659 = 90%
#build data frame
cover<-c("Forest","Agriculture")
prop1992<-c(0.89659, 0.10341)
#create the data frame
proportion1992<-data.frame(cover,prop1992)
#to see the table
proportion1992

#library(ggplot2)
#create ggplot(percentages, aesthetics (x=*name of first column* , y=*name of second column*, color=))
#different kind of ggplot, we use geom_bar (bar charts)
ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity",fill="white")
