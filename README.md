# Thematic_Analysis_Covid-19

## Purpose: To examine parents' perception of covid-19 vaccine for children in Southern Ethiopia
---


The objective of this project was to examine the perception of parents of the covid-19 vaccine in Southern Sudan. A public dataset hosted on figshare.com was used (Zemedu, 2022) for this analysis. The dataset consists of 20 excel sheets each representing an interview session from respondents. Twenty parents were interviewed in-depth and answered structured questions about their perception of the covid-19 vaccine.  The sheets were compiled into a single sheet and the responses were merged under similar headings and analyzed with R software. 
The R software extracted codes representing frequently mentioned words used together by all the respondents. Themes were then generated from the codes. 
To break it down into simpler steps: 
1.	Each interviewee's responses were broken down into a single word and then words used multiple times by a respondent were removed
2.	The response table was merged with a stop word table which consists of generally used words including “The”, “he”, “I”, and punctuation signs. This was done to remain only words that drive home the point made by each respondent
3.	To ensure that the codes generated were frequently used words by most respondents, the data were filtered to retain only words mentioned by a minimum of 5 people out of 20.
4.	Person correlation was done to obtain words that were commonly used or appear together such as “adequate information”, “health care”
5.	Data was plotted to include features such as a minimum number of users and or a range of correlations to generate word codes
Lastly, two major themes emerged from the generated codes:
Themes
1.	Information gap about the covid-19 vaccine: 
* Most of the respondents do not know about the vaccine and were reluctant to take the vaccine  
* Misconception about covid-19 vaccines being for only health care workers and elderly people 
2. Concerns about the safety and future side effects of  covid-19 vaccine: 
*	Respondents expressed fear of the possible side effects of the vaccine, especially on children, and doubts about the effectiveness of the vaccine
Dataset obtained from figshare.com (Zemedu, A. (2022). parents' perception of covid-19 vaccine for children in Southern Ethiopia)
