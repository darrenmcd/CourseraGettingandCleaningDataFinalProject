importData <- function() {
  library(dplyr)
  
  #Setup our files for import
  testx <- 'data/test/X_test.txt'
  testy <- 'data/test/y_test.txt'
  testSubject <-'data/test/subject_test.txt'
  trainx <-'data/train/X_train.txt'
  trainy <-'data/train/y_train.txt'
  subjectTrain <-'data/train/subject_train.txt'
  columnsFile <- 'data/features.txt'
  
  #Import our column names
  columnsDF <- read.table(columnsFile)
  
  #Import our test activity data
  testActivity <- read.table(testy,col.names=c("Activity"),colClasses=c('character'))
  
  #update our activity labels for our test data
  testActivity$Activity[testActivity$Activity == '1' ] <- 'WALKING'
  testActivity$Activity[testActivity$Activity == '2' ] <- 'WALKING UPSTAIRS'
  testActivity$Activity[testActivity$Activity == '3' ] <- 'WALKING DOWNSTAIRS'
  testActivity$Activity[testActivity$Activity == '4' ] <- 'SITTING'
  testActivity$Activity[testActivity$Activity == '5' ] <- 'STANDING'
  testActivity$Activity[testActivity$Activity == '6' ] <- 'LAYING'

  #Import our test subjects
  testSubject <- read.table(testSubject,col.names=c("Subject"),colClasses=c('character'))
  
  #Import our test data
  testDF <- read.table(testx,col.names=columnsDF[,2])
  
  #bind our test activity and subjects
  testActivitySubject <- cbind(testActivity,testSubject)
  
  #bind our subjects+activity and test data
  test <- cbind(testActivitySubject,testDF)
  
  #import our train activity
  trainActivity <- read.table(trainy,col.names=c("Activity"),colClasses=c('character'))
  
  #update our activity label for our training set
  trainActivity$Activity[trainActivity$Activity == '1' ] <- 'WALKING'
  trainActivity$Activity[trainActivity$Activity == '2' ] <- 'WALKING UPSTAIRS'
  trainActivity$Activity[trainActivity$Activity == '3' ] <- 'WALKING DOWNSTAIRS'
  trainActivity$Activity[trainActivity$Activity == '4' ] <- 'SITTING'
  trainActivity$Activity[trainActivity$Activity == '5' ] <- 'STANDING'
  trainActivity$Activity[trainActivity$Activity == '6' ] <- 'LAYING'
  
  #import our train subjects
  trainSubject <- read.table(subjectTrain,col.names=c("Subject"),colClasses=c('character'))
  #import our train data
  trainDF <- read.table(trainx,col.names=columnsDF[,2])
  
  #bind our activity and subjects
  trainActivitySubject <- cbind(trainActivity,trainSubject)
  #bind our activity/subjects with data
  train <- cbind(trainActivitySubject,trainDF)
  
  #rbind our test and train data
  df <- rbind(test,train)
  
  #get mean names from columns
  mean <- names(df)[grep("mean", names(df))] 
  
  #get std names from columns
  std <- names(df)[grep("std", names(df))] 
  
  #concat activity,subject + mean + std columns into a single column list
  cols <- c('Activity','Subject',mean,std)

  #subset data frame
  meanAndStd <- df[,cols]

  #aggrigate data group by activity,subject, and calculate mean for each column
  final <- meanAndStd %>% 
             group_by('Activity','Subject') %>% 
               summarise_each(funs(mean))

  #write our final data frame to our file
  write.table(final, file = "finalDataFrame.txt")
}
