You work for a car manufacturer that is currently in the process of designing a new engine to replace the prior model used for vehicles. Your role as a mixed reality engineer is to create solutions that support manufacturing logistics. A 3D model of the engine has been created which enables the automotive engineering team to view and refine the engine design specifications. Although the model can be individually viewed on a mixed reality device, the team is in need of a solution that would enable everyone to view the model on separate devices in it's current state. For example, if someone were to manipulate the model to expose the underlying mechanics, all participants should be able to separately view the manipulation as it occurs on their device.

In this module, you'll create a remote rendering session that renders an engine model. After remote rendering is initialized and a session is created, the application will connect the local runtime to the remote session. The model is then loaded for viewing which enables multiple participants to view the same model on separate devices in it's current state.

By the end of this module, you'll be able to create a remote rendering session and load a model into the session.

## Learning objectives

- Create a Remote Rendering session
- Render a 3D model
- Use a cut plane to reveal the inside of meshes

## Prerequisites

- A Windows 10 PC configured with [the correct tools](https://docs.microsoft.com/windows/mixed-reality/install-the-tools)
- Windows 10 SDK 10.0.18362.0 or later
- Unity Hub with Unity 2019.4.X installed
- Familiarity with [setting up a Unity project for Windows Mixed Reality with the Mixed Reality Toolkit](https://docs.microsoft.com/learn/modules/mixed-reality-toolkit-project-unity/?azure-portal=true)
- Access to a microphone for audio capture
- Basic familiarity with Unity: interface, scene creation, package import, and addition of GameObjects to a scene
- Basic familiarity with C# and Unity scripting
