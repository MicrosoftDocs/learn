StereoKit is a mixed reality library written in C# that draws inspiration from XNA, Dear ImGui, and Processing. It provides a simple user interface for graphics, physics, user interface, and other features needed to create a Mixed Reality application! You don't need a game engine to make an app, and you certainly don't need to be a graphics programmer to get your models onto a headset! All you need to create a user interface and design interactions is a simple approach! StereoKit succeeds in achieving this goal. A single line of code may make a clickable UI button, load a .gltf model, play a sound, and do a lot more.

You may develop custom applications using StereoKit as it focuses on non-game Mixed Reality use cases. StereoKit allows you to create high-quality Mixed Reality experiences. It is possible to carry out Mixed Reality operations natively using basic core APIs. Also, StereoKit helps you to overcome complex game engine structures.

## StereoKit key features

* You can use StereoKit on OpenXR platforms such as HoloLens 2, Oculus Quest, Windows Mixed Reality, Oculus Desktop, SteamVR, Varjo, and Monado Linux.

* The StereoKit supports 3D model of formats: gltf, glb, obj, stl, ascii ply, and procedural.

* The StereoKit supports image or texture of format: jpg, png, tga, bmp, psd, gif, hdr, pic, equirectangular cubemap, and procedural.

* StereoKit builds your application to a device in a matter of time.

* StereoKit supports flat-screen mode with input emulation, powerful UI, and interactions for easy development.

* Assets are loaded at runtime, allowing faster computations.

* Physics enables the 3D object to function as a real-world object, along with all physical constraints.

* By default StereoKit, uses a flexible shader or material system with a built-in PBR.

## Coding in StereoKit

StereoKit focuses on getting you up and running with as little code as possible. Most activities, including UI, can be accomplished with just one line of code. Here's an example of a code showing how easy loading a 3D asset into your application.

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

The code above demonstrates how easy it is to adjust the transform positions of a 3D model, in this example, a **DamagedHelmet**. The Matrix will transform the Model from Model Space into the current Hierarchy Space. StereoKit will focus on the Core API, improving performance and ensuring that all critical features are available and working correctly! In addition, you may create some fundamental tools, such as a visual shader editor. StereoKit's primary technology is an Immediate Mode system that doesn't use a framework or manage application state.
