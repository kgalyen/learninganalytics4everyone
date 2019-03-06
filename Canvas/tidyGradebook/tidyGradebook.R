##install packages if you need to, if it's your first time; uncomment it
##install.packages("tidyverse")

##---------------
# This is code that helps you take a common gradebook style (like from Canvas) 
# and put it into tidy data format using Hadley Wickham's package tidyverse.
# Feel free to rename the variables as you wish.
# Your gradebook will look different and have more columns since mine is
# anonymized with any identifyable data removed; you won't need to do that 
# if you are not sharing your data with others.
#
# Canvas gradebook exports have an extra row called "Points total."
# To see how to get rid of that row and prepare an assignment meta data
# file, see this video: https://www.youtube.com/watch?v=gdknosXY41Q
# Read more about tidy data here: http://vita.had.co.nz/papers/tidy-data.pdf
# 

# watch video orientation on changing your data from wide to long: 
# https://youtu.be/SEf-iMlJbYY

##load libraries
library(tidyverse)

###READ CSVs
#change file name to your file name
eng_StPoints <- read.csv("eng_rawGradebook.csv") 
#change file name to your file name
eng_AssignmentsMeta <- read.csv("eng_AssignmentsMeta.csv") 

# Change gradebook from wide to long format via tidyr gather function
eng_StPoints_long <- tidyr::gather(eng_StPoints,"L1_Quiz":"FinalExamWriting",key="Assignment_Title", value="PointsEarned") 
#check data
head(eng_StPoints_long)
# export to check out the data in excel
write.csv(eng_StPoints_long, file = "eng_StPoints_long.csv",row.names=FALSE)

# Join the assignments table and add a percentage: 
# https://www.youtube.com/watch?v=7fnWzZySu18

# remind yourself of the table header names
names(eng_StPoints_long)
names(eng_AssignmentsMeta)

# join the data from the assignments meta data table to the grades table.
engData <- dplyr::left_join(eng_StPoints_long, eng_AssignmentsMeta, by = c("Assignment_Title" = "AssignmentName"))
head(engData)
# export to check out in Excel if you'd like
write.csv(engData, file = "engData.csv",row.names=FALSE)

# Add a calculated column "percentage.earned"
# use mutate
engJoined_Perc <- dplyr::mutate(engData, PercentEarned = PointsEarned/Points.Possible)
# export to check it out in Excel 
write.csv(engJoined_Perc, file="engJoined_Perc.csv", row.names=FALSE)

