---
title: "runanalysis.R"
author: "Darren McDowell"
date: "September 21, 2014"
intput: none
library: plyr
output: idy data set with the average of each variable for each activity and each subject
---

```{r}
imputData()
```
Steps:

  1:  Setup our files for import
  2:  Import our column names
  3:  Import our test activity data
  4:  update our activity labels for our test data
  5:  Import our test subjects
  6:  Import our test data
  7:  bind our test activity and subjects
  8:  bind our subjects+activity and test data
  9:  import our train activity
  10: update our activity label for our training set
  11: import our train subjects
  12: import our train data
  13: bind our activity and subjects
  14: bind our activity/subjects with data
  15: rbind our test and train data
  16: get mean names from columns
  17: get std names from columns
  18: concat activity,subject + mean + std columns into a single column list
  19: subset data frame
  20: aggrigate data group by activity,subject, and calculate mean for each column
  21: write our final data frame to our file
  

```{r, echo=FALSE}
Data Dictionary
```
Activity
  Type: Charector
  Description: Activity the subject was performing
Subject 
  Type: Charector
  Description: Subject performing the activity
tBodyAcc.mean...X
  Type: numeric
  Description: Average of tBodyAcc.mean...X for a given subject performing the given activity
tBodyAcc.mean...Y 
  Type: numeric
  Description: Average of tBodyAcc.mean...Y  for a given subject performing the given activity
tBodyAcc.mean...Z 
  Type: numeric
  Description: Average of tBodyAcc.mean...Z for a given subject performing the given activity
tGravityAcc.mean...X
  Type: numeric
  Description: Average of tGravityAcc.mean...X for a given subject performing the given activity
tGravityAcc.mean...Y 
  Type: numeric
  Description: Average of tGravityAcc.mean...Y for a given subject performing the given activity
tGravityAcc.mean...Z 
  Type: numeric
  Description: Average of tGravityAcc.mean...Z for a given subject performing the given activity
tBodyAccJerk.mean...X 
  Type: numeric
  Description: Average of tBodyAccJerk.mean...X for a given subject performing the given activity
tBodyAccJerk.mean...Y 
  Type: numeric
  Description: Average of tBodyAccJerk.mean...Y for a given subject performing the given activity
tBodyAccJerk.mean...Z 
  Type: numeric
  Description: Average of tBodyAccJerk.mean...Z for a given subject performing the given activity
tBodyGyro.mean...X
  Type: numeric
  Description: Average of tBodyGyro.mean...X for a given subject performing the given activity
tBodyGyro.mean...Y 
  Type: numeric
  Description: Average of tBodyGyro.mean...Y for a given subject performing the given activity
tBodyGyro.mean...Z 
  Type: numeric
  Description: Average of tBodyGyro.mean...Z for a given subject performing the given activity
tBodyGyroJerk.mean...X 
  Type: numeric
  Description: Average of tBodyGyro.mean...Z for a given subject performing the given activity
tBodyGyroJerk.mean...Y 
  Type: numeric
  Description: Average of tBodyGyroJerk.mean...Y for a given subject performing the given activity
tBodyGyroJerk.mean...Z 
  Type: numeric
  Description: Average of tBodyGyroJerk.mean...Z for a given subject performing the given activity
tBodyAccMag.mean..
  Type: numeric
  Description: Average of tBodyAccMag.mean.. for a given subject performing the given activity
tGravityAccMag.mean..
  Type: numeric
  Description: Average of tGravityAccMag.mean.. for a given subject performing the given activity
tBodyAccJerkMag.mean..
  Type: numeric
  Description: Average of tBodyAccJerkMag.mean.. for a given subject performing the given activity
tBodyGyroMag.mean..
  Type: numeric
  Description: Average of tBodyGyroMag.mean.. for a given subject performing the given activity
tBodyGyroJerkMag.mean..
  Type: numeric
  Description: Average of tBodyGyroJerkMag.mean.. for a given subject performing the given activity
fBodyAcc.mean...X
  Type: numeric
  Description: Average of fBodyAcc.mean...X for a given subject performing the given activity
fBodyAcc.mean...Y
  Type: numeric
  Description: Average of fBodyAcc.mean...Y for a given subject performing the given activity
