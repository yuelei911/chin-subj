
###Loading the package
library(ggplot2)
library(tidyverse)
library(dplyr)
library(haven)
library(tidyr)

###Reading the data of different source

#HPP
HPP_CN <-filter(read.csv("Data_Raw_HPP_Multi_Site_Share.csv"),Site=="Tsinghua")

#PSA_Jones et al.(2021)
PSA_Jones_CN <- read.csv("quest_data.csv") %>% 
  select(user_id,dv,q_name) %>% 
  group_by(user_id,q_name) %>% 
  filter(row_number()==1) %>% 
  ungroup() %>% 
  spread(q_name,dv,convert = TRUE) %>% 
  filter(country=="CN"| country=="TW"|country=="MO"|country=="HK") %>% 
  select(-V1)

#CFPS2018
CFPS2018 <- read_sas("cfps2018person_202012.sas7bdat")
CFPS2018_subset <- CFPS2018[,c(1,20,60,62,65,66,67,68,76,73,196,197)]

###Computing the proportion of sex
prop.table(with(HPP_CN,table(sex)))*100 ###1(male) 37.36 ;2(female) 62.64
prop.table(with(CFPS2018_subset,table(QA002)))*100 ###1(male) 50; 5(female) 50
prop.table(with(PSA_Jones_CN,table(sex)))*100  
###m (male) 33.42 ; f (female) 65.09 in raw data, drop "na" and "no" , they are 33.93 and 66.07 respectively


###In addition, we receive 6 th and 7th census data of sex from National Bureau of Statistics of China

###Constructing data frame
figure2 <- data.frame(data_source=c("HPP_CN","HPP_CN","CFPS2018","CFPS2018",
                                    "PSA_Jones_CN","PSA_Jones_CN","census6","census6",
                                    "census7","census7"),
                      sex=factor(c("male","female","male","female",
                                   "male","female","male","female","male","female")),
                      proportion=c(37.36,62.64,50,50,33.93,66.07,51.19,48.81,51.24,48.76))

###Transforming the data format and exporting the data required for Bayesian computation
figure2_data <- tidyr::spread(figure2,data_source,proportion)
write.csv(figure2_data,"figure2_data.csv",row.names = FALSE,fileEncoding = "UTF-8")


###Plotting
ggplot(figure2,aes(data_source,proportion,fill=sex)) +
  geom_col() +
  theme_classic()+
  theme(legend.position = "bottom",
        legend.key.size = unit(20,"pt"),
        legend.box.spacing = unit(4,"pt"),
        legend.title = element_text(size = 20,family = "serif"),
        axis.title = element_text(size = 20,family = "serif"),
        legend.text = element_text(size = 20,family = "serif"),
        axis.text = element_text(size =20,family = "serif"))

