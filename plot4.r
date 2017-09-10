

## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?


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


CoalSccFlag<-grep("Coal$",SCC$EI.Sector)

CoalSccNo<-SCC[CoalSccFlag,1]

NEICoal<-NEI[NEI$SCC %in% CoalSccNo, ]

NEICoal<-NEICoal[NEICoal$Emissions>0,]


# plot(NEICoal$year,NEICoal$Emissions)
# 
# 
# plot(NEICoal$year,log(NEICoal$Emissions),col=rgb(1,0,0,.2),cex=2,pch=19,
#      xlab="Year",ylab="Emissions in Log scale")
# 
# fit<-lm(log(NEICoal$Emissions)~NEICoal$year)
# abline(fit,col="blue",lty=5)
# title("Coal combustion related PM2.5 Emission in US")
# 
# boxplot(Emissions~year,NEICoal)



g<- ggplot(NEICoal, aes(x=log2(Emissions)))
g<-g+geom_density(aes(group=year,fill=year),alpha=0.50)
g<-g+ggtitle("Emissions for Coal combustion related sources")
print(g)

dev.copy(png,"plot4.png")

dev.off()

