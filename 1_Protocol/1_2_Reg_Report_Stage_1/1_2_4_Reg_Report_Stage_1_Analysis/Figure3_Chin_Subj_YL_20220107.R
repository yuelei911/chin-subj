
###Loading the package
library(ggplot2)
library(dplyr)
library(tidyverse)
library(stringr)



###################################HPP######################################


###Reading the data of Human Penguin Projects(HPP) and computing the age
HPP_CN <-filter(read.csv("Data_Raw_HPP_Multi_Site_Share.csv"),Site=="Tsinghua")
HPP_CN$age <- 2016-HPP_CN$age

###Age segmentation for HPP
HPP_CN$age <-  cut(HPP_CN$age,breaks = c(-Inf,4,9,14,19,
                                         24,29,34,39,44,
                                         49,54,59,64,69,
                                         74,79,84,89,94,Inf),
                   labels = c("0-4","5-9","10-14","15-19","20-24",
                              "25-29","30-34","35-39","40-44","45-49",
                              "50-54","55-59","60-64","65-69","70-74",
                              "75-79","80-84","85-89", "90-94","95 and above"))


###Calculating the proportion of different sexes at different age groups 
HPP_Pp <- data.frame(prop.table(xtabs(~age+sex,data = HPP_CN))*100) %>%
  rename(proportion= "Freq")

###Controlling the number of  the decimal places and transforming age code
HPP_Pp$proportion<-  round(HPP_Pp$proportion,digits = 2)
HPP_Pp$sex <- ifelse(HPP_Pp$sex=="1","HPP_male","HPP_female")


###################################Jones et al.(2021)#########################


###Reading the data of Jones et al.(2021)
PSA_Jones_CN <- read.csv("quest_data.csv") %>% 
  select(user_id,dv,q_name) %>% 
  group_by(user_id,q_name) %>% 
  filter(row_number()==1) %>% 
  ungroup() %>% 
  spread(q_name,dv,convert = TRUE) %>% 
  filter(country=="CN"| country=="TW"|country=="MO"|country=="HK") %>% 
  select(-V1)

###Age segmentation for Jones_CN
PSAJCN_Pp <- PSA_Jones_CN
PSAJCN_Pp$age <-  cut(PSAJCN_Pp$age,breaks = c(-Inf,4,9,14,19,
                                               24,29,34,39,44,
                                               49,54,59,64,69,
                                               74,79,84,89,94,Inf),
                      labels = c("0-4","5-9","10-14","15-19","20-24",
                                 "25-29","30-34","35-39","40-44","45-49",
                                 "50-54","55-59","60-64","65-69","70-74",
                                 "75-79","80-84","85-89", "90-94","95 and above"))

###Handling the NA value
PSAJCN_drop <-  which(PSAJCN_Pp$sex=="no" | PSAJCN_Pp$sex=="na")
PSAJCN_Pp2 <- PSAJCN_Pp[-PSAJCN_drop,]

###Calculating the proportion of different sexes at different age group 
PSAJCN_Pp3 <- data.frame(prop.table(xtabs(~age+sex,data = PSAJCN_Pp2))*100) %>%
  rename(proportion= "Freq")

######Controlling the number of  the decimal places and transforming age code
PSAJCN_Pp3$proportion<-  round(PSAJCN_Pp3$proportion,digits = 2)
PSAJCN_Pp3$sex <- ifelse(PSAJCN_Pp3$sex=="m","PSAJCN_male","PSAJCN_female")


###################################Census 6th#########################


###Reading census6 age data and selecting object data (age group data)
census6_age <- read.csv("census6_age.csv")
census6_age_group <-  census6_age[c(6,12,18,24,30,36,42,
                                    48,54,60,66,72,78,84,
                                    90,96,102,108,114),c(1,6,7)]
###Here,we don't select 95 years old and above. we will calculate later 


###Renaming the column
colnames(census6_age_group) <- c("age","census6_male","census6_female")

###Combining the data of 95 years old and above and controlling the number of the decimal places
census6_age95 <- data.frame(age = c("95 and above"),
                            census6_male = (117716 + 8852)/1332810869*100,
                            census6_female = (252263 + 27082)/1332810869*100)
census6_age95$census6_male <-  round(census6_age95$census6_male,digits = 2)
census6_age95$census6_female <- round(census6_age95$census6_female,digits = 2)
census6_age_group <-  rbind(census6_age_group,census6_age95)

###Transforming the data format
census6_age_group2 <-  census6_age_group %>% 
  mutate(age=as.factor(age)) %>% 
  pivot_longer(-age, names_to = "sex", values_to = "proportion")

###Removing Chinese characters and transforming data formats
census6_age_group2$age <- str_replace(census6_age_group2$age,"岁","")
census6_age_group2$proportion <- as.numeric(census6_age_group2$proportion)

###To sort by age, fix the age level
census6_age_group2$age <-factor(census6_age_group2$age,
                               levels = c("0-4","5-9","10-14","15-19","20-24",
                                          "25-29","30-34","35-39","40-44","45-49",
                                          "50-54","55-59","60-64","65-69","70-74",
                                          "75-79","80-84","85-89", "90-94","95 and above"))

###Plotting
ggplot(data=census6_age_group2,mapping = aes(x=age,y=ifelse(sex=="census6_male",-proportion, proportion),fill=sex)) +
  geom_col(alpha=0.5,width = 1) +
  geom_line(data=HPP_Pp,aes(x = age,y = ifelse(sex == "HPP_male", -proportion/3, proportion/3),group=sex,color="HPP_CN"),size=1,inherit.aes = FALSE) +
  geom_line(data = PSAJCN_Pp3,aes(x=age,y = ifelse(sex == "PSAJCN_male", -proportion/3, proportion/3),group=sex,color="Jones_CN"),size=1,inherit.aes = FALSE) +
  scale_y_continuous(limits = c(-20,20),sec.axis = sec_axis(~.*3,name = "proportion")) +
  coord_flip()+
  labs(y="proportion",fill="data_source",color=NULL)+
  annotate("text",label= "italic(Male)",x=19,y=-2,parse=TRUE,size=8, family = "serif") +
  annotate("text",label= "italic(Female)",x=19,y=3,parse=TRUE,size=8,family = "serif") +
  scale_color_manual(values = c("red","blue"))+
  theme_classic()+
  theme(panel.border =element_rect(fill=NA,color="black"),
        legend.position ="bottom",
        legend.box.spacing = unit(2,"pt"),
        legend.text = element_text(size = 20, family = "serif"),
        legend.title = element_text(size=20,family = "serif"),
        axis.title = element_text(size = 20,family = "serif"),
        axis.text = element_text(size = 20,family = "serif"))
