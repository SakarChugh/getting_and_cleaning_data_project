#Read features and activity labels
aclab<-read.table("activity_labels.txt")
features<-read.table("features.txt")

#Sort out the required labels
fneed<-features[grep(".*mean.*|.*std.*", features[,2]),]
f<-grep(".*mean.*|.*std.*", features[,2])

#Read data
train<-read.table("./UCI HAR Dataset/train/X_train.txt")[f]
trainY<-read.table("./UCI HAR Dataset/train/y_train.txt")
trainsub<-read.table("./UCI HAR Dataset/train/subject_train.txt")
trainfinal<-cbind(trainsub,trainY,train)

test<-read.table("./UCI HAR Dataset/test/X_test.txt")[f]
testY<-read.table("./UCI HAR Dataset/test/y_test.txt")
testsub<-read.table("./UCI HAR Dataset/test/subject_test.txt")
testfinal<-cbind(testsub,testY,test)

#Choose required fields and change the names
fa<-fneed[,2]
fa<-as.character(fa)
fa <- gsub("^f", "frequencyDomain", fa)
fa <- gsub("^t", "timeDomain", fa)
fa <- gsub("Acc", "Accelerometer", fa)
fa <- gsub("Gyro", "Gyroscope", fa)
fa <- gsub("Mag", "Magnitude", fa)
fa <- gsub("Freq", "Frequency", fa)
fa <- gsub("mean", "Mean", fa)
fa <- gsub("std", "StandardDeviation", fa)
fa <- gsub("(-)", "", fa)
fa <- gsub("\\(\\)", "", fa)

#Assign column names to the data frames
colnames(trainfinal)<-c("Subject", "Activity", fa)
colnames(testfinal)<-c("Subject", "Activity", fa)

#Combine test and training data
combined<-rbind(trainfinal,testfinal)

#Convert Activity Label and Subject to factors
combined$`Activity`<-factor(combined$`Activity`, levels = aclab[,1], labels = aclab[,2])
combined$Subject<-as.factor(combined$Subject)

#Group data by Subject and Activity and take the mean
combinedA<- group_by(combined, combined$Subject, combined$Activity) %>% summarise_each(funs(mean))
tidydata<- combinedA[,c(1,2,5:83)]

#Write data into a txt file
write.table(tidydata, "tidy_data.txt",row.names = FALSE)