Azure Spatial Anchors gives developers tools for creating spatially aware mixed reality applications for HoloLens, for iOS devices through ARKit, and for Android devices through ARCore.

Developers can use Azure Spatial Anchors to collaborate with mixed reality platforms to understand spaces, mark specific places of interest, and remember those points of interest from compatible devices.

Use cases for Azure Spatial Anchors include:

* **World tracking**: Users can scan the area with their phones to see where they are in the real world, depending on what the camera sees. In addition, the application displays arrows over the environment to make navigation easier.

* **Internet of Things**: Imagine that you're standing in front of factory equipment that has several sensors. If a part has a problem, an arrow can point straight to the problem area. You can quickly see every piece of important information about the equipment just by looking at your device.

## AR Foundation

In Unity, AR Foundation lets you work with augmented reality systems across several platforms. This package provides an interface for Unity developers, but it doesn't include any augmented reality functionality. On a target device, you'll also need separate packages for Unity's officially supported target platforms:

* ARCore XR Plugin on Android
* ARKit XR Plugin on iOS
* Magic Leap XR Plugin on Magic Leap
* Windows XR Plugin on HoloLens

## ARAnchorManager script

A point in space that you want the devices to track is called an *anchor*. For each anchor, the anchor manager creates GameObjects. Then, the device typically performs more work to update the anchor's position and orientation throughout its lifetime.

The `anchorPrefab` field in the `ARAnchorManager` class isn't intended for content. Instead, AR Foundation will build a new GameObject to represent an anchor by using a means other than `AddComponent`, such as loading an `ARWorldMap` object with anchors. 

The prefab field aims to extend anchors' default behavior. It's not a suggested technique to deploy content in the world.

## ButtonConfigHelper script

Each button has a `ButtonConfigHelper` script that lets you choose an icon, text, and label.

## Resources

A resource group is a logical container for deploying and managing Azure resources such as web apps, databases, and storage accounts.

A Spatial Anchors account is a unique resource name that uses regular alphanumeric characters.
