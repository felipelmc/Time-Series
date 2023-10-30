# Purpose: create a csv file from a tsibble object

library(tsibble)

dataset1 <- tsibbledata::aus_production
dataset2 <- tsibbledata::gafa_stock

# export to csv
write.csv(dataset1, "data/aus_production.csv", row.names = FALSE)
write.csv(dataset2, "data/gafa_stock.csv", row.names = FALSE)