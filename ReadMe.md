# Profiling Chinese Participants in Psych. Sci.
This project aimed at exploring the representativeness of Chinese participants in psychological science. We analysed participants data from 1,000 empirical articles published in five mainstream Chinese psychological journals and 27 large-scale international collaborative projects.

The Stage 1 Registered Report of our project has been accepted in principle by [PCI-RR](https://osf.io/ehw54)

## [![CC BY-NC 4.0][cc-by-nc-shield]][cc-by-nc]

This work is licensed under a
[Creative Commons Attribution-NonCommercial 4.0 International License][cc-by-nc].

[![CC BY-NC 4.0][cc-by-nc-image]][cc-by-nc]

[cc-by-nc]: https://creativecommons.org/licenses/by-nc/4.0/
[cc-by-nc-image]: https://licensebuttons.net/l/by-nc/4.0/88x31.png
[cc-by-nc-shield]: https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg

## Authors
**Lei Yue**, School of Psychology, Nanjing Normal University;

**Weiwei Zhang**, Psychological Service Center, Shenzhen City Polytechnic;

**Chunxiao Wang**, School of Education, Tsinghua University;

**Xi-Nian Zuo**, State Key Laboratory of Cognitive Neuroscience and Learning, International Data Group/McGovern Institute for Brain Research, Beijing Normal University;

**Hu Chuan-Peng**(Corresponding author), School of Psychology, Nanjing Normal University, email:
hu.chuan-peng@nnu.edu.cn, or, hcp4715@hotmail.com

## Related links

- **Projects materials**: https://osf.io/avb7t/
- **Preregistration Report**: https://osf.io/ehw54
- **preprint**: to-be-available

## Software
We used [R 4.1.1](https://www.R-project.org/) and [JASP 0.95.4](https://jasp-stats.org/) for data reprocessing, analyses, and visualization.

## About the folders

This project include the follow folders, each has an "about" file describing its content:

- **1_Protocol**: includes the project’s early *OSF* pre-registration, the stage 1 of PCI Registered Report text, and review comments.
- **2_Data_Extraction**: it includes data from 1,000 empirical studies published in five mainstream Chinese psychological journals, data from 27 large-scale international collaborative projects, and others data (e.g., 7thCensus).
- **3_Data_Analysis**: includes the code for formal analyses and the generated visualization files
- **4_Reports**: contains communication documents from the project implementation, such as conference presentations.

The folder structure is outlined below:

```
.
|-root_dir
|---1_Protocol
|-------About_Protocol.txt
|-------1_1_Preregistration
|-------1_2_Reg_Report_Stage_1
|---------1_2_1_Reg_Report_Stage_1_Protocol
|---------1_2_2_Reg_Report_Stage_1_Reviewer_Round1
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round2
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round3
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round4
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round5
|---------1_2_4_Reg_Report_Stage_1_Analysis
|
|---2_Data_Extraction
|------About_Data_Extration.txt
|------2_1_CHN_Journal_Data
|---------2_1_1_Ariticle_Numbering
|---------2_1_2_Article_Sampling
|---------2_1_3_Article_Download
|---------2_1_4_Code_Manual
|---------2_1_5_Extract_Data
|---------Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V1.Rmd
|---------Coding_check.R
|------2_2_BTS_Data
|------Notebook_Coding_Reliability_Analysis.Rmd
|
|---3_Data_Analysis
|------About_Data_Analysis.txt
|------3_1_Intermediate_Data
|------3_2_Image
|------Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2.Rmd
|------Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2.R
|------Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2.html
|------Notebook_Exploration_Analysis.Rmd
|------Notebook_Exploration_Analysis.html
|
|---4_Reports
|-------About_Reports.txt
|-------4_1_Project_reports [slides]
|-------4_2_Conference1__NACP2023
|-------4_3_Conference2_BTSCON2025
```

