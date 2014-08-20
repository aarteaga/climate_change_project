# Taking the base emissions (average of last 10 years) and 
# the function rate_range, defined in anither file, 
# the values of the limits for the sliders are defined
a <- rate_range(base_china_rate, last_china)
min_china_rate <- a$min_rate
max_china_rate <- a$max_rate
step_china_rate <- a$step_rate

a <- rate_range(base_usa_rate, last_usa)
min_usa_rate <- a$min_rate
max_usa_rate <- a$max_rate
step_usa_rate <- a$step_rate

a <- rate_range(base_rest_of_world_rate, last_rest_of_world)
min_rest_of_world_rate <- a$min_rate
max_rest_of_world_rate <- a$max_rate
step_rest_of_world_rate <- a$step_rate