

## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source("readfile.r")

library(dplyr)


NEI<-readfile("NEI")

PM25byYear<-NEI%>% group_by(year)%>%dplyr::summarise(sum(Emissions))

names(PM25byYear)<-c("Year","Total.Emission")


plot(PM25byYear$Year,PM25byYear$Total.Emission,pch=19,cex=2,col="blue",
     xlab="Year",ylab="Total Emission (Tons)",
     main="PM2.5 Emission by Year in US")
fit<-lm(PM25byYear$Total.Emission~PM25byYear$Year)
abline(fit,lty=2,cex=2)

dev.copy(png,"plot1.png")
dev.off()
