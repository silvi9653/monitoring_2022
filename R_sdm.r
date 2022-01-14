# R code for species distribution modelling, namely the distribution of individuals of a population in space

# install.packages("sdm")
# install.packages("rgdal")

library(sdm)#for developing species distribution models
library(raster) #for work with raster file
library(rgdal) #Provides bindings to the 'Geospatial' Data Abstraction Library

#species data
file <- system.file("external/species.shp", package="sdm") #call directly the file
file #to see the path of the file

#import data
species <- shapefile(file) # as the raster function for raster files
species #to see information of the object
  #class       : SpatialPointsDataFrame 
  #features    : 200 
  #extent      : 110112, 606053, 4013700, 4275600  (xmin, xmax, ymin, ymax)
  #crs         : +proj=utm +zone=30 +datum=WGS84 +units=m +no_defs 
  #variables   : 1
  #names       : Occurrence 
  #min values  :          0 
  #max values  :          1 

species$Occurrence #to see the occurrence (1 and 0 value)
#how many occurrence are there? count all 1 value
#equal to something "=="
#different to something "!="
#subset the data
presences<-species[species$Occurrence==1,]
absences<-species[species$Occurrence==0,]

#plot the data
plot(species, pch=19) #pch in r to choose the icon to view the data

#plot the single subset
plot(presences, pch=19, col="blue") 
plot(absences, pch=19, col="red") 

#do a single plot of the two subset
#use points instead of plot for add the second subset
plot(presences, pch=19, col="blue") 
points(absences, pch=19, col="red") 

#look at the predictors
#first put the path
path<-system.file("external",package="sdm") #all raster file
path

lst<-list.files(path,pattern="asc", full.names=TRUE)#create a listfile in the folder
#create the stack 
preds<-stack(lst)
#create the color palette 
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
#plot all the prediction
plot(preds, col=cl) 

plot(preds$elevation, col=cl) #plot only the elevation
points(presences,pch=19) #add the presence data in the elevation images

plot(preds$temperature, col=cl) #plot only the temperature
points(presences,pch=19)

plot(preds$vegetation, col=cl) #plot only the vegetation
points(presences,pch=19)

#day2.............
#importing the source script
setwd("C:/lab/")
#source() the file
source("R_code_source_sdm.r")

#call the stack create before
preds
#explain to the model what we training and predictors data
datasdm<-sdmData(train=species, predictors=preds)
#call the objects to see the table
datasdm
#create the model
m1<-sdm(formula=Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm,methods="glm")
#create the prediction map 
#make the function assign the model m1 and the data preds
p1<-predict(m1, newdata=preds)
p1 #raster layer
#plot the final prediction
plot(p1,col=cl)
points(presences,pch=19)#put the precences on top of the images

#create the final stack of preds and the prediction map
s1<-stack(preds,p1)
#plot the stack so we have all together
plot(s1, col=cl)
#change the name of the maps
names(s1)<-c("elevation","precipitaion","temperature","vegetation","model")

