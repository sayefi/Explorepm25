

## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?


library(dplyr)
library(ggplot2)

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

dataUrl1<-"summarySCC_PM25.rds"
dataUrl2<-"Source_Classification_Code.rds"

if(!file.exists(dataUrl1)|!file.exists(dataUrl2)){
     download.file(fileUrl,"input.zip")
     unzip("input.zip")
}

NEI<-readRDS(dataUrl1)
SCC<-readRDS(dataUrl2)


# MotorScc<-SCC[SCC$Data.Category=="Onroad","SCC"]
# MotorScc

MotorScc<-SCC[grep("Veh",SCC$Short.Name),]

NEI<-subset(NEI, fips=="24510"|fips=="06037")

NEI<-subset(NEI, SCC %in% MotorScc$SCC )

NEI<-mutate(NEI, area=ifelse(fips=="24510","Baltimore","Los Angeles"))

# NEIBultimore<-subset(NEI,area=="Bultimore")
# NEILos<-subset(NEI,area=="Los Angeles")

# par(mfrow=c(1,2))
# 
# plot(NEIBultimore$year,log(NEIBultimore$Emissions),ylim=c(-15,10))
# fit1<-lm(log(NEIBultimore$Emissions)~NEIBultimore$year)
# abline(fit1)
# 
# plot(NEILos$year,log(NEILos$Emissions),ylim=c(-15,10))
# fit2<-lm(log(NEILos$Emissions)~NEILos$year)
# abline(fit2)
# 
# 
# dev.copy(png,"plot61.png")
# 
# dev.off()
# 
# g<- ggplot(NEI, aes(x=year,y=log(Emissions)))
# g<- g+geom_point(aes(group=area,fill=area,colour=area, size=3), alpha=0.20)
# g<- g+facet_grid(.~area)
# # g<-g+geom_density(aes(group=year,fill=year),alpha=0.50)
# g<-g+geom_smooth(method="lm")
# g<-g+ggtitle("Motor vehicle related emissions in Bultimore city and Log Angeles, 1999-2008")
# #g<-g+scale_fill_gradient("year", low="red", high="green")
# print(g)
# 
# dev.copy(png,"plot62.png")
# 
# dev.off()

g<- ggplot(NEI, aes(x=year,y=log(Emissions)))
g<- g+geom_point(aes(group=area,fill=area,colour=area, size=2), alpha=0.10)
# g<- g+facet_grid(.~area)
# g<-g+geom_density(aes(group=year,fill=year),alpha=0.50)
g<-g+geom_smooth(aes(group=area,colour=area),linetype="dashed" ,method="lm")
g<-g+ggtitle("Motor vehicle related emissions in Baltimore city and Log Angeles, 1999-2008")
#g<-g+scale_fill_gradient("year", low="red", high="green")
print(g)

dev.copy(png,"plot6.png")

dev.off()










