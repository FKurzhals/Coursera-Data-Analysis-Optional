if(!file.exists("./data")){
        dir.create("./data")
}

install.packages("devtools")
devtools::install_github("jhudsl/collegeIncome")
library(collegeIncome)
data(college)

devtools::install_github("jhudsl/matahari")
library(matahari)

#dance_start(value = FALSE, contents = FALSE)

library(tidyverse)

college <- as_tibble(college) %>%
        mutate(major_category = factor(major_category))

str(college)

ggplot(data = college, aes(x = major_category, y = perc_employed_fulltime_yearround )) +
        geom_point(alpha = 0.3, size = 2)+
        theme_bw() + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

ggplot(data = college, aes(x = major_category, y = median )) +
        geom_point(alpha = 0.3, size = 2)+
        theme_bw() + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

ggplot(data = college, aes(x = major_category, y = median )) +
        geom_boxplot(alpha = 0.3, size = 1, outlier.size = 3, outlier.shape = 21, outlier.fill =  "red", outlier.color = "black", outlier.alpha = .6)+
        theme_bw() + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) + 
        geom_text(data = . %>% filter(median == max(median)), aes(label = major), hjust = -.05, size = 3)

fit0 <- lm(median ~ relevel(major_category, "Interdisciplinary"), data = college) 

summary(fit0)

#dance_save("./data/college_major_analysis.rds")