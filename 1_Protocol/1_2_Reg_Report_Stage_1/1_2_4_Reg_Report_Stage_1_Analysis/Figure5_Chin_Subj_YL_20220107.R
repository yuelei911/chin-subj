
###Loading the package
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggridges)
library(openxlsx)
library(ggh4x)

###Reading the data of Jones et al.(2021) for non_WEIRD region
PSA_Jones_Other <- read.csv("quest_data.csv") %>% 
  select(user_id,dv,q_name) %>% 
  group_by(user_id,q_name) %>% 
  filter(row_number()==1) %>% 
  ungroup() %>% 
  spread(q_name,dv,convert = TRUE) %>% 
  select(-V1)

###Merging data from Hong Kong, Macau and Taiwan with Chinese mainland
PSA_Jones_Other$country[PSA_Jones_Other$country=="TW"] <- "CN"
PSA_Jones_Other$country[PSA_Jones_Other$country=="HK"] <- "CN"
PSA_Jones_Other$country[PSA_Jones_Other$country=="MO"] <- "CN"

###Removing the NA value in age
PSAJO_2 <-  PSA_Jones_Other %>% 
  filter(!is.na(age))

###Selecting countries with sample >=30
PSAJO_filter <-  data.frame(table(PSAJO_2$country)) %>% 
  rename(country="Var1",value="Freq")%>%                    
  filter(value>=30)

PSAJO_filter$country

PSAJO_2 <-  PSAJO_2 %>% 
  filter(country=="AE"|country=="AR"|country=="AT"|country=="AU"|country=="BR"|country=="CA"|
           country=="CH"|country=="CL"|country=="CN"|country=="CO"|country=="DE"|country=="DK"|
           country=="EC"|country=="ES"|country=="FI"|country=="FR"|country=="GB"|country=="GR"| 
           country=="HU"|country=="IN"|country=="IR"|country=="IT"|country=="KE"|country=="MX"|
           country=="MY"|country=="NG"|country=="NL"|country=="NO"|country=="NZ"|country=="PE"|
           country=="PL"|country=="PT"|country=="RO"|country=="RS"|country=="RU"|country=="SE"|
           country=="SK"|country=="SV"|country=="TH"|country=="TR"|country=="UA"|country=="US"|
           country=="ZA")

regioncode <- read.xlsx("Chin_Subj_F4(5)_region.xlsx")
PSAJO_merge <- merge(PSAJO_2,regioncode,by.x = "country",by.y = "country_iso2")

###Calculating the average age for each country and ranking them in ascending order
M_PSAJO <- aggregate(PSAJO_merge$age,list(PSAJO_merge$country),mean) %>% 
  rename(country="Group.1",Mage="x") %>% 
  arrange(Mage)


###Looking the rank of country
M_PSAJO$country

###Factor levels are set to rank the plot by average age
PSAJO_merge$country <-  factor(PSAJO_merge$country,
                               levels = c("CA","NZ","ES","NL","MY","SK","RS","GB","US","HU",
                                          "TH","CO","PE","TR","AU","AE","PT","CH","IR","DK",
                                          "CN","SV","RO","FR","DE","RU","UA","NO","BR","CL",
                                          "NG","EC","ZA","PL","IT","GR","MX","IN","KE","AT",
                                          "FI","AR","SE"))

###Plotting
ggplot(PSAJO_merge,aes(age,country,fill=weird))+
  geom_density_ridges()+
  theme_classic()+
  guides(y="axis_nested")+
  facet_wrap(~weird,scales = "free")+
  coord_cartesian(clip = "off") +
  scale_y_discrete(expand = c(0,0))+
  scale_x_continuous(expand = c(0,0))+
  theme(legend.position = "none",
        axis.title.x = element_text(size = 15,family = "serif",vjust = -1),
        axis.title.y = element_text(size = 13,family = "serif",vjust = 1.5),
        axis.text = element_text(size = 12,family = "serif"),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(fill = NA,color = "black"),
        strip.background = element_rect(fill = NA,color=NA),
        strip.text = element_text(size = 15,family = "serif"))


