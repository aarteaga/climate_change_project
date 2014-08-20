rate_range <- function ( initial_rate, last_emission  ) {
  if (initial_rate > 0) {
    if (initial_rate / last_emission > 0.05) {
      min_rate <- -initial_rate
      max_rate <- initial_rate
      step_rate <- initial_rate / 5.0
    } else {
      min_rate <- -0.05 * last_emission
      max_rate <- 0.05 * last_emission
      step_rate <- 0.01 * last_emission
    }
    
    
  } else {
    min_rate <- initial_rate - 0.05 * last_emission
    max_rate <- initial_rate + 0.05 * last_emission
    step_rate <- 0.01 * last_emission
  }
  
  emaitza <- data.frame( min_rate = min_rate, max_rate = max_rate, step_rate = step_rate)
  emaitza
}