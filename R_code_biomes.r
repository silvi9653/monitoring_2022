#install.packages("vegan")
#install.packages("sdm")
library(vegan)
library(sdm)
# Set the working directory
setwd("C:/lab/")  
load("biomes_multivar.RData") #load the file
ls() #see the store element in r
#we interest biomes and biomes_types 
biomes #to see the structure of the element
biomes_types #to see the type of biomes

#plot per species matrix
multivar<-decorana(biomes)
multivar

plot(multivar)

#grouping of species
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)

ordispider(multivar, type, col=c("black","red","green","blue"), label=T)
