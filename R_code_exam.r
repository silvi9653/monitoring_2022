#This is the code for the final exam
#I want to analyze how the vegetation in the Amazonia forest condition the soilwater content.
#I compare four month since november 2009 till march 2010 and the same in 2019-2020
#download images from copernicus program
#Soil Water Index - daily SWI 12.5km Global V3
#FCOVER -  1km V2

# install and import all the library 
#install.packages("ncdf4")
#install.packages("raster")
#install.packages("viridis")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("patchwork")
#install.packages("rgdal")
library(ncdf4) #for import the copernicus file 
library(raster) #for work with raster file
library(viridis) # for plot the color palette
library(RStoolbox) #useful for remote sensing image processing 
library(ggplot2)  # for create graphics 
library(patchwork) #for multiframe graphics
library(rgdal) #use to open shape file
#set the working directory
setwd("C:/lab/exam")

#first I try to see if I can use water soil index- 10 daily data but there isn't a difference 
#import water soil images all togheter with lapply function
#first create a list with a common pattern
#rlist<- list.files(pattern="SWI10") 
#rlist #check if we have all the images import right 
#use lapply finction to import like raster images
#list_rast<-lapply(rlist,raster) 
#list_rast #view the information of the images
#take only the image for soil water index
#make the stack, to have all of them togheter
#wsoil<-stack(list_rast)
#wsoil #call the see the names
#change the names of the images
#names(wsoil)<- c("November2009", "Dicember2009", "January2010","February2010","March2010","November2019", "Dicember2019","January2020", "February2020", "March2020")
#create a palette first
#cl<- colorRampPalette(c("darkblue","blue","lightblue"))(100)
#plot the images and assign the color
#plot(wsoil, col=cl)
#i want to see the images from january 2010 and january 2020
#extraxt them from the stack
#jan2010<-(wsoil$January2010)
#jan2020<-(wsoil$January2020)
# now crop them in the Amazonian Forest
#ext<-c(-90,-30,-20,10) #create the extenction of coordiantes first (x,y)
#crop use the extarct images
#water2010<-crop(jan2010,ext) 
#water2020<-crop(jan2020,ext)
#plot the images with ggplot()
#gp1<-ggplot()+geom_raster(water2010, mapping=aes(x=x, y=y, fill=January2010))+
#scale_fill_viridis()+#asign the defoult viridis palette
#ggtitle("Soil water 2010")
#gp2<-ggplot()+geom_raster(water2020, mapping=aes(x=x, y=y, fill=January2020))+
#scale_fill_viridis()+#asign the defoult viridis palette
#ggtitle("Soil water 2020")
#put one in top of the other
#gp1/gp2
#I want to see if there is a difference in this two period
#difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#create the color ramp palette
#Wdif<-water2010-water2020 #make the difference
#plot(Wdif, col=difcl)#plotting the images


######
#I try daily data 
#import water soil images all togheter with lapply function
#first create a list with a common pattern
rlist<- list.files(pattern="SWI") 
rlist #check if we have all the images import right 

#use lapply finction to import like raster images
list_rast<-lapply(rlist,raster) 
list_rast #view the information of the images

#take only the image for soil water index
#make the stack, to have all of them togheter
wsoil<-stack(list_rast)
wsoil #call the see the names

#change the names of the images
names(wsoil)<- c("November2009",
                 "Dicember2009",
                 "January2010",
                 "February2010",
                 "March2010",
                 "November2019",
                 "Dicember2019",
                 "January2020",
                 "February2020",
                 "March2020")
#create a palette first
cl<- colorRampPalette(c("darkblue","blue","lightblue"))(100)
#plot the images and assign the color
plot(wsoil, col=cl)
#i want to see the images from january 2010 and january 2020
#extraxt them from the stack
jan2010<-(wsoil$January2010)
jan2020<-(wsoil$January2020)
# now crop them in the Amazon Forest
ext<-c(-90,-30,-20,10) #create the extenction of coordiantes first (x,y)
#crop use the extarct images
w_jan_2010<-crop(jan2010,ext) 
w_jan_2020<-crop(jan2020,ext) 
w_jan_2010 #call the object to see the name information
w_jan_2020 #call the object to see the name information

#plot the images with ggplot()
gp1<-ggplot()+geom_raster(w_jan_2010, mapping=aes(x=x, y=y, fill=January2010))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2010")
gp2<-ggplot()+geom_raster(w_jan_2020, mapping=aes(x=x, y=y, fill=January2020))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2020")
#put one in top of the other
gp1/gp2

#I want to see if there is a difference in this two period
difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#create the color ramp palette
Wdif<-w_jan_2010-w_jan_2020 #make the difference
plot(Wdif, col=difcl)#plotting the images

# Now I export the images
png("wsoil.png") #assign name
cl<- colorRampPalette(c("darkblue","blue","lightblue"))(100) #call the color palette
plot(wsoil, col=cl)
dev.off()#close the procedure

# Now I export the images
png("Soil_water_jan_10_20.png") #assign name
gp1<-ggplot()+geom_raster(w_jan_2010, mapping=aes(x=x, y=y, fill=January2010))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2010")
gp2<-ggplot()+geom_raster(w_jan_2020, mapping=aes(x=x, y=y, fill=January2020))+
scale_fill_viridis()+#asign the defoult viridis palette
ggtitle("Soil water 2020")
#put one in top of the other
gp1/gp2
dev.off()#close the procedure

#I export also difference image
png("dif_jan_water_10_20.png") #assign name
difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#call the color ramp palette
plot(Wdif, col=difcl)#plotting the images
dev.off()#close the procedure