fBodyAcc.mean...Z 
  Type: numeric
  Description: Average of fBodyAcc.mean...Z  for a given subject performing the given activity
fBodyAcc.meanFreq...X 
  Type: numeric
  Description: Average of fBodyAcc.meanFreq...X  for a given subject performing the given activity
fBodyAcc.meanFreq...Y 
  Type: numeric
  Description: Average of fBodyAcc.meanFreq...Y  for a given subject performing the given activity
fBodyAcc.meanFreq...Z 
  Type: numeric
  Description: Average of fBodyAcc.meanFreq...Z  for a given subject performing the given activity
fBodyAccJerk.mean...X 
  Type: numeric
  Description: Average of fBodyAccJerk.mean...X for a given subject performing the given activity
fBodyAccJerk.mean...Y 
  Type: numeric
  Description: Average of fBodyAccJerk.mean...Y  for a given subject performing the given activity
fBodyAccJerk.mean...Z 
  Type: numeric
  Description: Average of fBodyAccJerk.mean...Z  for a given subject performing the given activity
fBodyAccJerk.meanFreq...X 
  Type: numeric
  Description: Average of fBodyAccJerk.meanFreq...X  for a given subject performing the given activity
fBodyAccJerk.meanFreq...Y 
  Type: numeric
  Description: Average of fBodyAccJerk.meanFreq...Y  for a given subject performing the given activity
fBodyAccJerk.meanFreq...Z 
  Type: numeric
  Description: Average of fBodyAccJerk.meanFreq...Z  for a given subject performing the given activity
fBodyGyro.mean...X
  Type: numeric
  Description: Average of fBodyGyro.mean...X for a given subject performing the given activity
fBodyGyro.mean...Y
  Type: numeric
  Description: Average of fBodyGyro.mean...Y for a given subject performing the given activity
fBodyGyro.mean...Z 
  Type: numeric
  Description: Average of fBodyGyro.mean...Z for a given subject performing the given activity
fBodyGyro.meanFreq...X 
  Type: numeric
  Description: Average of fBodyGyro.meanFreq...X for a given subject performing the given activity
fBodyGyro.meanFreq...Y 
  Type: numeric
  Description: Average of fBodyGyro.meanFreq...Y for a given subject performing the given activity
fBodyGyro.meanFreq...Z
  Type: numeric
  Description: Average of fBodyGyro.meanFreq...Z for a given subject performing the given activity
fBodyAccMag.mean..
  Type: numeric
  Description: Average of fBodyAccMag.mean.. for a given subject performing the given activity
fBodyAccMag.meanFreq..
  Type: numeric
  Description: Average of fBodyAccMag.meanFreq.. for a given subject performing the given activity
fBodyBodyAccJerkMag.mean..
  Type: numeric
  Description: Average of fBodyBodyAccJerkMag.mean.. for a given subject performing the given activity
fBodyBodyAccJerkMag.meanFreq..
  Type: numeric
  Description: Average of fBodyBodyAccJerkMag.meanFreq.. for a given subject performing the given activity
fBodyBodyGyroMag.mean..
  Type: numeric
  Description: Average of fBodyBodyGyroMag.mean.. for a given subject performing the given activity
fBodyBodyGyroMag.meanFreq..
  Type: numeric
  Description: Average of fBodyBodyGyroMag.meanFreq.. for a given subject performing the given activity
fBodyBodyGyroJerkMag.mean..
  Type: numeric
  Description: Average of fBodyBodyGyroJerkMag.mean.. for a given subject performing the given activity
fBodyBodyGyroJerkMag.meanFreq..
  Type: numeric
  Description: Average of fBodyBodyGyroJerkMag.meanFreq.. for a given subject performing the given activity
tBodyAcc.std...X
  Type: numeric
  Description: Average of tBodyAcc.std...X for a given subject performing the given activity
tBodyAcc.std...Y
  Type: numeric
  Description: Average of tBodyAcc.std...Y for a given subject performing the given activity
tBodyAcc.std...Z
  Type: numeric
  Description: Average of tBodyAcc.std...Z for a given subject performing the given activity
tGravityAcc.std...X
  Type: numeric
  Description: Average of tGravityAcc.std...X for a given subject performing the given activity
