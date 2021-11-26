StereoKit is a C# Mixed Reality library influenced by XNA, Dear ImGui, and Processing. It has a straightforward user interface for graphics, physics, UI, and other features required to create an MR application! To create an app, you don't need a game engine, and you don't need to be a graphics programmer to get your models onto a headset! All you need is a simple approach to create a user interface and design interactions! StereoKit accomplishes this. A single line of code can create a clickable UI button, load a .gltf model, play a sound, and much more.

You can develop custom applications using StereoKit as it focuses on non-game Mixed Reality use cases. You can also create high-quality Mixed Reality experiences using StereoKit. Furthermore, you can perform Mixed Reality operations natively using basic core APIs. Also, StereoKit helps you to overcome complex game engine structures.

## StereoKit key features

* You can use StereoKit on OpenXR platforms such as HoloLens 2, Oculus Quest, Windows Mixed Reality, Oculus Desktop, SteamVR, Varjo, and Monado Linux.

* The StereoKit 3D model format must be in gltf, glb, obj, stl, ascii ply, and procedural.

* The StereoKit image or texture format must be in jpg, png, tga, bmp, psd, gif, hdr, pic, equirectangular cubemap, and procedural.

* StereoKit builds your application to a device in a matter of time.

* StereoKit supports flat-screen mode with input emulation, powerful UI, and interactions for easy development.

* Assets are loaded at runtime, allowing faster computations.

* Physics enables the 3D object to function as a real-world object, along with all physical constraints.

* By default StereoKit, uses a flexible shader or material system with a built-in PBR.

## Coding in StereoKit

StereoKit focuses on getting you up and running with as little code as possible. Most activities, including UI, can be accomplished with just one line of code. Here is an example of a code depicting how easy loading a 3D asset into your application is.

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

StereoKit will concentrate on the Core API, optimizing performance, and ensuring that all essential features are available and functioning properly! Some basic tooling, such as a visual shader editor, may be developed here. StereoKit's core technology is an Immediate Mode system with no framework or application state management.
