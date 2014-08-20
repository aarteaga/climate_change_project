source("read_data.R")
source("rate_range.R")
source("slider_limits.R")
shinyUI(fluidPage(
  titlePanel("CO2 emissions scenarios"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Choose emission rates for those Countries"),
      em("Increment of CO2 emissions per year CO2 millions of tonnes per year for the most important economies and emitters and the rest of the world"),
      p("The sliders allow checking different scenarios. The checkbox disables sliders values and inputs Business as Usual values (last 10 years average)"),     
      sliderInput('china_rate', 'China',
                  value = base_china_rate, 
                  min = min_china_rate, 
                  max = max_china_rate, 
                  step = step_china_rate),
      
      sliderInput('usa_rate', 'USA',
                  value = base_usa_rate, 
                  min = min_usa_rate, 
                  max = max_usa_rate, 
                  step = step_usa_rate),
      
      sliderInput('row_rate', 'Rest of the World',
                  value = base_rest_of_world_rate, 
                  min = min_rest_of_world_rate, 
                  max = max_rest_of_world_rate, 
                  step = step_rest_of_world_rate), 
      
      checkboxInput("checkbox", "Bussiness as ussual Values", value = FALSE)
      
    ),
    mainPanel(
      h4("The result predicting up to 2050"),
      plotOutput('myplot'),
      p("Figure containing emissions measured from 1970 and predicted up to 2050")
    )
)))