install.packages("devtools")
devtools::install_github("jhudsl/collegeIncome")
library(collegeIncome)
data(college)

devtools::install_github("jhudsl/matahari")
library(matahari)

dance_start(value = FALSE, contents = FALSE)

dim(college)
head(college)

library(dplyr)
myCollege <- mutate(college,
                    major = as.factor(major),
                    major_category = as.factor(major_category))
summary(myCollege)

library(ggplot2)
myCollegeMajorCategory <- group_by(myCollege, major_category) %>%
    summarise(mean_income = mean(median), 
              tot_persons = sum(total),
              tot_sample_size = sum(sample_size))
myCollegeMajorCategory

ggplot(data = myCollegeMajorCategory, aes(x = mean_income, y = major_category)) + 
    geom_bar(stat = "identity") + 
    geom_vline(xintercept = mean(myCollegeMajorCategory$mean_income))

fit <- lm(median ~ major_category, data = myCollege)
summary(fit)

dance_save("./college_major_analysis.rds")