tGravityAcc.std...Y
  Type: numeric
  Description: Average of tGravityAcc.std...Y for a given subject performing the given activity
tGravityAcc.std...Z
  Type: numeric
  Description: Average of tGravityAcc.std...Z for a given subject performing the given activity
tBodyAccJerk.std...X
  Type: numeric
  Description: Average of tBodyAccJerk.std...X for a given subject performing the given activity
tBodyAccJerk.std...Y
  Type: numeric
  Description: Average of tBodyAccJerk.std...Y for a given subject performing the given activity
tBodyAccJerk.std...Z
  Type: numeric
  Description: Average of tBodyAccJerk.std...Z for a given subject performing the given activity
tBodyGyro.std...X
  Type: numeric
  Description: Average of tBodyGyro.std...X for a given subject performing the given activity
tBodyGyro.std...Y
  Type: numeric
  Description: Average of tBodyGyro.std...Y for a given subject performing the given activity
tBodyGyro.std...Z
  Type: numeric
  Description: Average of tBodyGyro.std...Z for a given subject performing the given activity
tBodyGyroJerk.std...X
  Type: numeric
  Description: Average of tBodyGyroJerk.std...X for a given subject performing the given activity
tBodyGyroJerk.std...Y
  Type: numeric
  Description: Average of tBodyGyroJerk.std...Y for a given subject performing the given activity
tBodyGyroJerk.std...Z
  Type: numeric
  Description: Average of tBodyGyroJerk.std...Z for a given subject performing the given activity
tBodyAccMag.std..
  Type: numeric
  Description: Average of tBodyAccMag.std.. for a given subject performing the given activity
tGravityAccMag.std..
  Type: numeric
  Description: Average of tGravityAccMag.std.. for a given subject performing the given activity
tBodyAccJerkMag.std..
  Type: numeric
  Description: Average of tBodyAccJerkMag.std.. for a given subject performing the given activity
tBodyGyroMag.std..
  Type: numeric
  Description: Average of tBodyGyroMag.std.. for a given subject performing the given activity
tBodyGyroJerkMag.std..
  Type: numeric
  Description: Average of tBodyGyroJerkMag.std.. for a given subject performing the given activity
fBodyAcc.std...X
  Type: numeric
  Description: Average of fBodyAcc.std...Y for a given subject performing the given activity
fBodyAcc.std...Y
  Type: numeric
  Description: Average of  for a given subject performing the given activity
fBodyAcc.std...Z
  Type: numeric
  Description: Average of fBodyAcc.std...Z for a given subject performing the given activity
fBodyAccJerk.std...X
  Type: numeric
  Description:  Average of fBodyAccJerk.std...X for a given subject performing the given activity
fBodyAccJerk.std...Y
  Type: numeric
  Description:  Average of fBodyAccJerk.std...Y for a given subject performing the given activity
fBodyAccJerk.std...Z
  Type: numeric
  Description:  Average of fBodyAccJerk.std...Z for a given subject performing the given activity
fBodyGyro.std...X
  Type: numeric
  Description:  Average of fBodyGyro.std...X for a given subject performing the given activity
fBodyGyro.std...Y
  Type: numeric
  Description:  Average of fBodyGyro.std...Y for a given subject performing the given activity
fBodyGyro.std...Z
  Type: numeric
  Description:  Average of fBodyGyro.std...Z for a given subject performing the given activity
fBodyAccMag.std..
  Type: numeric
  Description: Average of fBodyAccMag.std.. for a given subject performing the given activity
fBodyBodyAccJerkMag.std..
  Type: numeric
  Description: Average of fBodyBodyAccJerkMag.std.. for a given subject performing the given activity
fBodyBodyGyroMag.std..
  Type: numeric
  Description: Average of fBodyBodyGyroMag.std.. for a given subject performing the given activity
fBodyBodyGyroJerkMag.std..
  Type: numeric
  Description: Average of fBodyBodyGyroJerkMag.std for a given subject performing the given activity

```{r, echo=FALSE}
Other Notes
Readme of data before analysis
```

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

```{r, echo=FALSE}
Other Notes
features_info.txt of data before analysis
```

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated 
using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
