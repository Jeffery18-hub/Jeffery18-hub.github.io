+++
title = "Three.js Fundamentals"
lastmod = 2023-10-04T11:39:57-06:00
draft = false
author = "Jeffery@slc"
tags = ["three.js"]
categories = ["Tech/技术"]
+++

This blog post is primarily intended to document my learning journey with three.js.
At its core, this framework is a JavaScript library built on top of WebGL, designed to help developers efficiently create 3D models and scenes.
Here are some fundamental concepts and code snippets:


## Primary Classes {#primary-classes}

First, let's take a glance at the structural diagram:

<p align = "center">
<img src="/images/threejsBasics/structure.png" alt=st width="600" height="400" position = "center">
</p>

### Renderer {#renderer}

As seen from the above structural diagram, right at the top is the Renderer object.
The renderer is responsible for continuously rendering images to the browser's canvas.
It takes in a camera and a scene as its parameters. In essence, it renders (or draws) the portion of the 3D scene that
lies within the camera's frustum onto Ca canvas, presenting it as a 2D image.


### Scene {#scene}

The scene object is akin to a movie set. It contains actors, props, backgrounds, lights, and more.
However, it's crucial to note that the scene class and the camera class are paralleled.
There's no need to add the camera to the scene. Objects added to a scene, or the children of the scene, are positioned and oriented relative to their parent.


### Camera {#camera}

The camera object captures the scene. Its settings, such as the field of view, near position, and far position, can be adjusted.
<p align = "center">
<img src="/images/threejsBasics/camera1.png"  width="400" height="300">
</p>
This overhead view gives a clearer perspective on the relative positions of the camera and scene objects on the coordinate axes.
<p align = "center">
<img src="/images/threejsBasics/camera2.png"  width="400" height="300">
</p>
By default, the camera looks down the -Z axis with +Y up. If our mesh is positioned at the origin, we'd need to move the camera slightly back from the origin
to view anything.

```Javascript
camera.position.z = positive number;
```


### Mesh {#mesh}

Mesh objects represent the pairing of specific Geometry with a Material. Both Material and Geometry can be associated with multiple Mesh objects.

```Javascript
const cube = new THREE.Mesh(boxGeometry, material);
```

The cube example above demonstrates the constructor of a mesh, requiring a boxGeometry and a material object.


### Geometry {#geometry}

Geometries symbolize the vertex data of objects like spheres, cubes, planes, animals, humans, trees, buildings, and more.
Three.js offers numerous built-in geometry primitives, but you can also create custom geometries or load geometries from files.

```Javascript
// Data of a box
  const boxWidth = 1;
  const boxHeight = 1;
  const boxDepth = 1;
  const boxGeometry = new THREE.BoxGeometry(boxWidth, boxHeight, boxDepth);
```


### Material {#material}

Materials depict the surface properties employed for drawing geometries.
This includes attributes like the color and shininess. A Material can also reference Texture objects, which can, for instance,
wrap an image onto a geometry's surface.


### Texture {#texture}

Textures typically symbolize images loaded from image files, generated from a canvas, or rendered from another scene.


### Light {#light}

The Light object is relatively straightforward. Three.js has embedded types of light sources such as point light, ambient light, and directional light, among others.


## Animation {#animation}

Without it, the rendered content in the browser would just be a static 2D image. The browser provides a function called requestAnimationFrame
that forms a so-called render loop by accepting a drawing callback function. In essence, it continuously draws images frame-by-frame on the canvas.
Suppose your browser operates at 60 frames per second. That means it refreshes roughly every 16ms. When you invoke requestAnimationFrame(callback),
you're essentially making a request to the browser to execute the callback after this 16ms duration.
It's merely a reservation at this point, as requestAnimationFrame operates asynchronously and doesn't disrupt subsequent code execution.

```Javascript
const animate = (currTime ) => {
    requestAnimationFrame(animate);
    cube.rotation.y += 0.01;
    renderer.render(scene, camera);
}
animate();
```

The code above demonstrates continuously rotating a cube around the y-axis.


## Details {#details}

Lastly, a quick detail from the documentation to touch upon:
A canvas's internal size, often termed its drawing buffer size, can be set in three.js by calling renderer.setSize.
So, what size should we opt for? The obvious answer is "the same size the canvas is displayed".

Using my code as an example:

```Javascript
const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement); // domElement is the canvas returned from the renderer
```

When you call renderer.setSize(window.innerWidth, window.innerHeight), you're essentially instructing THREE.js: “I want the 3D content I'm rendering
to fill the entire browser window, and I'd like the size of the &lt;canvas&gt; element itself to be adjusted to this size.”
This ensures that your 3D content appears both clear and undistorted in the browser window.
