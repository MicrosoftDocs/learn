StereoKit has a pretty extensive list of features, but here are some highlights that will give you an idea of what StereoKit is capable of.

## StereoKit key features

* Runs on any device that supports OpenXR. This includes HoloLens 2, Oculus Quest, Windows Mixed Reality, Oculus Desktop, SteamVR, Varjo, and Monado on Linux.

* A lightweight core builds to your device in seconds, not minutes.

* 3D model file formats: gltf, glb, obj, stl, ply, and procedural.

* Texture formats: jpg, png, tga, bmp, psd, gif, hdr, pic, qoi, equirectangular cubemap, and procedural.

* Flexible shader/material system, with built-in shaders for Physically Based Rendering.

* A performance-by-default instanced rendering pipeline.

* Skeletal/skinned animation.

* Runtime asset loading and a built-in cross-platform file picker.

* Flat screen MR simulator with input emulation for faster development.

* Easy and powerful UI and interactions for Mixed Reality.

## Coding in StereoKit

StereoKit focuses on getting you productive with the least amount of code possible. You can do most tasks with a single line of code, including UI. So here's hello world with StereoKit. This is all you need to get up and to run.

```c#
using StereoKit;

class Program
{
    static void Main(string[] args)
    {
        SK.Initialize(new SKSettings{ appName = "Project" });
        
        Model helmet = Model.FromFile("Assets/DamagedHelmet.gltf");
        
        while (SK.Step(() => {
            helmet.Draw(Matrix.TS(Vec3.Zero, 0.1f));
        }));
        
        SK.Shutdown();
    }
}
```

The code above shows how easy it's to spin up StereoKit and draw a 3D model. Just initialize StereoKit, load your model from the file, and draw it every step. This simple API is easy and performant and lets you build your code the way you want to. Of course, you'll still find plenty of options to configure StereoKit, but everything is designed to work right out of the box for Mixed Reality.
