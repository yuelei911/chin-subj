
rm(list = ls())


# lib packages
library(openxlsx)
library(tidyverse)
library(here)


# load data
Chin_Subj_articles_replaced_twocoder <- readxl::read_xlsx(here("2_Data_Extraction","2_1_CHN_Journal_Code",
                                                               "2_1_5_Extract_Data","2_5_5_3_Article_Replaced",
                                                               "Chin_Subj_articles_replaced_CE.xlsx"))


# add check and final
## create 238rows
complete_rows <- data.frame(rows = 1:240)

## merge the two data.frame
Chin_Subj_articles_replaced_preCE <- merge(Chin_Subj_articles_replaced_twocoder,
                                              complete_rows,by = "rows",all = TRUE)

## fill Coder
Coder_check <- seq(3, 240, by = 4)
Coder_final <- seq(4,240, by = 4)


Chin_Subj_articles_replaced_preCE <- Chin_Subj_articles_replaced_preCE %>% 
  dplyr::mutate(Coder = case_when(rows %in% Coder_check ~ "check",
                                  rows %in% Coder_final ~ "final",
                                  TRUE ~ Coder))

df <- Chin_Subj_articles_replaced_preCE
# check score

## check col
compare_col <- Chin_Subj_articles_replaced_preCE %>% 
  dplyr::select(-c(rows,Coder,Coding_Basis_N,Remark3))

compare_col <- names(compare_col)


# lappy all col
for (i in 0:60) {
  row1 <- 1 + 4 * i
  row2 <- 2 + 4 * i
  check_row <- 3 + 4 * i
  final_row <- 4 + 4 * i
  
  if (row1 > nrow(df) || row2 > nrow(df) || check_row > nrow(df) || final_row > nrow(df)) {
    break
  }
  
 
  

  for (col in compare_col) {
    value1 <- df[row1, col]
    value2 <- df[row2, col]
    
    # score 
    if (is.na(value1) && is.na(value2)) {
      score <- 3  
      
    } else if (is.na(value1) || is.na(value2)) {
      score <- 1  
      
    } else if (value1 == value2) {
      score <- 3 
      
    } else if (grepl(value1, value2, fixed = TRUE) || grepl(value2, value1, fixed = TRUE)) {
      score <- 2  
      
    } else {
      score <- 1  
      
    }
    
    df[check_row, col] <- score
    
    ## fill final
    if (score == 3) {
      df[final_row, col] <- value1  
    } else {
      df[final_row, col] <- NA    
    
      }
  }
  
}


## write xlsx and manual checking

write.xlsx(df,"Chin_Subj_articles_replaced_CE.xlsx")

  
