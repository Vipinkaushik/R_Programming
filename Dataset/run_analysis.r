library(plyr)
setwd("~/GitHub/R_Programming/Dataset")
trainingSubject<-read.table("~/GitHub/R_Programming/Dataset/train/subject_train.txt",header=FALSE)
trainingY<-read.table("~/GitHub/R_Programming/Dataset/train/y_train.txt",header=FALSE)
trainingX<-read.table("~/GitHub/R_Programming/Dataset/train/x_train.txt",header=FALSE)
testingSubject<-read.table("~/GitHub/R_Programming/Dataset/test/subject_test.txt",header=FALSE)
testingY<-read.table("~/GitHub/R_Programming/Dataset/test/y_test.txt",header=FALSE)
testingX<-read.table("~/GitHub/R_Programming/Dataset/test/x_test.txt",header=FALSE)
features<-read.table("~/GitHub/R_Programming/Dataset/features.txt",header=FALSE)
activityLabels<-read.table("~/GitHub/R_Programming/Dataset/activity_labels.txt",header=FALSE)


subjects<-rbind(trainingSubject,testingSubject)
activities<-rbind(trainingY,testingY)
readings<-rbind(trainingX,testingX)

tmp<-count(unique(subjects)); subjectNum<-sum(tmp$freq)
tmp<-count(unique(activityLabels)); labelNum<-sum(tmp$freq)



activities$activityName<-activityLabels[activities$V1,2]


cleanFeatures<-gsub("([()])", "", features[,2])
cleanFeatures<-gsub("([-])","",cleanFeatures)
cleanFeatures<-gsub("([,])","",cleanFeatures)
colnames(readings)<-cleanFeatures


master<-cbind(activities,subjects)
colnames(master)<-c("activityLabel","activityName","activitySubject")
master<-cbind(master,readings[,41:46],readings[,214:215],readings[,253:254],
              readings[,266:271],readings[,345:350],readings[,424:429],
              readings[,503:504],readings[,516:517],
              readings[,529:530],readings[,542:543])




master<-master[order(master$activitySubject,desc(master$activityLabel)),]


output<-matrix(NA,labelNum*subjectNum,length(master))
output<-as.data.frame(output)
colnames(output)<-names(master)
outputCtr<-1

for(i in 1:labelNum){
  tmpAct<-master[master$activityLabel==i,]
  for(j in 1:subjectNum){
    tmpActSubj<-tmpAct[tmpAct$activitySubject==j,]
    output[outputCtr,1]<-i
    output[outputCtr,2]<-as.character(activityLabels[i,2])
    output[outputCtr,3]<-j
    for(k in 1:(length(master)-3)){
      output[outputCtr,k+3]<-mean(tmpActSubj[,k+3])
    }
    outputCtr<-outputCtr+1
  }
}

write.table(master,"~/GitHub/R_Programming/Dataset/masterData.txt",row.names=T,col.names=T) 
write.table(output,"~/GitHub/R_Programming/Dataset/activitySubjectMeans.txt",row.names=T,col.names=T) 
listOfVariables <- data.frame(names(output))
write.csv(listOfVariables,"~/GitHub/R_Programming/Dataset/listOfVariables.csv")

setwd("~/GitHub/R_Programming/Dataset")

