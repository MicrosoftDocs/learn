WebXR is a technology that helps bring VR and AR functionality to the web. The WebXR Device API at its core handles the logic for interfacing with devices that support VR or AR. 

In the scenario of the amusement park application, the company wants the VR/AR application to be easily accessible through a browser connected to the internet. WebXR is the most fitting technology to fulfill this need.

Here, you'll learn about a selection of the WebXR features provided by Babylon.js.

## WebXR in Babylon.js

Babylon.js is a powerful 3D rendering engine packed into a typescript framework. Other than its main features such as rendering 3D meshes and animations, the framework also provides support for WebXR.

The WebXR experience can be enabled for a Babylon.js scene in one line:

```typescript
const xr = await scene.createDefaultXRExperienceAsync({});
```

By default, this line of code enables WebXR support in the immersive VR mode. To enable the support for WebXR support in the AR mode, use this line:

```typescript
const xr = await scene.createDefaultXRExperienceAsync({
    uiOptions: {
        sessionMode: "immersive-ar",
    },
});
```

After WebXR is enabled using this function, if the Babylon.js application is opened on a browser of a device that supports WebXR in the specified mode (VR or AR), an XR button will appear in the bottom-right corner of the page:

:::image type="content" source="../media/webxr-button.jpg" alt-text="Screenshot of an empty Babylon J S scene with an X R button in the bottom-right corner.":::

One can then enter the VR or AR session by pressing on that button.

### WebXR Session Manager

The WebXR Session Manager serves as the interface for us to interact with the WebXR session of the scene.

When we use `scene.createDefaultXRExperienceAsync()` to enable the WebXR support, the session manager is created automatically and can be accessed through `xr.baseExperience.sessionManager`.

The WebXR Session Manager provides a set of observables, which events that we can subscribe to and take action on. For example, the *onXRSessionInit* observable is triggered when a new WebXR session is created, and the *onXRSessionEnded* observable is triggered when a WebXR session ended. These observables are useful for recognizing when users are entering the WebXR session through the button selection.

The WebXR Session Manager can also be used to initialize or end a WebXR session programmatically, as well as specifying the type of the session (VR or AR) when creating the session programmatically.

### WebXR Camera

The WebXR Camera refers to the camera rendering the view of the WebXR session. In other words, the position and direction of the WebXR Camera would show the position and direction of the host device relative to the virtual space in the WebXR session. Specifically, you can get the position in front of the camera using:

```typescript
// the position which is 0 meter in front of the camera
const position = xr.baseExperience.camera.getFrontPosition(0);
```

Like the WebXR Session Manager, the WebXR Camera is also created at the scene.createDefaultXRExperienceAsync() call. The instance of the camera can be accessed by using `xr.baseExperience.camera`.

### Background Remover

Background remover is an AR-exclusive feature that helps make Babylon.js scenes reusable across both VR and AR session modes.

When viewing a Babylon.js scene without WebXR support or in an immersive VR session, the scene often has background materials (ground, sky, etc.) that describe the setting of the scene. However, in an AR session, we only want to render the non-background meshes and instead use the user's real surroundings as the background.

The background remover feature allows us to specify what meshes to remove when the user is in an AR session. The example below shows how it can be enabled:

```typescript
xr.baseExperience.featuresManager.enableFeature(BABYLON.WebXRBackgroundRemover, 'latest', {
    backgroundMeshes: [ground, sky]
});
```

## Supported devices

VR and AR WebXR sessions can be opened on Android and iOS mobile phones. For Android, sessions are supported on the native Chrome browser; for iOS, sessions can be viewed on an application named WebXR Viewer.

Other than mobile phones, you can also view immersive VR sessions using any Windows Mixed Reality headset or HoloLens, which support AR as well.
