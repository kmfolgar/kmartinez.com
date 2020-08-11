---
layout: post
title: "Age-Adjusted Rates in R"
date: 2020-08-11
---

Here is just some random code for future use. 


## Standard population


```r
#https://seer.cancer.gov/stdpopulations/stdpopdic.html

standard_pop <- read.fwf("https://seer.cancer.gov/stdpopulations/stdpop.18ages.txt", widths = c(3,3,8),  
                          header = 0, col.names = c('Standard_ID','Age','Standard_Population')) %>% 
                filter(Standard_ID==009 ) %>% ## 009 = World (WHO 2000-2025) Std Million (18 age groups) 
                mutate(AGE = (Age-1)*5,  ## as the numbers are 1 to 18, the formula X-1 * 5 will give us the value.
                       Proportion = Standard_Population/sum(Standard_Population)) %>% 
                select(AGE, Standard_Population, Proportion) %>% 
      mutate(AGE=ifelse(AGE>=80,80, AGE)) %>%
      group_by(AGE) %>% 
      summarise(Standard_Population=sum(Standard_Population), Proportion=sum(Proportion)) %>% 
      ungroup()

standard_pop %>% 
  #filter(AGE>5) %>% 
  mutate(prop_test = Standard_Population / sum(Standard_Population)) %>% 
  mutate(sum(Proportion), sum(prop_test))
```



Data Sample

| location  |  AGE  |   counts |  population|
|---|---|---|---|
|Guatemala   | 0 |  35 | 10250  |   
|Guatemala   | 5|  25 |  12859 |   
|Panama  |  5 |  50 |  80253 |
|Panama  |  5 |  38 |  21224 |
|Costa Rica | 20 |  25 | 15351 |

You must have the same number of age groups as your `standard_pop` to be abble to merge, and remember to replace all the missings with `0`
 in the `counts` column.
 
 ```r
data  %>%
 mutate(rate=counts/population) %>% 
  left_join(standard_pop, by = "AGE") %>% 
  group_by(location) %>% 
  summarise(adjusted1= weighted.mean(rate, Standard_Population), 
			adjusted2= sum(rate*Proportion))
```
In the standard_pop you can have proportions or total numbers to adjust your rates.   Both work fine, if you choice to work with total numbers you must use `weighted.mean()`, 
if you choice to use proportions you can use `sum(rate*Proportion)` 
