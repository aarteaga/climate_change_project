require(ggplot2)
require(reshape2)
#source("predict_emissions.R")

shinyServer(
  function(input, output) {
      
    output$myplot <- renderPlot({
      
      #final_data <- complete_data(input$china_rate, input$usa_rate, input$row_rate, data) 
      ##
      if (input$checkbox == TRUE) {
        china_rate <- base_china_rate
        usa_rate <- base_usa_rate
        rest_of_world_rate <- base_rest_of_world_rate  
      } else {
        china_rate <- input$china_rate
        usa_rate <- input$usa_rate
        rest_of_world_rate <- input$row_rate
      }
      
      world_rate <- china_rate + usa_rate + rest_of_world_rate
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
      
      ggplot(data, aes(x = year, y = world, colour= "World")) +
      geom_line() +
      geom_line(mapping = aes(y = usa, colour = "USA") ) +
      geom_line(mapping = aes(y = china, colour = "China")) +
      geom_line(mapping = aes(y = rest_of_world, colour = "Rest of World")) +
      geom_line(mapping = aes(y = predict_world, colour= "World"), lwd = 1.3, lty = "dashed") +
      geom_line(mapping = aes(y = predict_usa, colour= "USA"), lwd = 1.3, lty = "dashed") +
      geom_line(mapping = aes(y = predict_china, colour= "China"), lwd = 1.3, lty = "dashed") +
      geom_line(mapping = aes(y = predict_rest_of_world, colour= "Rest of World"), lwd = 1.3, lty = "dashed") +
      labs(title = "CO2 Emissions, past and future scenarios") +
      ylab("CO2 millon tons per year")  +
      scale_colour_manual("", 
                    breaks = c("World", "USA", "China", "Rest of World"),
                    values = c("red", "green", "black", "blue"))

      
      })
    
  }
)