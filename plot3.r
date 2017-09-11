

## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.


library(dplyr)
library(ggplot2)

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

dataUrl<-"summarySCC_PM25.rds"

if(!file.exists(dataUrl)){
     download.file(fileUrl,"input.zip")
     unzip("input.zip")
}

NEI<-readRDS(dataUrl)


PM25Bultimore<-NEI%>%subset(fips == "24510")

PM25Bultimore<-PM25Bultimore[PM25Bultimore$Emissions>0,]


# ggplot(PM25Bultimore,aes(x=log(Emissions), fill=year)) + geom_density(alpha=0.25)
# 
# ggplot(PM25Bultimore, aes(x=log(Emissions)))+geom_density(aes(group=year,fill=year),alpha=0.50)+facet_grid(.~type)
# 
# ggplot(PM25Bultimore, aes(x=log(Emissions))) 
# + geom_density(aes(group=year,fill=year))
# 
# # + facet_grid(.~type)
# 
# qplot(log(Emissions),data=PM25Bultimore,colour=year,geom="density",facets=.~type)
# 
# 
# g<-ggplot(PM25Bultimore,aes(log(Emissions),color=year))
# #g<-g+geom_histogram(binwidth = .5,col="red")
# g<-g+facet_grid(.~type)
# g<-g+geom_density(aes(year=1999))
# g<-g+ggtitle("PM2.5 in Bultimore by Type")
# print(g)

g<-ggplot(PM25Bultimore,aes(year,log10(Emissions)))
g<-g+geom_point(col="red",cex=4,alpha=.3)
g<-g+facet_grid(.~type)
g<-g+geom_smooth(method="lm")
g<-g+ggtitle("PM2.5 in Baltimore by Type")
print(g)

dev.copy(png,"plot3.png")

dev.off()

# testData<-NEI%>%group_by(type,year)%>%dplyr::summarise(mean(Emissions))
# testData

