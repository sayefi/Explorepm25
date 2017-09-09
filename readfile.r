
readfile<-function(dataset){
     fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     if(dataset=="SCC"){
          dataUrl<-"Source_Classification_Code.rds"
     } else
          dataUrl<-"summarySCC_PM25.rds"
     
     
     # tempUrl<-"tempfile.txt"
     
     
     if(!file.exists(dataUrl)){
          download.file(fileUrl,"input.zip")
          unzip("input.zip")
     }
     
          
     returnData<-readRDS(dataUrl)
     
     returnData
}