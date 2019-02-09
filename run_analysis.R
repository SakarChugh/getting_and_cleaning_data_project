aclab<-read.table("activity_labels.txt")
features<-read.table("features.txt")
fneed<-features[grep(".*mean.*|.*std.*", features[,2]),]
f<-grep(".*mean.*|.*std.*", features[,2])

train<-read.table("/UCI HAR Dataset/train/X_train.txt")[f]
trainY<-read.table("/UCI HAR Dataset/train/y_train.txt")
trainsub<-read.table("/UCI HAR Dataset/train/subject_train.txt")
trainfinal<-cbind(trainsub,trainY,train)

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


colnames(trainfinal)<-c("Subject", "Activity Label", fa)

test<-read.table("/UCI HAR Dataset/test/X_test.txt")[f]
testY<-read.table("/UCI HAR Dataset/test/y_test.txt")
testsub<-read.table("/UCI HAR Dataset/test/subject_test.txt")
testfinal<-cbind(testsub,testY,test)
colnames(testfinal)<-c("Subject", "Activity Label", fa)

combined<-rbind(trainfinal,testfinal)

combined$`Activity Label`<-factor(combined$`Activity Label`, levels = aclab[,1], labels = aclab[,2])
combined$Subject<-as.factor(combined$Subject)

combinedA<- group_by(combined, combined$Subject, combined$Activity) %>% summarise_each(funs(mean))
tidydata<- combinedA[,c(1,2,5:83)]

write.table(tidydata, "tidy_data.txt",row.names = FALSE)