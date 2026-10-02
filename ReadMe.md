# Profiling Chinese Participants in Psych. Sci.
This project aimed at exploring the representativeness of Chinese participants in psychological science. We analysed participants data from 1,000 empirical articles published in five mainstream Chinese psychological journals and 27 large-scale international collaborative projects.

The Stage 2 Registered Report of our project has been recommended by [PCI-RR](https://doi.org/10.24072/pci.rr.101701)

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

- **Stage 1 recommendation**: https://rr.peercommunityin.org/articles/rec?id=103
- **Stage 2 recommendation**: https://rr.peercommunityin.org/articles/rec?id=1701
- **preprint**: https://osf.io/preprints/psyarxiv/j8xgf

## Software
We used [R 4.1.1](https://www.R-project.org/) and [JASP 0.95.4](https://jasp-stats.org/) for data reprocessing, analyses, and visualization.

## About the folders

This project includes the following folders, each of which has an "About" file (`.md`) describing its content:

- **1_Protocol**: includes the project’s early *OSF* pre-registration, the Stage 1 of the PCI Registered Report text with its review files, and the supplementary material of Stage 2.
- **2_Data_Extraction**: includes data from the 1,000 empirical articles published in five mainstream Chinese psychological journals (`2_1_CHN_Journal_Code`), partial data from the 27 large-scale international collaborative projects (`2_2_BTS`), and supporting analysis data such as the 6th and 7th National Census (`2_3_Analyze_supporting_data`).
- **3_Data_Analysis**: includes the code for the formal analyses (`Notebook_Data_Analysis_CHN_Sample_Stage2_RR_V2`, `Notebook_Exploration_Analysis`), the intermediate data derived from `2_Data_Extraction` (`3_1_Intermediate_Data`), and the generated visualization files (`3_2_Image`).
- **4_Reports**: contains the communication documents from the project implementation, including the presentations given at the 24th National Academic Congress of Psychology (NACP 2023) and at BTSCON2025.

The folder structure is outlined below:

```
.
|-root_dir
|---1_Protocol
|-------About_Protocol.md
|-------1_1_Preregistration
|-------1_2_Reg_Report_Stage_1
|---------1_2_1_Reg_Report_Stage_1_Protocol
|---------1_2_2_Reg_Report_Stage_1_Reviewer_Round1
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round2
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round3
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round4
|---------1_2_3_Reg_Report_Stage_1_Reviewer_Round5
|---------1_2_4_Reg_Report_Stage_1_Analysis
|-------1_3_Stage_2_Suppl_Material
|
|---2_Data_Extraction
|------About_Data_Extration.md
|------2_1_CHN_Journal_Code
|---------2_1_1_Article_Numbering
|---------2_1_2_Article_Sampling
|---------2_1_3_Code_Manual
|---------2_1_4_Extract_Data
|-----------2_1_4_1_Article_Coding
|-----------2_2_4_2_Article_Proofreading
|-----------2_1_4_3_Article_Replaced
|------2_2_BTS
|------2_3_Analyze_supporting_data
|
|---3_Data_Analysis
|------About_Data_Analysis.md
|------3_1_Intermediate_Data
|------3_2_Image
|
|---4_Reports
|-------About_Reports.md
|-------4_1_Conference1_NACP2023
|-------4_2_Conference2_BTSCON2025
```
