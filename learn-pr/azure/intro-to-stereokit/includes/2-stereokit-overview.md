StereoKit is a C# Mixed Reality library influenced by XNA, Dear ImGui, and Processing. It has a straightforward user interface for graphics, physics, UI, and other features required to create an Mixed Reality application! To create an app, you don't need a game engine, and you don't need to be a graphics programmer to get your models onto a headset! All you need is a simple approach to create a user interface and design interactions! StereoKit accomplishes this goal. A single line of code can create a clickable UI button, load a .gltf model, play a sound, and much more.

You may develop custom applications using StereoKit as it focuses on non-game Mixed Reality use cases. You are allowed to create high-quality Mixed Reality experiences using StereoKit. It is possible to do Mixed Reality operations natively using basic core APIs. Also, StereoKit helps you to overcome complex game engine structures.

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

The above code shows how simple it is to import a 3D model, in this case, a **DamagedHelmet**, and customize its transform positions. The Matrix will transform the Model from Model Space into the current Hierarchy Space. StereoKit will concentrate on the Core API, optimizing performance, and ensuring that all essential features are available and functioning properly! You may develop some basic tooling, such as a visual shader editor. StereoKit's core technology is an Immediate Mode system with no framework or application state management.
