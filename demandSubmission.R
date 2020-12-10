library(tidyverse)
library(DataExplorer)
library(lubridate)
library(forecast)
library(prophet)
library(beepr)

train <- read_csv("../input/demand-forecasting-kernels-only/train.csv") %>% 
  rename(ds = date, y = sales) %>% 
  mutate(store = as_factor(store),
         item = as_factor(item))
test <- read_csv("../input/demand-forecasting-kernels-only/test.csv") %>% 
  rename(ds = date) %>% 
  mutate(store = as_factor(store),
         item = as_factor(item))

pf <- prophet() %>% 
  add_regressor('item') %>%
  add_regressor('store') %>%
  add_country_holidays('US') %>%
  fit.prophet(demand)

forecast <- predict(pf, test)

write_csv(tibble(id = test$id, sale = preds$yhat), "submission.csv")


# sarima111 <- Arima(demandAvgs$sales, order = c(1, 1, 1),
#                    seasonal = list(order = c(1, 1, 1), period = 52),
#                    method = "CSS")



# plot(Week,WebSearch,pch=19, main = "Data & fitted trend line")
# lines(Week,fit.vals,col="red",lwd=3)
