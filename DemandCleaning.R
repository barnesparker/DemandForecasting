library(tidyverse)
library(DataExplorer)
library(lubridate)
library(forecast)
library()
demand <- read_csv("data/train.csv") 

demand <- demand %>% 
  mutate(week = as_date(cut(date, 'week')),
         month = as_date(cut(date, 'month')))

demandAvgs <- demand %>% 

demand %>% 
  group_by(week) %>% 
  summarise(avgSales = mean(sales)) %>% 
  ggplot(aes(x = week, y = avgSales)) +
  geom_line()

sarima111 <- Arima(,order = c(1, 1, 1),
                   seasonal = list(order = c(1, 1, 1), period = 180))

