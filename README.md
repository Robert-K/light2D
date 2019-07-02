# Light2D
Realtime 2D Raytracing in [Unity](https://unity3d.com/) using Signed Distance Fields

## Screenshots
<img src="Screenshots/033436.jpg" width="400" /> <img src="Screenshots/033356.jpg" width="400" /> <img src="Screenshots/033422.jpg" width="400" /> <img src="Screenshots/033615.jpg" width="400" />

## Features
- Realtime raytracing on average GPUs!
- Optimized with Jump Flood Voronoi algorithm for distance field calculation in O(log n)
- Screen space effect - supports all kinds of models/sprites/other effects
- Individual objects/layers can be in- or excluded
- Easy to set up & includes examples

### WIP! Documentation coming soon... (maybe)

## ToDo
- Allow blending RenderTextures and Light2D output
- Enable variable light texture resolutions to improve performance
- Implement nonemissive objects that still contribute to GI
- Implement subsurface scattering
- Implement Light bounces


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/made-with-c-sharp.svg)](https://forthebadge.com)
