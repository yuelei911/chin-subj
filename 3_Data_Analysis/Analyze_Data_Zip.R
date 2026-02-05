rm(list = ls())

# root path: \...\chin-subj
## -----------------------------------------------------------------------------------------
## BTS

pacman::p_load(readxl,here)

## load 27 projects data, BTS edu data and target population of BTS 
load(here::here("2_Data_Extraction", "2_2_BTS", "BTS.Rdata"))

## load BTS keywords' data
BTS_keywords <- readxl::read_xlsx(here::here("2_Data_Extraction", "2_2_BTS","BTS_keywords.xlsx"))

## save BTS
save(BTS,BTS_coding,BTS_edu_list, BTS_keywords,file = here::here("3_Data_Analysis", "3_1_Intermediate_Data", "BTS.RData"))

## ----------------------------------------------------------------------------------------
##Journal
## load the Journal repreprocess data,including coding data and other age data
load(here::here("2_Data_Extraction","2_1_CHN_Journal_Code","df_Pre_Stage2_Journal_Code.Rdata"))

## load Journal process data, manually processed and verified.
Journal_edu <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_edu.xlsx")

Journal_region_multiple <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_region_multiple.xlsx")

Journal_special_population <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_special_population.xlsx")
Journal_special_population_translation <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_special_population_translation.xlsx")

Journal_strings_age <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_strings_age.xlsx")

Journal_keywords <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_keywords.xlsx")
Journal_keywords_translation <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_1_CHN_Journal_Code\\Journal_keywords_translation.xlsx")

## save
save(df_stage2_Journal_Code2,
     Journal_articles_replace2,
     Journal_edu,
     Journal_otherage,
     Journal_strings_age,
     Journal_region_multiple,
     Journal_keywords,
     Journal_keywords_translation,
     Journal_special_population,
     Journal_special_population_translation,
     file = "D:\\chin-subj\\3_Data_Analysis\\3_1_Intermediate_Data\\Journal.Rdata")


## -------------------------------------------------------------------------------------
## analyze supporting data

load("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\WEIRD.Rdata")
load("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\Countrycodelist_iso2_iso3.Rdata")
load("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\ShanghaiRanking_psy.Rdata")

Census6_edu <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\Census6_edu.xlsx")
Census6_region <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\Census6_region.xlsx")

Census7_edu <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\Census7_edu.xlsx")
Census7_region <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\Census7_region.xlsx")

colour <- readxl::read_xlsx("D:\\chin-subj\\2_Data_Extraction\\2_3_Analyze_supporting_data\\colour.xlsx")

save(Census6_edu,Census6_region,
     Census7_edu,Census7_region,
     colour,WEIRD,Countrycodelist_iso2_iso3,
     ShanghaiRanking_psy2021,ShanghaiRanking_appliedpsy2021,
     file =  "D:\\chin-subj\\3_Data_Analysis\\3_1_Intermediate_Data\\Analyze_supporting_data.Rdata")


## -------------------------------------------------------------------------------------------
## Rmd trans R
library(knitr)

purl(input = "Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2.Rmd",
     output = "Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2.R")
