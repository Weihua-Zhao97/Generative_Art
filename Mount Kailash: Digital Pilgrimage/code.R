library(ggplot2)
library(dplyr)
library(tidyverse)
library(gganimate)

#data for mountain
m <- data.frame(
  x = c(1, 1, 1, 1.5, 3.5, 5, 6, 6.5, 7, 8, 10, 10),
  y = c(0, 3, 3, 3, 7, 8.5, 8, 7, 6.5, 6, 3, 0))

r <- data.frame(
  x = c(1, 1, 3, 4, 5.5, 7, 10, 10),
  y = c(0, 2.5, 2, 0.5, 0.3, 2, 2.6, 0))


# data for shade
m_fancy_simple <- m %>%
  mutate(
    x_mean = mean(x),
    x_off = ifelse(x < x_mean, x + 0.3, 
                   ifelse(x > x_mean, x - 0.3, NA))
  ) %>%
  tidyr::pivot_longer(
    cols = c(x, x_off),
    names_to = "type",
    values_to = "x_val",
    values_drop_na = TRUE
  ) %>%
  mutate(
    y = ifelse(type == "x_off", y - 0.1, y)
  ) %>%
  select(x = x_val, y) %>%
  arrange(y, x) %>%
  filter(y >= min(m$y))



# data for snow
set.seed(2026)  
n_snowflakes <- 100  
snow <- data.frame(
  snowflake_id = 1:n_snowflakes,
  x = runif(n_snowflakes, 1, 10),  
  y_start = runif(n_snowflakes, 11, 15), 
  size = runif(n_snowflakes, 0.5, 2),  
  speed = runif(n_snowflakes, 0.2, 0.8),  
  wobble = runif(n_snowflakes, 0.1, 0.5)  
)


# prepare data for animation
time_points <- seq(0, 10, by = 0.5)  

snow_anim <- map_df(time_points, function(t) {
  snow %>%
    mutate(
      y = y_start - t * speed * 3,  
      x = x + sin(t * wobble) * 0.5, 
      time = t,
      y = ifelse(y < 0, y_start, y)
    ) %>%
    filter(y > 0 & y < 11 & x >= 1 & x <= 10) 
})


# prepare the plot
mountain_with_snow <- ggplot() +
  # sky
  geom_raster(
    data = expand.grid(
      x = seq(1, 10, length.out = 200),  
      y = seq(0, 11, length.out = 200)   
    ),
    aes(x = x, y = y, fill = y)
  ) +
  scale_fill_gradientn(
    colors = c("black", "#0D1B4F", "#1E3A8A", "#0D1B4F"),
    guide = "none"
  ) +
  
  # Snowflake
  geom_point(data = snow_anim, 
             aes(x = x, y = y, group = snowflake_id),
             color = "white", 
             shape = 8,                     
             size = snow_anim$size,         
             alpha = 0.8) +                 
  
  # mountain
  geom_polygon(data = m, aes(x, y), 
               fill = rgb(1, 1, 1, alpha = 0.5)) +
  
  # shade
  geom_polygon(data = m_fancy_simple, aes(x, y), 
               fill = rgb(0.9, 0.9, 0.9, alpha = 0.7)) +
  
  # rocks
  geom_polygon(data = r, aes(x, y), fill = "black") +
  
  # moon
  geom_point(aes(x = 8.5, y = 10),           
             size = 17, 
             color = "#FEF8B9", 
             fill = "#FEF8B9", 
             shape = 21, 
             alpha = 0.5) +
  
  theme_void() +  
  theme(
    plot.background = element_rect(fill = "transparent"),
    plot.margin = margin(0, 0, 0, 0)
  ) +
  
  coord_cartesian(xlim = c(1, 10), ylim = c(0, 11)) +
  
  # set animation effects
  transition_time(time) +                    
  ease_aes('sine-in-out') +                  
  shadow_wake(wake_length = 0.1, alpha = FALSE)  

# generate the gif
mountain_snow_animation <- animate(
  mountain_with_snow,
  nframes = 100,        
  fps = 20,             
  width = 600,          
  height = 660,         
  renderer = gifski_renderer(),
  bg = "transparent"
)


# save file
anim_save("mountain_christmas_snow.gif", mountain_snow_animation)
