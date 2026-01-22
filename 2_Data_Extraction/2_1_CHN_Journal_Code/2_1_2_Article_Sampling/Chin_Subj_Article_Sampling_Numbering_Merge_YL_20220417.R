
###install package
library(openxlsx)

###check and set the file path
getwd()
setwd("C:/Users/DELL/Documents")

###load the data file
#2008
sampling2008 <- readxl::read_xlsx("Article2008_Numbering_Chin_Subj_YL_20210907.xlsx")
check2008 <- readxl::read_xlsx("Article2008_Sampling_Chin_Subj_RHX_20220417.xlsx")

#2021
sampling2021 <- readxl::read_xlsx("Article2021_Numbering_Chin_Subj_YL_20210907.xlsx")
check2021 <- readxl::read_xlsx("Article2021_Sampling_Chin_Subj_RHX_20220417.xlsx")

###merge the two file
#2008
Article2008_checked <- merge(sampling2008,check2008,by="Article ID")

#2021
Article2021_checked <- merge(sampling2021,check2021,by="Article ID")

###save the file
#2008
write.xlsx(Article2008_checked,"Chin_Subj_Article2008_Sampling_Check_YL_20220417.xlsx")

#2021
write.xlsx(Article2021_checked,"Chin_Subj_Article2021_Sampling_Check_YL_20220417.xlsx")
