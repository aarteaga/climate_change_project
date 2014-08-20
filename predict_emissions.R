complete_data <- function (china_rate, usa_rate, rest_of_world_rate, data0) {
  world_rate <- china_rate + usa_rate + rest_of_world_rate
  data <-data0
  data$predict_world <- rep(NA, years)
  data$predict_usa <- rep(NA, years)
  data$predict_china <- rep(NA, years)
  data$predict_rest_of_world <- rep(NA, years)
  data$past <- rep(1, years)
  last_china <- data$china[years]
  last_usa <- data$usa[years]
  last_world <- data$world[years]
  last_rest_of_world <- data$rest_of_world[years]
  for (urte in 2012:2050) {
    a <- data.frame(
      year = ISOdate(urte, 01, 01),
      china = NA, usa = NA, world =NA, rest_of_world = NA,
      predict_china = last_china + china_rate,
      predict_usa = last_usa + usa_rate,
      predict_world = last_world + world_rate,
      predict_rest_of_world = last_rest_of_world + rest_of_world_rate,
      past= 0
    )
    data <- rbind(data, a)
    last_china = last_china + china_rate
    last_usa = last_usa + usa_rate
    last_world = last_world + world_rate
    last_rest_of_world = last_rest_of_world + rest_of_world_rate
    
  }
}