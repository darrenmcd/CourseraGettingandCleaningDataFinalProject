importData <- function() {
  library(dplyr)
  
  testx <- 'data/test/X_test.txt'
  testy <- 'data/test/y_test.txt'
  testSubject <-'data/test/subject_test.txt'
  
  trainx <-'data/train/X_train.txt'
  trainy <-'data/train/y_train.txt'
  subjectTrain <-'data/train/subject_train.txt'

  columnsFile <- 'data/features.txt'
  
  columnsDF <- read.table(columnsFile)
  
  testActivity <- read.table(testy,col.names=c("Activity"),colClasses=c('character'))
  
  #now update our activity label
  #1 WALKING
  testActivity$Activity[testActivity$Activity == '1' ] <- 'WALKING'
  #2 WALKING_UPSTAIRS
  testActivity$Activity[testActivity$Activity == '2' ] <- 'WALKING UPSTAIRS'
  #3 WALKING_DOWNSTAIRS
  testActivity$Activity[testActivity$Activity == '3' ] <- 'WALKING DOWNSTAIRS'
  #4 SITTING
  testActivity$Activity[testActivity$Activity == '4' ] <- 'SITTING'
  #5 STANDING
  testActivity$Activity[testActivity$Activity == '5' ] <- 'STANDING'
  #6 LAYING
  testActivity$Activity[testActivity$Activity == '6' ] <- 'LAYING'
  
  testSubject <- read.table(testSubject,col.names=c("Subject"),colClasses=c('character'))
  testDF <- read.table(testx,col.names=columnsDF[,2])
  
  testActivitySubject <- cbind(testActivity,testSubject)
  test <- cbind(testActivitySubject,testDF)
  #dim(test)
  
  trainActivity <- read.table(trainy,col.names=c("Activity"),colClasses=c('character'))
  
  #now update our activity label
  #1 WALKING
  trainActivity$Activity[trainActivity$Activity == '1' ] <- 'WALKING'
  #2 WALKING_UPSTAIRS
  trainActivity$Activity[trainActivity$Activity == '2' ] <- 'WALKING UPSTAIRS'
  #3 WALKING_DOWNSTAIRS
  trainActivity$Activity[trainActivity$Activity == '3' ] <- 'WALKING DOWNSTAIRS'
  #4 SITTING
  trainActivity$Activity[trainActivity$Activity == '4' ] <- 'SITTING'
  #5 STANDING
  trainActivity$Activity[trainActivity$Activity == '5' ] <- 'STANDING'
  #6 LAYING
  trainActivity$Activity[trainActivity$Activity == '6' ] <- 'LAYING'
  
  
  trainSubject <- read.table(subjectTrain,col.names=c("Subject"),colClasses=c('character'))
  trainDF <- read.table(trainx,col.names=columnsDF[,2])
  
  trainActivitySubject <- cbind(trainActivity,trainSubject)
  train <- cbind(trainActivitySubject,trainDF)
  #dim(train)
  
  df <- rbind(test,train)
  mean <- names(df)[grep("mean", names(df))] 
  std <- names(df)[grep("std", names(df))] 
  colsForGroup <- c('Activity','Subject');
  colsForMean <- c(mean,std)
  cols <- c(colsForGroup,colsForMean)

  meanAndStd <- df[,cols]
  #dim(meanAndStd)
  final <- meanAndStd %>% 
             group_by('Activity','Subject') %>% 
               summarise_each(funs(mean))
 
  write.table(final, file = "finalDataFrame.txt")
  #faiapply(meanAndStd,2,mean)
}
