#setwd("F:/lana/home/coursera/spe_data_analsysis/9_data_products/climate_change_project")
# This R code, reads the data from the IEA and prepares them
# for later figure.
# The data are in an excel file read with the XLConnect library
library(XLConnect)
iea_url="http://www.iea.org/media/freepublications/2013pubs/CO2HighlightsExceltables.xls"
download.file(iea_url, "CO2HighlightsExceltables.xls", method="wget")
datedownloaded <- date()
wb <- loadWorkbook("CO2HighlightsExceltables.xls", create = FALSE)
coltypes <- rep("numeric", 42)
coltypes[1] <- "character"
raw_data <- readWorksheet(wb, sheet = "CO2 SA", startRow = 3, colTypes = coltypes)
# The data have to be trasposed as they were written in rows 
# in the original file
data0 <- as.data.frame(t(raw_data[,-1]))
names(data0) <- raw_data[,1]
names(data0) <- gsub(" ", "", names(data0))
data <- data.frame( year = data0$million ,
                    china = data0$People ,
                    usa = data0$UnitedStates , 
                    world = data0$World)
# After getting the data some data munging to read years as date
# and calculation of the rest of the world values, the values of the world
# except the two main powers: China and USA
data$rest_of_world <- data$world - data$china -data$usa
data$year <- ISOdate(data$year, 01, 01)

#The base CO2 emission rates are calculated in a simple maner.
#Just the average of change in the last 10 years for each country.
years <- length(data$china)
last_china <- data$china[years]
last_usa <- data$usa[years]
last_rest_of_world <- data$rest_of_world[years]
base_china_rate <- (data$china[years] - data$china[years-10]) / 10
base_usa_rate <- (data$usa[years] - data$usa[years-10]) / 10
base_rest_of_world_rate <- (data$rest_of_world[years] - data$rest_of_world[years-10]) / 10
base_world_rate <- base_china_rate + base_usa_rate + base_rest_of_world_rate
