setwd("~/GitHub/JHR Course/specdata") 

complete <- function(directory, id = 1:332) 
{totalFiles <- list.files(path = directory, full.names = TRUE) 
 ChoosenData <- data.frame() 
 completeCases <- data.frame() 
 mydf <- data.frame(); 
 for (i in id) {  
   ChoosenData <- (read.csv(totalFiles[i],header=TRUE)) 
   mydf <- sum(complete.cases(ChoosenData))
   completeCases <- rbind(completeCases, data.frame(i,mydf)) 
 } 
 completeCases 
} 

complete("~/GitHub/JHR Course/specdata", 1)



