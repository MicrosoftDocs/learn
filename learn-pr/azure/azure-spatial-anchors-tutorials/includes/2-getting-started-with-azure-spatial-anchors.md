## Get Started With Azure Spatial Anchors

Azure Spatial Anchors gives developers the tools they need to create spatially aware mixed reality applications for HoloLens, iOS devices with ARKit, and Android devices with ARCore.
Developers can use Azure Spatial Anchors to collaborate with mixed reality platforms to understand spaces, mark specific places of interest, and remember those points of interest from compatible devices.

Some examples of Azure Spatial Anchors include :

## World-Tracking
Users can scan their phones to see where they are in the real world depends on what the camera sees. In addition, the application displays arrows over the environment to make navigation easier for the user.

## Internet of Things

Another area where the usage of spatial anchors will be highly beneficial is the Internet of Things. For example, assume you're standing in front of a piece of factory equipment equipped with several sensors. If a part has a problem, an arrow can point straight to the problem part. Thus, you can see every piece of important information quickly and just by gazing at the piece of equipment with your device on.

## Mixed Reality Feature Tool

The Mixed Reality Feature Tool is a new tool that allows Unity developers to find, update, and integrate Mixed Reality feature packages into their projects. Before importing, you can search for packages by name or category, check their dependencies, and even examine proposed changes to your project's manifest file. The Mixed Reality Feature tool will download the packages you want into the project once you've validated them.

## Object Manipulator 

The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. Therefore, most kinds of interaction, such as the HoloLens 2 articulated hand, HoloLens 2 hand rays, HoloLens 1 gaze and gestures, and immersive headset motion controller input, should function with the script.

## Box Collider

Collider components define a GameObject's shape in terms of physical collisions. For example, the cube-shaped collision primitive is the Box Collider.

## Near Interaction Grabbable 

Near interactions, a grabbable script is used for touches and grabs interactions.

## Hololens Emulator And Windows Mixed Reality Simulator 

The HoloLens Emulator, which includes the HoloLens development kit, allows you to test holographic applications on your PC without using a physical HoloLens. Instead, the HoloLens emulator uses a Hyper-V virtual machine, which means that human and environmental inputs are emulated using your keyboard, mouse, or Xbox controller.
Without a Windows Mixed Reality immersive headset, you can use the Windows Mixed Reality simulator to test mixed reality apps on your PC.


## Release Or Master Configuration For Hololens 

The release configuration allows optimizations, resulting in faster-compiled code.
The Unity profiler is disabled in the Master configuration, which can make debugging more difficult.

## ARM64 Configuration 

Desktop PCs, mobile devices, and some IoT Core devices are part of the Windows 10 on ARM64 configuration.

## AR Foundation

Within Unity, the AR Foundation lets you work with augmented reality systems across several platforms. This package provides an interface for Unity developers, but it doesn't include any AR functionality. On a target device, you'll also need separate packages for Unity's officially supported target platforms.
* ARCore XR Plugin on Android
* ARKit XR Plugin on iOS
* Magic Leap XR Plugin on Magic Leap
* Windows XR Plugin on HoloLens


## AR Anchor Manager Script

A point in space that you want the devices to track is called an anchor. For each anchor, the anchor manager creates GameObjects. Then, the device typically performs additional work to update the position and orientation of the anchor throughout its lifetime.

The "Anchor Prefab" field in the ARAnchorManager isn't intended for content. Instead, ARFoundation will build a new GameObject to represent an anchor built in a means other than AddComponent, such as loading an ARWorldMap with anchors. The prefab field aims to extend anchors' default behavior; it's not a suggested technique to deploy content in the world.


## Button Config Helper Script 

The script will help to change the icon, text, and label of the button. In addition, each button has a Button Config Helper script that allows you to choose an icon for your button from a set of icons.

## Resources

A resource group is a logical container for deploying and managing Azure resources such as web apps, databases, and storage accounts.

Spatial Anchors Account is a unique resource name by using regular alphanumeric characters.