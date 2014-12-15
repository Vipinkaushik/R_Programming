setwd("~/GitHub/JHR Course/specdata") 
corr <- function(directory, threshold = 0) { 
source("complete.R") 
completeCases <- complete(directory) 
 casesoverThreshold <- completeCases[completeCases$mydf > threshold,1] 
totalFiles <- list.files(path = directory, full.names = TRUE) 
correlations <- rep(NA,length(casesoverThreshold)) 
for (i in casesAboveThreshold) { 
fileData <- (read.csv(totalFiles[i])) 
completeCases <- complete.cases(fileData) 
 validSulfateData <- fileData[completeCases, 2] 
validNitrateData <- fileData[completeCases, 3] 
correlations[i] <- cor(x = validSulfateData, y = validNitrateData) 
} 
correlations <- correlations[complete.cases(correlations)] 
} 

