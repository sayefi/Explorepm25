

## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

source("readfile.r")

library(dplyr)
library(ggplot2)


NEI<-readfile("NEI")

PM25Bultimore<-NEI%>%subset(fips == "24510")


g<-ggplot(PM25Bultimore,aes(year,log10(Emissions)))
g<-g+geom_point()
g<-g+facet_grid(.~type)
g<-g+geom_smooth(method="lm")
g<-g+ggtitle("PM2.5 in Bultimore by Type")
print(g)

dev.copy(png,"plot3.png")

dev.off()

# testData<-NEI%>%group_by(type,year)%>%dplyr::summarise(mean(Emissions))
# testData

