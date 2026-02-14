<div id="user-content-toc" align="center">
  <ul>
  <summary><h1> <p> Generative Art using R and Python </p> </h1></summary>
  <p align='center'>
  </p>
  </ul>
</div>

<h4 align="justify"> 
Generative Art is a creative repositories where data and code are transformed into artistic expression. Each piece explores how computational processes can generate visual beauty with emotional resonance, whether through R's elegant statistical visualizations or Python's dynamic generative systems. This repository serves as both a gallery of computational aesthetics and a living laboratory where mathematics meets meaning, documenting the creative possibilities that emerge when programming works not just as a tool for solving problems, but as a medium for exploring art and spirituality.
</h4>
<br>

## On Exhibition ##
### Mount Kailash: A Digital Pilgrimage with R
This project is an animated Mount Kailash (a mountain in Ngari Prefecture, Tibet Autonomous Region of China) created with R code, completing through code a pilgrimage journey I have yet to make in person. With ggplot2 laying the foundation for static scene composition and gganimate enabling smooth dynamic transitions, the artwork depicts this snow-cloaked sacred mountain through layered geometric polygons. First, the mountain's silhouette is precisely defined by carefully curated vertex coordinates; then, these contours are duplicated, offset, and overlaid in softer, lighter shades to simulate the cumulative depth of snow cover and create a striking sense of three-dimensionality. The sky features a gentle gradient, blending from deep, rich blue to ethereal celestial purple, and is anchored by a translucent golden full moon that lends a serene, sacred ambiance. Additionally, 100 algorithmically generated snowflakes (seeded with 2026) drift downwards along unique, randomized trajectories shaped by uniform distributions and sinusoidal sway. Through gganimate's seamless frame-to-frame transitions, the final output is a GIF that transforms lines of code into a contemplative landscape scene. 

<p align="center">
<img src="https://github.com/Weihua-Zhao97/Generative_Art/blob/main/Mount%20Kailash%3A%20Digital%20Pilgrimage/mountain_in_snow.gif"  />
</p>
<br>

- **Tool:** @R `ggplot2` | `gganimate` (for frame-by-frame animation)
<br>

### Vase with Roses: Algorithmic Floral Art in R
Vase with Roses is an R-based generative art project that recreates a flat oil-paint aesthetic through code. Inspired by Bernard Cathelin’s rose paintings—characterized by bold geometric color fields, simplified floral forms, and flattened spatial depth—the work uses randomized line segments with subtle Gaussian variation to evoke soft, painterly textures while preserving a planar, color-block composition. Each rendering generates nine rose-like blooms arranged within a minimalist vase silhouette. By combining mathematical randomness with structured composition, the project explores how algorithms can simulate modernist still-life painting, producing infinite, non-repeating variations within a cohesive visual language.

<p align="center">
<img src="https://github.com/Weihua-Zhao97/Generative_Art/blob/main/vase_with_roses/vase_flowers.png" height="500" />
</p>
<br>

- **Tool:** @R `ggplot2`
<br>

### Valentine's Polar Rose: Exploring Intimacy Through Generative Art
This project generates a Valentine-themed rose in polar coordinates using R. Inspired by [Danielle Navarro’s *Art From Code*](https://blog.djnavarro.net/posts/2024-12-18_art-from-code-1/).
(a static generative artwork), I transformed the concept into a dynamic animation with 6000 lines that gradually accumulate via shadow_mark(). I also modified the color palette, line width, and opacity to enhance a layered, Valentine-themed, painterly aesthetic, emphasizing the interplay of randomness, structure, and emergent form. The creative process mirrors the dynamics of intimacy:

1. **Seeded randomness:** Lines start from random points with random offsets, leaving initial blank space as infinite possibility—like the openness at the beginning of a relationship.  
2. **Accumulation:** `shadow_mark()` allows lines to gradually build, revealing the rose’s contour, reflecting the emergence of beauty and connection over time.  
3. **Layering:** Similar color gradients and occasional white lines interweave. Repeated stacking represents effortful attempts at closeness, but progress is subtle, often just a visual loop.  
4. **Magnified deviations:** Minor offsets in Cartesian coordinates are amplified in polar coordinates. Overly dense lines create internal clutter, illustrating how forcing intimacy can obscure natural beauty and produce “entropy.”  
5. **Probabilistic closure:** Random offsets make perfect closure unlikely. While the outer shape becomes full, the inner structure retains unavoidable gaps, symbolizing that humans can be close with one another, but are ultimately independent.

<p align="center">
<img src="https://github.com/Weihua-Zhao97/Generative_Art/blob/main/valentine-polar-rose/rose.gif"  height="500"/>
</p>
<br>

- **Tool:** @R `ggplot2` | `gganimate` (for frame-by-frame animation; relies on FFmpeg to render animations to MP4)
<br>
