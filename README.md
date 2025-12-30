<div id="user-content-toc" align="center">
  <ul>
  <summary><h1> <p> Generative Art using R and Python </p> </h1></summary>
  <p align='center'>
  </p>
  </ul>
</div>

<h4 align="justify"> 
Generative Art is a creative repositories where data and code are transformed into artistic expression. Each piece explores how computational processes can generate visual beauty with emotional resonance, whether through R's elegant statistical visualizations or Python's dynamic generative systems. This repository serves as both a gallery of computational aesthetics and a living laboratory where mathematics meets meaning, documenting the creative possibilities that emerge when programming works not just as a tool for solving problems, but as a medium for exploring culture and spirituality.
</h4>
<br>

## On Exhibition ##
### Mount Kailash: A Digital Pilgrimage with R
This project is an animated Mount Kailash (a mountain in Ngari Prefecture, Tibet Autonomous Region of China) created with R code, completing through code a pilgrimage journey I have yet to make in person. With ggplot2 laying the foundation for static scene composition and gganimate enabling smooth dynamic transitions, the artwork depicts this snow-cloaked sacred mountain through layered geometric polygons. First, the mountain's silhouette is precisely defined by carefully curated vertex coordinates; then, these contours are duplicated, offset, and overlaid in softer, lighter shades to simulate the cumulative depth of snow cover and create a striking sense of three-dimensionality. The sky features a gentle gradient, blending from deep, rich blue to ethereal celestial purple, and is anchored by a translucent golden full moon that lends a serene, sacred ambiance. Additionally, 100 algorithmically generated snowflakes (seeded with 2026) drift downwards along unique, randomized trajectories shaped by uniform distributions and sinusoidal sway. Through gganimate's seamless frame-to-frame transitions, the final output is a GIF that transforms lines of code into a contemplative landscape scene. 

<p align="center">
<img src="https://github.com/Weihua-Zhao97/Generative_Art/blob/main/Mount%20Kailash%3A%20Digital%20Pilgrimage/mountain_in_snow.gif" width="600"  />
</p>
<br>

- **Tool:** @R `ggplot2` | `gganimate` (for frame-by-frame animation)
