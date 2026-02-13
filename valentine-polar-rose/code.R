library(ggplot2)
library(tibble)
library(gganimate)

# ffmpeg_path = "D:/Users/ffmpeg-master-latest-win64-gpl-shared/bin/ffmpeg.exe"

palette_valentine_rose <- c(
  "#4a0f1f",
  "#6d1f35",
  "#8f344f",
  "#b04b6a",
  "#cf6f8a",
  "#e8a6b8",
  "#f4d4dd",
  "#fbf0f3"
)


polar_art_anim <- function(seed, n, palette) {
  
  set.seed(seed)
  
  dat <- tibble(
    frame = 1:n,                
    x0 = runif(n),
    y0 = runif(n),
    x1 = x0 + runif(n, -.2, .2),
    y1 = y0 + runif(n, -.2, .2),
    shade = runif(n)^0.7,
    width = runif(n)
  )
  
  ggplot(dat, aes(
    x = x0, y = y0,
    xend = x1, yend = y1,
    colour = shade,
    linewidth = width,
    group = frame              
  )) +
    geom_segment(show.legend = FALSE) +
    coord_polar() +
    scale_y_continuous(expand = c(0, 0), limits = c(0, 1)) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_colour_gradientn(colours = palette) +
    scale_linewidth(range = c(0.1, 10)) +
    theme_void() +
    theme(
      panel.background = element_rect(fill = "#fbf0f3", colour = NA),
      plot.background  = element_rect(fill = "#fbf0f3", colour = NA)
    ) +
    
    
    transition_states(
      frame,
      transition_length = 0,
      state_length = 1
    ) +
    shadow_mark(past = TRUE, future = FALSE, alpha = 1)
}

anim <- polar_art_anim(
  seed = 1,
  n = 6000,
  palette = palette_valentine_rose
)

animate(
  anim,
  nframes = 240,
  fps = 30,
  width = 800,
  height = 800,
  renderer = ffmpeg_renderer(ffmpeg = ffmpeg_path))
anim_save("rose.mp4",animation = last_animation())
