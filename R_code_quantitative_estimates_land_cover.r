#R_code_quantitative_estimates_land_cover
#install new packages
#install.packages("raster")
#install.packages("RStoolbox") 
#install.packages("ggplot2")
#install.packages("gridExtra")
#install.packages("patchwork")
library(RStoolbox) #we use this packeges for classification
library(ggplot2) #we use this packeges for the graph 
library(gridExtra)# we use this packeges for sum of graph
library(patchwork)# we use this instead of gridExtra
#call library raster and set the working directory
library(raster)#for work with raster file
setwd("C:/lab/")
#use lapplay for import two images
# first create a list the files available
rlist<-list.files(pattern="defor") #pattern the common name of the element we want to import
rlist #to see the component of the object
#second import the images togheter with lapplay
list_rast<-lapply(rlist,brick)
list_rast #to see the information of the images
#plot the first image
plot(list_rast[[1]])
#plot RGB first image
#defor: NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=2, b=3) #NIR is the first band we put it in red componement
#assign a simple name 
l1992<-list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
#do the same thing with the second picture
l2006<-list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

#here we use library(RStollbox)
#unsupervised classification: to classified the pixel to the type of ground
l1992c<-unsuperClass(l1992, nClasses=2)
l1992c
plot(l1992c$map)#plot the image
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
#prop1992<-c(0.89659, 0.10341) insted of using number below we use the objects
prop1992<-c(propforest, propagri)
#create the data frame
proportion1992<-data.frame(cover,prop1992)
#to see the table
proportion1992

#here we use library(ggplot2)
#create ggplot(percentages, aesthetics (x=*name of first column* , y=*name of second column*, color=))
#different kind of ggplot, we use geom_bar (bar charts)
ggplot(proportion1992, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity",fill="white")

#day2........
#repete the all code for the second picture
l2006c<-unsuperClass(l2006, nClasses=2)
l2006c
plot(l2006c$map)#plot the images
#value 1 = agricoultural areas and water
#value2 = forest
#use function freq function
freq(l2006c$map)
# number of pixel of 1 178671
# number of pixel of 2 164055
# total of pixel 342726 
#propotion
propagri_2006<-164055/342726 
propforest_2006<-178671/342726 
# agricolture wather :  0.4786768 = 48%
# forest: 0.5213232 = 52%
#build data frame
cover<-c("Forest","Agriculture")
prop1992<-c(propforest, propagri) #recall for simple view
prop2006<-c(propforest_2006, propagri_2006)
#create the data frame
proportion<-data.frame(cover,prop1992, prop2006)
#to see the table
proportion

#create ggplot 
#different kind of ggplot, we use geom_bar (bar charts)
p1<-ggplot(proportion, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1) # graph 1992
p2<-ggplot(proportion, aes(x=cover, y= prop2006, color= cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1) #graph 2006

#here we use library(gridExtra)
grid.arrange(p1,p2,nrow=1)
#important error not put nrows 's' rapresent an additional object so the function don't work

#day3.....
#if grid.arrange not work
#new packages patchwork
#install.packages("patchwork")
#here we use library(patchwork)
#call two ggplot
p1<-ggplot(proportion, aes(x=cover, y= prop1992, color= cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1) # graph 1992
p2<-ggplot(proportion, aes(x=cover, y= prop2006, color= cover)) + geom_bar(stat="identity",fill="white") + ylim(0,1) #graph 2006
#create the multiframe
p1+p2
#if one graph in top of the other
p1/p2
#patchwork is working even with raster data 
l1992 #call the data to see if we have in the memory
#instead of using plotRGB we are going to use ggRGB
plotRGB(l1992, r=1,g=2,b=3, stretch="Lin")#call to see the prevous function
ggRGB(l1992, r=1,g=2,b=3) #set a standard coordinate in the axes
#play with stretch in ggRGB
ggRGB(l1992, r=1,g=2,b=3, stretch="lin")
ggRGB(l1992, r=1,g=2,b=3, stretch="hist")
ggRGB(l1992, r=1,g=2,b=3, stretch="sqrt")#compact the data
ggRGB(l1992, r=1,g=2,b=3, stretch="log")#natural logarithm

#assaign the object
gp1<-ggRGB(l1992, r=1,g=2,b=3, stretch="lin")
gp2<-ggRGB(l1992, r=1,g=2,b=3, stretch="hist")
gp3<-gp1<-ggRGB(l1992, r=1,g=2,b=3, stretch="sqrt")
gp4<-ggRGB(l1992, r=1,g=2,b=3, stretch="log")
#patchwork in a multiframe
gp1+gp2+gp3+gp4
#multitemporal patchwork
#plot the two images
gp1<-ggRGB(l1992, r=1,g=2,b=3)
gp5<-ggRGB(l2006, r=1,g=2,b=3)
#patchwork in a multiframe
gp1+gp5 
gp1/gp5 #one on top of the other

