

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

library(dplyr)

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

dataUrl<-"summarySCC_PM25.rds"

if(!file.exists(dataUrl)){
     download.file(fileUrl,"input.zip")
     unzip("input.zip")
}

NEI<-readRDS(dataUrl)


PM25byYearBultimore<-NEI%>% subset(fips == "24510") %>% group_by(year) %>% dplyr::summarise(sum(Emissions))

names(PM25byYearBultimore)<-c("Year","Total.Emission")


plot(PM25byYearBultimore$Year,PM25byYearBultimore$Total.Emission,pch=19,
     cex=2,col="blue",
     xlab="Year",ylab="Total Emission (Tons)",
     main="PM2.5 Emission by Year in Bultimore")

fit<-lm(PM25byYearBultimore$Total.Emission~PM25byYearBultimore$Year)

abline(fit,lty=2,cex=2)

dev.copy(png,"plot2.png")
dev.off()
