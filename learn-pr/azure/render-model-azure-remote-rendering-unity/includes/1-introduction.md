You work for a truck manufacturer that is currently designing a new engine to replace the prior model used in production. Your role as a mixed reality engineer is to create solutions that support manufacturing logistics. A 3D model of the engine has been created which enables the automotive engineering lead to view and refine the engine design specifications. Unfortunately, viewing the model on a computer screen doesn't provide a full-scale detailed 3D view of the engine and its internal mechanics. Such an application that provides this capability would be helpful for completing a design review of the engine.

In this module, you'll create a remote rendering session that renders an engine model in Unity. After you initialize remote rendering, a session is created. Next, the app connects the local runtime to the remote session. The model is then loaded for viewing untethered at full detail.

By the end of this module, you'll be able to create a remote rendering session and load a model into the session.

## Learning objectives

- Create an Azure Remote Rendering session
- Load a 3D model
- Render a 3D model

## Prerequisites

- A Windows 10 PC that meets the [system requirements](/azure/remote-rendering/overview/system-requirements) and is configured with [the correct tools](/windows/mixed-reality/install-the-tools)
- Windows 10 SDK 10.0.18362.0 or later
- Unity Hub with Unity 2019.4.X installed
- Familiarity with [setting up a Unity project for Windows Mixed Reality](/training/modules/mixed-reality-toolkit-project-unity)
- Basic familiarity with Unity: interface, scene creation, package import, and addition of GameObjects to a scene
- Basic familiarity with C# and Unity scripting
