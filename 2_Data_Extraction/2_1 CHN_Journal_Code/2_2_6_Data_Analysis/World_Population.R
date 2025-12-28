
rm(list = ls())

library(tidyverse)


## read world population data
wppdata <- read.csv("WPP2024.csv")


## select 2023 data
wppdata2 <- wppdata %>% 
  dplyr::select(Region..subregion..country.or.area..,ISO3.Alpha.code,Type,Year,Total.Population..as.of.1.January..thousands.) %>% 
  dplyr::filter(Year == 2023) %>% 
  dplyr::filter(Type == "Country/Area") %>% 
  dplyr::rename(ISO3 = 2,Population = 5) %>% 
  dplyr::mutate(Population = as.numeric(Population),
                Population = Population * 1000)




## read WEIRD data
load("H3_age_exploration.Rdata")

WEIRD2 <- WEIRD %>% 
  dplyr::rename(ISO3 = 4) %>% 
  dplyr::add_row(continent = NA,
                 country.name.en = NA,
                 iso2c = NA,
                 ISO3 = "XKX",
                 region = NA,
                 region23 = NA,
                 WEIRD = "WEIRD")

## combine data
wpp_WEIRD <- merge(wppdata2,WEIRD2)

wpp_WEIRD2 <- wpp_WEIRD %>% 
  dplyr::group_by(WEIRD) %>% 
  dplyr::summarise(num = sum(Population)) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(Prop = num/sum(num))

sum(wpp_WEIRD2$num) - sum(wppdata2$Population)


