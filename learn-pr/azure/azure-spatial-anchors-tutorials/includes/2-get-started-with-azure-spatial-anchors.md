Azure Spatial Anchors gives developers the tools they need to create spatially aware mixed reality applications for HoloLens, iOS devices with ARKit, and Android devices with ARCore.

Developers can use Azure Spatial Anchors to collaborate with mixed-reality platforms to understand spaces, mark specific places of interest, and remember those points of interest from compatible devices.

Some use cases of Azure Spatial Anchors include:

* **World-Tracking**: Users can scan the area with their phones to see where they are in the real world depending on what the camera sees. In addition, the application displays arrows over the environment to make navigation easier.

* **Internet of Things**: Another area where the usage of spatial anchors will be highly beneficial is the Internet of Things. For example, assume you're standing in front of a piece of factory equipment equipped with several sensors. If a part has a problem, an arrow can point straight to the problem area. Thus, you can see every piece of important information quickly just by looking at the piece of equipment with your device.

## AR Foundation

In Unity, the AR Foundation lets you work with augmented-reality systems across several platforms. This package provides an interface for Unity developers, but it doesn't include any AR functionality. On a target device, you'll also need separate packages for Unity's officially supported target platforms.

* ARCore XR Plugin on Android
* ARKit XR Plugin on iOS
* Magic Leap XR Plugin on Magic Leap
* Windows XR Plugin on HoloLens

## AR anchor manager script

A point in space that you want the devices to track is called an *anchor*. For each anchor, the anchor manager creates GameObjects. Then, the device typically performs more work to update the anchor's position and orientation throughout its lifetime.

The "Anchor Prefab" field in the ARAnchorManager isn't intended for content. Instead, ARFoundation will build a new GameObject to represent an anchor using a means other than AddComponent, such as loading an ARWorldMap with anchors. The prefab field aims to extend anchors' default behavior; it's not a suggested technique to deploy content in the world.

## Button config helper script

The script will help to change the icon, text, and label of the button. In addition, each button has a Button Config Helper script that lets you choose an icon for your button from a set of icons.

## Resources

A resource group is a logical container for deploying and managing Azure resources such as web apps, databases, and storage accounts.

Spatial Anchors Account is a unique resource name using regular alphanumeric characters.
