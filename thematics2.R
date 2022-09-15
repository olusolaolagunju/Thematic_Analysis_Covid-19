install.packages(c("tidyverse", "tidytext", "widyr", "igraph", "ggraph"))

library(tidyverse)
library(tidytext)
library(widyr)
library(ggraph)
library(igraph)

#Exploratory
Covid_perception %>% 
  head() %>% 
  pull(text)


# breaking down each users reveiw by into a single words

Covid_perception %>% 
  unnest_tokens(output = word, input =text)

# checking the frequency of each text column

Covid_perception %>% 
  unnest_tokens(output = word, input =text) %>% 
  count(word, sort = TRUE)


# review the words by filtering  out words used multiple times 
#by a single respondent 

review_words <- Covid_perception %>% 
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words, by = "word") %>% 
  filter(str_detect(word, "[:alpha]")) %>% 
  distinct()



# counting the number of times a word was used by all respondents
review_words %>% 
  count(word, name = "users_n", sort = TRUE)


# filtering words used by at least 2 people

covid_respondent_who_mentioned_words <- review_words %>% 
  count(word, name = "users_n") %>% 
  filter(users_n >=2)


# use pearson correlation to correlate words that often appear together

covid_correlation <- review_words %>% 
  semi_join(covid_respondent_who_mentioned_words, by = "word") %>% 
  pairwise_cor(item = word, feature = Users) %>% 
  filter(correlation >= 0.25) #%>% 
  #count(correlation, sort = TRUE)



#5 plot a word network plot (a graph to show how the words correlate)
graph_from_data_frame(d = covid_correlation,
                      vertices = covid_respondent_who_mentioned_words %>% 
                        semi_join(covid_correlation, by = c("word" = "item1"))) %>% 
  ggraph(layout = "fr")+
  geom_edge_link(aes(alpha = correlation))+
  geom_node_point()+
  geom_node_text(aes(label = name, color =users_n), repel = TRUE)




## cleaning up the code
# function to generate a word graph
generate_word_graph <-  function(review_words, 
                                 minimum_users_n = 2, 
                                 minimum_correlation = -1){
  covid_respondent_who_mentioned_words <- review_words %>% 
    count(word, name = "users_n") %>% 
    filter(users_n >=minimum_users_n)
  
  covid_correlation <- review_words %>% 
    semi_join(covid_respondent_who_mentioned_words, by = "word") %>% 
    pairwise_cor(item = word, feature = Users) %>% 
    filter(correlation >= minimum_correlation) 
  
  graph_from_data_frame(d = covid_correlation,
                        vertices = covid_respondent_who_mentioned_words %>% 
                          semi_join(covid_correlation, by = (c("word" = "item1")))) %>% 
    ggraph(layout = "fr")+
    geom_edge_link(aes(alpha = correlation))+
    geom_node_point()+
    geom_node_text(aes(label = name, color =users_n), repel = TRUE)
}

review_words %>% 
  generate_word_graph(minimum_users_n = 2,
                      minimum_correlation = 0.25)

review_words %>% 
  generate_word_graph(minimum_users_n = 2,
                      minimum_correlation = 0.2)



ggsave("covid_thematic_2_.25.png")
