

## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# source("readfile.r")

library(dplyr)

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

dataUrl<-"summarySCC_PM25.rds"

if(!file.exists(dataUrl)){
     download.file(fileUrl,"input.zip")
     unzip("input.zip")
}

NEI<-readRDS(dataUrl)

PM25byYear<-NEI%>% group_by(year)%>%dplyr::summarise(sum(Emissions))

names(PM25byYear)<-c("Year","Total.Emission")


plot(PM25byYear$Year,PM25byYear$Total.Emission,pch=19,cex=2,col="blue",
     xlab="Year",ylab="Total Emission (Tons)",
     main="PM2.5 Emission by Year in US")
fit<-lm(PM25byYear$Total.Emission~PM25byYear$Year)
abline(fit,lty=2,cex=2)

dev.copy(png,"plot1.png")
dev.off()
