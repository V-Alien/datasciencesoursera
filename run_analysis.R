setwd("C:/Users/Vishal/Dropbox/Coursera/R_PROG_3/UCI HAR Dataset/")

activity_names <- read.table('activity_labels.txt')

column_names <- read.table('features.txt')

X_train <- read.table('./train/X_train.txt', header = FALSE, sep = '', col.names = column_names[,2])

y_train <- read.table('./train/y_train.txt', header = FALSE, sep = '', col.names = 'activity')


X_test <- read.table('./test/X_test.txt', header = FALSE, sep = '', col.names = column_names[,2])

y_test <- read.table('./test/y_test.txt', header = FALSE, sep = '', col.names = 'activity')

X_all <- rbind(X_train, X_test)

y_all <- rbind(y_train, y_test)

y_all <- transmute(y_all, activity_description = activity_names[activity,2])

all_data <- cbind(X_all, y_all)

column_names_all <- colnames(all_data)

mean_vector <- grep('mean', column_names_all, ignore.case=TRUE)

std_vector <- grep('std', column_names_all, ignore.case=TRUE)

new_data_col_vector <- c(mean_vector, std_vector, 562)

pre_tidy <- all_data[,new_data_col_vector]

subject_train <- read.table('./train/subject_train.txt')
subject_test <- read.table('./test/subject_test.txt')

subject_all <- rbind(subject_train, subject_test)

pre_tidy <- cbind(subject_all, pre_tidy)

pre_tidy_cnames <- colnames(pre_tidy)

pre_tidy_cnames[1] <- 'Subject'

colnames(pre_tidy) <- pre_tidy_cnames


grouped_pre_tidy <-  group_by(pre_tidy, Subject, activity_description) %>% summarise_each(funs(mean))

write.table(grouped_pre_tidy, './tidy_data.txt', sep='\t', row.name=FALSE)

        

