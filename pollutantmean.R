
setwd("~/GitHub/JHR Course/specdata") 

pollutantmean <- function(directory, pollutant, id = 1:332) { 
      
  allFiles <- list.files(path = directory, full.names = TRUE) 
  selectedData <- data.frame() 
  for (i in id) { 
  selectedData <- rbind(selectedData, read.csv(allFiles[i])) 
  } 
  if (pollutant == 'sulfate') { 
   mean(selectedData$sulfate, na.rm = TRUE) 
  } else if (pollutant == 'nitrate') { 
  mean(selectedData$nitrate, na.rm = TRUE) 
  } 
 
  } 

pollutantmean("~/GitHub/JHR Course/specdata", "nitrate", 23) 
pollutantmean("~/GitHub/JHR Course/specdata", "nitrate", 70:72) 
pollutantmean("~/GitHub/JHR Course/specdata", "sulfate", 1:10) 
