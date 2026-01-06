library(ggplot2)
library(tibble)
library(dplyr)

# Function: Generate polar art data + map shade values to specific color codes
# Returns dataframe with pre-computed color values for each data point

polar_art_data_with_colors <- function(seed, n, palette_colors) {
  set.seed(seed)
  
  dat <- tibble(
    x0 = runif(n),          # Random x-coordinate for segment start (0-1)
    y0 = runif(n),          # Random y-coordinate for segment start (0-1)
    x1 = pmin(pmax(x0 + runif(n, min = -.2, max = .2), 0), 1),  # Segment end x (constrained to 0-1)
    y1 = pmin(pmax(y0 + runif(n, min = -.2, max = .2), 0), 1),  # Segment end y (constrained to 0-1)
    shade = runif(n),       # Random shade value (0-1) for color mapping
    width = runif(n, min = 0.2, max = 1),  # Random segment width (0.2-1)
    alpha_val = runif(n, min = 0.6, max = 0.95),  # Random transparency (0.6-0.95)
    direction = sample(c("group1", "group2", "group3"), n, replace = TRUE)  # Random direction group
  ) %>%
    mutate(
      # Add small random offset to x1 based on direction group
      x1 = case_when(
        direction == "group1" ~ x1 + rnorm(n, 0, 0.008),
        direction == "group2" ~ x1 - rnorm(n, 0, 0.008),
        TRUE ~ x1
      ),
      # Add small random offset to y1 based on direction group
      y1 = case_when(
        direction == "group1" ~ y1 + rnorm(n, 0, 0.008),
        direction == "group2" ~ y1 - rnorm(n, 0, 0.008),
        TRUE ~ y1
      )
    )
  
  # Critical: Map 0-1 shade values to provided color palette (single color per palette entry)
  n_colors <- length(palette_colors)
  
  # Split shade range (0-1) into bins matching palette length, get bin indices
  color_indices <- as.integer(cut(dat$shade, 
                                  breaks = seq(0, 1, length.out = n_colors + 1),
                                  include.lowest = TRUE))
  
  # Sanitize indices to prevent out-of-bounds errors (force 1 to n_colors)
  color_indices <- pmin(pmax(color_indices, 1), n_colors)
  
  # Assign final color code to each data point
  dat$color_value <- palette_colors[color_indices]
  
  return(dat)
}

