library(sqldf)
options(warn=-1)
#READING TEST DATA

subtest = read.table("test\\subject_test.txt")
xtest = read.table("test\\X_test.txt")
ytest = read.table("test\\y_test.txt")

#set proper activity names
#3. Uses descriptive activity names to name the activities in the data set


ytest$V1<-gsub(1,"WALKING",ytest$V1)
ytest$V1<-gsub(2,"WALKING_UPSTAIRS",ytest$V1)
ytest$V1<-gsub(3,"WALKING_DOWNSTAIRS",ytest$V1)
ytest$V1<-gsub(4,"SITTING",ytest$V1)
ytest$V1<-gsub(5,"STANDING",ytest$V1)
ytest$V1<-gsub(6,"LAYING",ytest$V1)


flabels<-read.table("features.txt")

#reading Inertial Data
baxtest = read.table("test/Inertial Signals/body_acc_x_test.txt")
baytest = read.table("test/Inertial Signals/body_acc_y_test.txt")
baztest = read.table("test/Inertial Signals/body_acc_z_test.txt")
bgxtest = read.table("test/Inertial Signals/body_gyro_x_test.txt")
bgytest = read.table("test/Inertial Signals/body_gyro_y_test.txt")
bgztest = read.table("test/Inertial Signals/body_gyro_z_test.txt")
taxtest = read.table("test/Inertial Signals/total_acc_x_test.txt")
taytest = read.table("test/Inertial Signals/total_acc_y_test.txt")
taztest = read.table("test/Inertial Signals/total_acc_z_test.txt")


#4. Appropriately labels the data set with descriptive variable names. 
#reading labels and extrcting first column
flabels<-read.table("features.txt")
flabels<-flabels[,-c(1)]
#naming columns in data
names(xtest)<-flabels
names(ytest)<-"activity"
names(subtest)<-"subject"

names(baxtest)<-gsub("V","body_acc_x",names(baxtest))
names(baytest)<-gsub("V","body_acc_y",names(baytest))
names(baztest)<-gsub("V","body_acc_z",names(baztest))

names(bgxtest)<-gsub("V","body_gyro_x",names(bgxtest))
names(bgytest)<-gsub("V","body_gyro_y",names(bgytest))
names(bgztest)<-gsub("V","body_gyro_z",names(bgztest))

names(taxtest)<-gsub("V","total_acc_x",names(taxtest))
names(taytest)<-gsub("V","total_acc_y",names(taytest))
names(taztest)<-gsub("V","total_acc_z",names(taztest))

#merge dataframes with test data
testdf<-data.frame(xtest,ytest,subtest,baxtest,baytest,baztest,bgxtest,
                   bgytest,bgztest,taxtest,taytest,taztest)


#repeat proccess with train data

#READING TRAIN DATA

subtrain = read.table("train/subject_train.txt")
xtrain = read.table("train/X_train.txt")
ytrain = read.table("train/y_train.txt")

#set proper activity names
#3. Uses descriptive activity names to name the activities in the data set
ytrain$V1<-gsub(2,"WALKING_UPSTAIRS",ytrain$V1)
ytrain$V1<-gsub(1,"WALKING",ytrain$V1)
ytrain$V1<-gsub(3,"WALKING_DOWNSTAIRS",ytrain$V1)
ytrain$V1<-gsub(4,"SITTING",ytrain$V1)
ytrain$V1<-gsub(5,"STANDING",ytrain$V1)
ytrain$V1<-gsub(6,"LAYING",ytrain$V1)

flabels<-read.table("features.txt")

#reading Inertial Data
baxtrain = read.table("train/Inertial Signals/body_acc_x_train.txt")
baytrain = read.table("train/Inertial Signals/body_acc_y_train.txt")
baztrain = read.table("train/Inertial Signals/body_acc_z_train.txt")
bgxtrain = read.table("train/Inertial Signals/body_gyro_x_train.txt")
bgytrain = read.table("train/Inertial Signals/body_gyro_y_train.txt")
bgztrain = read.table("train/Inertial Signals/body_gyro_z_train.txt")
taxtrain = read.table("train/Inertial Signals/total_acc_x_train.txt")
taytrain = read.table("train/Inertial Signals/total_acc_y_train.txt")
taztrain = read.table("train/Inertial Signals/total_acc_z_train.txt")



#naming columns in data
names(xtrain)<-flabels
names(ytrain)<-"train_activity"
names(subtrain)<-"train_subject"

names(baxtrain)<-gsub("V","body_acc_x",names(baxtrain))
names(baytrain)<-gsub("V","body_acc_y",names(baytrain))
names(baztrain)<-gsub("V","body_acc_z",names(baztrain))

names(bgxtrain)<-gsub("V","body_gyro_x",names(bgxtrain))
names(bgytrain)<-gsub("V","body_gyro_y",names(bgytrain))
names(bgztrain)<-gsub("V","body_gyro_z",names(bgztrain))

names(taxtrain)<-gsub("V","total_acc_x",names(taxtrain))
names(taytrain)<-gsub("V","total_acc_y",names(taytrain))
names(taztrain)<-gsub("V","total_acc_z",names(taztrain))

#merge dataframes with train data
traindf<-data.frame(xtrain,ytrain,subtrain,baxtrain,baytrain,baztrain,bgxtrain,bgytrain,
                    bgztrain,taxtrain,taytrain,taztrain)

names(traindf)<-names(testdf)

#1. Merges the training and the test sets to create one data set.

totaldf<-rbind(traindf,testdf)

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
meanstd<-totaldf[,grep("mean|std",names(totaldf))]

#if we consider Uppercase may use
#meanstd<-totaldf[,grep("[Mm]ean|[Ss]td",names(totaldf))]

#5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
attach(totaldf)

finaldata <-aggregate(totaldf, by=list(activity,subject),FUN=mean, na.rm=TRUE)

detach(totaldf)

#extract columns activity and subject
finaldata<-subset(finaldata,select=-c(activity,subject))

#rename grouping variables Group.1 and Group.2
names(finaldata)[names(finaldata) == 'Group.1'] <- 'activity'
names(finaldata)[names(finaldata) == 'Group.2'] <- 'subject'






