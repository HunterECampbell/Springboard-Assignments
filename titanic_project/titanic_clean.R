install.packages("tidyr")
install.packages("dplyr")
library("tidyr")
library("dplyr")

#load in the csv file
titanic_original <- read.csv("https://github.com/hcnureth/Springboard-Assignments/blob/master/titanic_project/titanic_original.csv")

#create clean object
titanic_clean <- titanic_original

#change all embarked NA to S
sum(is.na(titanic_clean$embarked))  #this returns 0, so they might be blank values
sum(titanic_clean$embarked == "")  #this return 2, so that's the problem
titanic_clean$embarked[titanic_original$embarked == ""] <- "S"

#calculate the mean of the age column and fill in the blanks
#first check for NA or blank values
sum(is.na(titanic_clean$age))  #returns 263, now I can format a mean function
mean(titanic_clean$age, na.rm = TRUE)  #equals 29.88113
titanic_clean$age[is.na(titanic_clean$age)] <- mean(titanic_clean$age, na.rm = TRUE)
#median() seems that it would have done the same thing as mean()?  I tested it after I applied mean(), so I'm not quite sure if median() would have had the same results
#I would have stuck with mean() over median() because the average seems more applicable in this case.

#replacing NA values in the boat column with "None"
sum(is.na(titanic_clean$boat)) #this returns 0, so they might be blank values
sum(titanic_clean$boat == "")  #this returns 823, so that's our problem
titanic_clean$boat[titanic_clean$boat == ""] <- "NA"

#create a has_cabin_number binary column
#first check if it is blank or NA so that I know how to format the mutate() for the has_cabin_number column
sum(is.na(titanic_clean$cabin))  #this returns 0
sum(titanic_clean$cabin == "")  #this returns 1014
titanic_clean <- mutate(titanic_clean, has_cabin_number = ifelse(titanic_clean$cabin == "", 0, 1))