#create a histogram for a better analisy
hist(w_jan_2010)
#now I crop the other image
w_nov_2009<-crop(wsoil$November2009,ext) 
w_dic_2009<-crop(wsoil$Dicember2009,ext) 
w_feb_2010<-crop(wsoil$February2010,ext) 
w_mar_2010<-crop(wsoil$March2010,ext) 
w_nov_2019<-crop(wsoil$November2019,ext) 
w_dic_2019<-crop(wsoil$Dicember2019,ext) 
w_feb_2020<-crop(wsoil$February2020,ext) 
w_mar_2020<-crop(wsoil$March2020,ext) 
#now see all Histogram in one multiframe
par(mfrow=c(4,3)) #use the par function (nrow,ncol)
hist(w_nov_2009)
hist(w_nov_2019)
hist(w_dic_2009)
hist(w_dic_2019)
hist(w_jan_2010)
hist(w_jan_2020)
hist(w_feb_2010)
hist(w_feb_2020)
hist(w_mar_2010)
hist(w_mar_2020)

dev.off() #clear the divice

#Now I import FCOVER images with raster function
FCOVER2010<-raster("c_gls_FCOVER_201001100000_GLOBE_VGT_V2.0.1.nc")
FCOVER2020<-raster("c_gls_FCOVER-RT6_202001100000_GLOBE_PROBAV_V2.0.1.nc")

#now crop them in the Amazonian Forest 
#with ext cordinate that I create before
ext<-c(-90,-30,-20,10)
cFC2010<-crop(FCOVER2010,ext) 
cFC2020<-crop(FCOVER2020,ext) 
cFC2010 #call to see the name 
cFC2020
#plot the crop images
Veg1<-ggplot()+geom_raster(cFC2010, mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km ))+
scale_fill_viridis(option="magma")+#assign the magma color in viridis palette
ggtitle("FCover winter in 2010")
Veg2<-ggplot()+geom_raster(cFC2020, mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km ))+
scale_fill_viridis(option="magma")+#assign the magma color in viridis palette
ggtitle("FCover winter in 2020")
#put one images in top of the other
Veg1/Veg2

#I want to see if there is a difference in this two period
FCdif<-cFC2010-cFC2020 #make the difference
plot(FCdif, col=difcl)#plotting the images use the same color palette, I use before


# Now I export the images
png("Fcover_winter_10_20.png") #assign name
Veg1<-ggplot()+geom_raster(cFC2010, mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km ))+
scale_fill_viridis(option="magma")+#assign the magma color in viridis palette
ggtitle("FCover in winter 2010")
Veg2<-ggplot()+geom_raster(cFC2020, mapping=aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km ))+
scale_fill_viridis(option="magma")+#assign the magma color in viridis palette
ggtitle("FCover winter  in 2020")
#put one images in top of the other
Veg1/Veg2
dev.off()#close the procedure

png("dif_Fcover_winter_10_20.png") #assign name
difcl<-colorRampPalette(c("darkblue","yellow","red","black"))(100)#call the color ramp palette
plot(FCdif, col=difcl)#plotting the images
dev.off()#close the procedure


#at the end I want analyze data from http://terrabrasilis.dpi.inpe.br/en/home-page/ to see the actual deforestation rate nowadays
#first I import with readOGR the bounderies of the Amazonian biomes
biome<- readOGR("biome.shp")
plot(biomes)
fb<-fortify(biome) #for change shapefile into a file to use with ggplot
#plot with ggplot function, group for correct the polygon
gbiome<-ggplot()+geom_polygon(data=fb,aes(x=long, y=lat, group=group))+theme_bw()
#now change graphics
gbiome<-ggplot()+geom_polygon(data=fb,aes(x=long, y=lat, group=group),fill=" ",color="black",lwd=1)+theme_bw()

#I import also the actual deforestation rate in 2021
defo21<- readOGR("yearly_deforestation_2021_pri.shp")
plot(defo21)
#now I export the images
png("defo2021.png")
plot(defo21)
dev.off()#close the procedure
#try to put all together
#plot all the data together
#ggplot()+geom_polygon(data=fb,aes(x=long, y=lat, group=group),fill="green ",color="black",lwd=1)+theme_bw()
#points(defo21)
#now I export the images
#png("dif_Fcover_winter_10_20.png") #assign name
#ggplot()+geom_polygon(data=fb,aes(x=long, y=lat, group=group),fill="green ",color="black",lwd=1)+theme_bw()
#points(defo21)
#dev.off()#close the procedure

#also I anlyze all the time serie of deferestation since 2008 to 2020
#import the file
shape<- readOGR("yearly_deforestation_biome.shp")
shape# to see the information of the object
#create a table with year and area km deforested 
tb1<- table(shape$area_km,shape$year)
#create a barplot to see the changes
barplot(tb1,
        xlab="year",
        ylab="km lost", 
        name.arg=c("2008",
                   "2009",
                   "2010",
                   "2011",
                   "2012",
                   "2013",
                   "2014",
                   "2015",
                   "2016",
                   "2017",
                   "2018",
                   "2019",
                   "2020"),
        main="Deforestation",
        xlim=c(0,16))
#export the graph
png("deforestation_08_20.png", width = 1800, height = 1800, res = 300)
barplot(tb1,
        xlab="year",
        ylab="km lost", 
        name.arg=c("2008",
                   "2009",
                   "2010",
                   "2011",
                   "2012",
                   "2013",
                   "2014",
                   "2015",
                   "2016",
                   "2017",
                   "2018",
                   "2019",
                   "2020"),
        main="Deforestation",
        xlim=c(0,16))
dev.off()#close the procedure

#end of the program



