Azure Spatial Anchors gives developers tools for creating spatially aware mixed reality applications for HoloLens, iOS devices through ARKit, and Android devices through ARCore.

Developers can use Azure Spatial Anchors to understand spaces, mark specific places of interest, and remember those points of interest on compatible devices.

Use cases for Azure Spatial Anchors include:

* **World tracking**: Users can scan an area with their phones and determine where they are in the real world based on what the camera sees. Your application can strategically place arrows in the user's view to make navigation easier.

* **Internet of Things**: Imagine that you're standing in front of a piece of factory equipment that has several sensors. If a specific part of the equipment has a problem, an arrow that points to the problem area can appear in your view. You can quickly see every piece of important information about the equipment just by looking at your device.

## AR Foundation

In Unity, AR Foundation lets you work with augmented reality systems across several platforms. This package provides an interface for Unity developers but doesn't include any augmented reality functionality. On a target device, you'll also need separate packages for Unity's officially supported target platforms:

* Google ARCore XR Plug-in on Android
* Apple ARKit XR Plug-in on iOS
* OpenXR Plug-in on HoloLens 2
* Meta OpenXR Feature on Meta Quest

## ARAnchorManager script

A point in space that you want the devices to track is called an *anchor*. For each anchor, the Anchor Manager creates GameObjects. The device typically performs more work to update the anchor's position and orientation throughout its lifetime.

The `anchorPrefab` field in the `ARAnchorManager` class isn't intended for content. Instead, AR Foundation will build a new GameObject to represent an anchor by using a means other than `AddComponent`, such as loading an `ARWorldMap` object with anchors. 

The prefab field can extend the default behavior of anchors. We suggest that you don't use it to deploy content in the world.

## Resources

A resource group is a logical container for deploying and managing Azure resources such as web apps, databases, and storage accounts.

A Spatial Anchors account is a unique resource name that uses regular alphanumeric characters.