# Main function: Create square short vase with 9 flowers (each with unique single color)
# Fixed version - corrects color mapping logic and vase coordinates
square_vase_colorful_fixed <- function() {
  
  # Define 18 color codes (stored as list - NOTE: only first 9 entries are used for 9 flowers)
  # Each list entry = single color code for one flower
  palettes <- list(
    "#c75873","#D9C1C1","#F7E9E9",
    "#d685a0","#9c435d","#daa5b7",
    "#c83965","#c88da4","#d8c3c9",
    "#e0bcd0","#681a30","#efd6e8",
    "#d685a0","#c88da4","#d8c3c9",
    "#93031a","#ce9bc1","#c83965")
  
  # ========== 1. Define square vase coordinates (7 vertices for closed shape) ==========
  square_vase <- data.frame(
    x = c(1.8, 1.6, 1.4, 3.6, 3.4, 3.2, 1.8),  # Vase x-coordinates (left to right to close)
    y = c(0.0, 2.0, 5.0, 5.0, 2.0, 0.0, 0.0)   # Vase y-coordinates (bottom to top to bottom)
  )
  
  # ========== 2. Generate 9 flowers (each with unique position/size/color) ==========
  flowers_data <- list()  # Empty list to store each flower's data
  
  # Configuration for 9 flowers: seed/n/palette/x/y/scale/width multiplier
  # Each flower uses ONE color from the palettes list (palettes[[1]] to palettes[[9]])
  flower_configs <- list(
    list(seed = 101, n = 2000, palette = palettes[[1]], x = 2.5, y = 4.0, scale = 1.2, width_mult = 4),
    list(seed = 102, n = 1000, palette = palettes[[2]], x = 1.2, y = 4.2, scale = 1.0, width_mult = 3.5),
    list(seed = 103, n = 800, palette = palettes[[3]], x = 3.8, y = 4.2, scale = 1.0, width_mult = 3.5),
    list(seed = 104, n = 900, palette = palettes[[4]], x = 4.5, y = 4.0, scale = 1.1, width_mult = 3.5),
    list(seed = 105, n = 1000, palette = palettes[[5]], x = 0.8, y = 3.5, scale = 1.0, width_mult = 3.5),
    list(seed = 106, n = 3000, palette = palettes[[6]], x = 2.5, y = 5.0, scale = 1.3, width_mult = 4),
    list(seed = 107, n = 1000, palette = palettes[[7]], x = 0.7, y = 5.5, scale = 1.3, width_mult = 4),
    list(seed = 108, n = 1000, palette = palettes[[8]], x = 4.0, y = 6.0, scale = 1.3, width_mult = 4),
    list(seed = 109, n = 1000, palette = palettes[[9]], x = 3.0, y = 6.0, scale = 1.3, width_mult = 4)
  )
  
  # Loop through configurations to generate each flower's data
  for (i in seq_along(flower_configs)) {
    config <- flower_configs[[i]]
    
    # Generate flower data with pre-computed color values
    flower_data <- polar_art_data_with_colors(
      seed = config$seed,
      n = config$n,
      palette_colors = config$palette  # Pass SINGLE color code (not multi-color palette)
    ) %>%
      mutate(
        # Scale/position flower coordinates to vase layout
        x0 = config$x + (x0 - 0.5) * config$scale,
        y0 = config$y + (y0 - 0.5) * config$scale,
        x1 = config$x + (x1 - 0.5) * config$scale,
        y1 = config$y + (y1 - 0.5) * config$scale,
        # Scale segment width for flower size variation
        width = width * config$width_mult,
        # Assign unique ID to each flower
        flower_id = i
      )
    
    flowers_data[[i]] <- flower_data  # Add to flowers list
  }
  
  # Combine all flower dataframes into one
  all_flowers <- bind_rows(flowers_data)
  
  # ========== 3. Create final plot ==========
  ggplot() +
    # Background rectangle (large negative/positive bounds to cover entire plot area)
    annotate("rect", xmin = 1000, xmax = -1000, ymin = -100, ymax = 0.3,
             fill = "#681a30", alpha = 1) +
    
    # Draw square vase (white fill)
    geom_polygon(data = square_vase, aes(x, y), fill = "white") +
    
    # Draw all flowers using pre-computed color values
    geom_segment(data = all_flowers,
                 aes(x = x0, y = y0, xend = x1, yend = y1,
                     colour = color_value,  # Use pre-assigned color codes (not gradient)
                     linewidth = width, 
                     alpha = alpha_val),
                 show.legend = FALSE) +
    
    # Critical: Use identity scale to render exact color codes (no color transformation)
    scale_colour_identity() +
    # Scale line width range for visible flower size variation
    scale_linewidth(range = c(1, 15)) +
    # Use exact alpha values (no transformation)
    scale_alpha_identity() +
    
    # Fix plot dimensions (square aspect ratio) and visible range
    coord_fixed(xlim = c(0, 5), ylim = c(0, 7)) +
    # Remove default plot elements (axes, grid, etc.)
    theme_void() +
    # Set plot background color (light pink)
    theme(
      panel.background = element_rect(fill = "#f0dee9", colour = NA),
      plot.background = element_rect(fill = "#f0dee9", colour = NA)
    )
}

# Save plot to file (high resolution for printing)
ggsave(
  filename = "square_vase_more_flowers.png",  # Output filename (change to .jpg if needed)
  plot = square_vase_colorful_fixed(),        # Plot object to save
  width = 3,                                  # Image width (inches)
  height = 4,                                 # Image height (inches)
  dpi = 300,                                  # Resolution (300 dpi = print quality)
  bg = "transparent"                          # Transparent background (avoids white borders)
)
