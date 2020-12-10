library(tidyverse)
library(lubridate)
library(prophet)
library(beepr)

demand <- read_csv("data/train.csv") %>%
  rename(ds = date, y = sales) %>%
  mutate(store = as_factor(store),
         item = as_factor(item))

test <- read_csv('data/test.csv') %>%
  rename(ds = date) %>%
  mutate(store = as_factor(store),
         item = as_factor(item))

# bf_days <- as_date(c("2013-11-29", "2014-11-28", "2015-11-27",
#                      "2016-11-25", "2017-11-24"))
# 
# demandTrain <- read_csv('data/train.csv') %>% 
#   mutate(across(c(store, item), as_factor),
#          week = week(date),
#          month = month.abb[month(date)],
#          weekday = weekdays(date),
#          day = day(date),
#          black_friday = if_else(date %in% bf_days, 1, 0))

demand %>% 
  group_by(month, day) %>% 
  summarise(sales = mean(sales)) %>%
  ggplot(aes(month, sales)) +
  geom_bar(stat = "identity")

pf <- prophet() %>% 
  add_regressor('item') %>%
  add_regressor('store') %>%
  # add_regressor('black_friday') %>% 
  add_country_holidays('US') %>%
  fit.prophet(demand)
           
forecast <- predict(pf, test)

write_csv(tibble(id = test$id, sales = forecast$yhat), "submission.csv")

test$ds

par(mar=c(.01,.01,.01,.01))
plot(forecast)
