
###Loading the package
library(ggplot2)
library(dplyr)
library(tidyverse)
library(openxlsx)
library(ggh4x)
library(tidyr)

###Reading the data of Jones et al.(2021) for non-WEIRD region
PSA_Jones_other <- read.csv("quest_data.csv") %>% 
  select(user_id,dv,q_name) %>% 
  group_by(user_id,q_name) %>% 
  filter(row_number()==1) %>% 
  ungroup() %>% 
  spread(q_name,dv,convert = TRUE) %>% 
  select(-V1)

###Merging data from Hong Kong, Macau and Taiwan with Chinese mainland
PSA_Jones_other$country[PSA_Jones_other$country=="TW"] <- "CN"
PSA_Jones_other$country[PSA_Jones_other$country=="HK"] <- "CN"
PSA_Jones_other$country[PSA_Jones_other$country=="MO"] <- "CN"

###Selecting countries with sample >=30
PSAJO_filter <-  data.frame(table(PSA_Jones_other$country)) %>% 
  rename(country="Var1",value="Freq")%>%                    
  filter(value>=30)

PSAJO_filter$country

PSAJO_target <-  PSA_Jones_other %>% 
  filter(country=="AE"|country=="AR"|country=="AT"|country=="AU"|country=="BR"|country=="CA"|
           country=="CH"|country=="CL"|country=="CN"|country=="CO"|country=="DE"|country=="DK"|
           country=="EC"|country=="ES"|country=="FI"|country=="FR"|country=="GB"|country=="GR"| 
           country=="HU"|country=="IN"|country=="IR"|country=="IT"|country=="KE"|country=="MX"|
           country=="MY"|country=="NG"|country=="NL"|country=="NO"|country=="NZ"|country=="PE"|
           country=="PL"|country=="PT"|country=="RO"|country=="RS"|country=="RU"|country=="SE"|
           country=="SK"|country=="SV"|country=="TH"|country=="TR"|country=="UA"|country=="US"|
           country=="ZA")

###Handing the NA values
PSAJO_target$sex[PSAJO_target$sex=="no" |PSAJO_target$sex=="na"] <- NA
PSAJO_target <-  PSAJO_target %>% 
  filter(!is.na(sex))

###Calculating the number of different genders per country and modifying the column names
###And merging with the country code (ISO2) corresponding to the full name of the file
PSAJO_table <-  data.frame(table(PSAJO_target$country,
                                 PSAJO_target$sex)) %>% 
  rename(country="Var1",sex="Var2",value="Freq")

regioncode <- read.xlsx("Chin_Subj_F4(5)_region.xlsx")

PSAJO_merge <- merge(PSAJO_table,regioncode,by.x = "country",by.y = "country_iso2")

###Converting data format
PSAJO_f <- PSAJO_merge[PSAJO_merge$sex=="f",]
PSAJO_m <- PSAJO_merge[PSAJO_merge$sex=="m",]
PSAJO_fm <-  merge(PSAJO_f,PSAJO_m,by="country") %>% 
  rename(sex.f="sex.x",sex.m="sex.y",value.f="value.x",value.m="value.y")

###Calculating the proportion of different genders in each country and controlling the number of decimal places
PSAJO_fm2 <-  PSAJO_fm %>% 
  mutate(proportion.f=value.f/(value.f+value.m),
         proportion.m=value.m/(value.f+value.m))
PSAJO_fm2$proportion.f <- round(PSAJO_fm2$proportion.f,digits = 2)
PSAJO_fm2$proportion.m <- round(PSAJO_fm2$proportion.m,digits = 2)

###Converting data format
plot_PSAJO <- PSAJO_fm2%>% 
  pivot_longer(cols = c(proportion.f,proportion.m),
               names_to = "sex",values_to = "proportion") %>% 
  arrange(sex,proportion)

###View the rank of females
plot_PSAJO$country[plot_PSAJO$sex=="proportion.f"]

###Factor levels are set to rank the plot by the proportion of female
plot_PSAJO$country <- factor(plot_PSAJO$country,
                             levels = c("IN","SE","MX","UA","KE","NG","AR","GR","SV",
                                        "CA","CL","IR","PE","BR","CO","EC","CN","MY",
                                        "US","IT","NO","RU","FI","AT","AU","TR","HU",
                                        "RS","PL","DE","GB","PT","TH","NZ","ZA","ES", 
                                        "CH","DK","FR","NL","RO","SK","AE"))


###Transforming the data format and exporting the data required for Bayesian computation
figure4_data <- plot_PSAJO[,c(1,12,13)]
figure4_data$sex[figure4_data$sex=="proportion.m"] <- "male"
figure4_data$sex[figure4_data$sex=="proportion.f"] <- "female"
figure4_data2_transform <- tidyr::spread(figure4_data,country,proportion)
write.csv(figure4_data2_transform,"figure4_data.csv",row.names = FALSE,fileEncoding = "UTF-8")


###Plotting
ggplot(plot_PSAJO,aes(x=proportion,y=country,fill=sex))+
  geom_col()+
  labs(y="country",fill="sex")+
  scale_fill_discrete(label=c("female","male"))+
  theme_classic()+
  guides(y="axis_nested")+
  theme(legend.position = "bottom",
        legend.key.size = unit(15,"pt"),
        legend.box.spacing = unit(2,"pt"),
        legend.text = element_text(size = 15,family = "serif"),
        legend.title = element_text(size = 15,family = "serif"),
        axis.title= element_text(size = 15,family = "serif"),
        axis.text = element_text(size = 10,family = "serif"),
        strip.text = element_text(size = 15,family = "serif"),
        strip.background = element_rect(fill = NA,color = NA),
        panel.border = element_rect(fill = NA,color = "black"))+
  scale_x_continuous(breaks = seq(0,1,by=0.1),expand = c(0.01,0))+
  facet_wrap(~weird.x,scales = "free")




