##lib
library(tidyverse)
library(dplyr)
library(RecordLinkage)


####TwoINPUTS###
## SurveyFile
## Design File
## Optional TYPE File
###DESIGN TEMPLATE NEEDS TO BE CONSTRUCTED
##3SEPRATION
###Only1ANS
###MULTIANS
###OpenTextOthers
###ReadSurveyFiles

getwd()
#question_file <- read_csv("example//Example_input_q.csv")
survey_file <- read_csv("example//multiple_choice_responses.csv")
question_file<-survey_file[1,]
df_q = as_tibble(t(question_file), rownames = "row_names")
colnames(df_q)<-c('QID','QNAME')

df_q<-df_q %>%rowwise() %>%mutate(new_id = strsplit(QID, split="_")[[1]][1])
df_q<-df_q %>%rowwise() %>%mutate(OT = strsplit(QID, split="_")[[1]][3])

###
text_only<- df_q%>%filter(grepl('TEXT', OT))
non_text<-df_q%>%filter(!grepl('TEXT', OT))

###QuestionCount

q_count<-non_text%>%group_by(new_id)%>%count()
single_q<-q_count%>%filter(n==1)

###readTHESURVEY.
survey<-survey_file[-1,]

###countFORSingLEQ
survey_q<-survey[,single_q$new_id]
survey_q$ID<-c(1:dim(survey_q)[1])
survey_q<-survey_q %>%
    pivot_longer(!ID, names_to = "question", values_to = "count")


####TEXTCLOUD

wordCount_function<-function(df,ID,Ngram)
{
  
}

