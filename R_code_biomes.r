#install.packages("vegan")
#install.packages("sdm")
library(vegan) #for diversity analysis and other functions
library(sdm)#for developing species distribution models 
# Set the working directory
setwd("C:/lab/")  
load("biomes_multivar.RData") #load the file
ls() #see the store element in r
#we interest biomes and biomes_types 
biomes #to see the structure of the element
biomes_types #to see the type of biomes

#import per species matrix
multivar<-decorana(biomes) #decorana:Detrended Correspondence Analysis
multivar

plot(multivar) #plot the data

#grouping of species
attach(biomes_types)#used to access the variables present in the data framework without calling the data frame
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3) #ordiellipse draws lines or polygon s for ellipses by groups
ordispider(multivar, type, col=c("black","red","green","blue"), label=T) #draws a 'spider' diagram where each point is connected to the group centroid with segments 

pdf("multivar.pdf") #create the pdf
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3) 
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
dev.off()#close the pdf
