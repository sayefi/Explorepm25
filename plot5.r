

## How have emissions from motor vehicle sources changed from 1999–2008 
## in Baltimore City?

source("readfile.r")

library(dplyr)

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

NEIBultimore<-subset(NEI, fips=="24510")

NEIBultimoreMotor<-subset(NEIBultimore,SCC %in% MotorScc$SCC)

NEIBultimoreMotor

# t<-MotorScc[MotorScc$Data.Category!="Onroad",]
# 
# summary(MotorScc)
# 
# unique(MotorScc$Data.Category)
# 
# NEIMotor<-NEI[NEI$SCC %in% MotorScc,]
# 
# NEIMotor

plot(NEIBultimoreMotor$year,log(NEIBultimoreMotor$Emissions),col=rgb(1,0,0,.2),cex=2,pch=19,
     xlab="Year",ylab="Emissions in Log scale")

fit<-lm(log(NEIBultimoreMotor$Emissions)~NEIBultimoreMotor$year)
abline(fit,col="blue",lty=5)
title("Motor vehicle related emissions in Bultimore city")

# MotorSccFlag<-grep("Coal$",SCC$EI.Sector)
# 
# CoalSccNo<-SCC[SccCoalFlag,1]




g<- ggplot(NEIBultimoreMotor, aes(x=log(Emissions)))
g<-g+geom_density(aes(group=year,fill=year),alpha=0.50)
g<-g+ggtitle("Motor vehicle related emissions in Bultimore city")
g<-g+scale_fill_gradient("year", low="red", high="green")
print(g)

dev.copy(png,"plot5.png")

dev.off()







