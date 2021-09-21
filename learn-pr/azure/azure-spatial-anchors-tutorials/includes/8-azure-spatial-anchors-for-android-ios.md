Unity's Augmented Reality Foundation is a high-level, cross-platform API that supports Augmented Reality. AR Foundation allows you to write your app once and deploy it to both Android and iOS devices. It used to be difficult and expensive to create an AR smartphone app. Users only need their mobile devices to access augmented reality apps, and we have the tools to do it faster and at a cheaper cost. This tutorial teaches you to build Azure Spatial Anchors for Android using ARcore XR plugin and for IOS devices using ARkit XR plugin.

## ARCore XR plugin

You may create augmented reality apps for Android smartphones with the ARCore XR plugin. Along with the ARCore Extensions for AR Foundation SDK, a default version of this plugin is installed. The ARCore XR Plug-in adds support for ARCore to Unity's multi-platform XR API. This supports efficient background rendering, Anchors, Occlusion, etc.

## ARKit XR plugin

ARKit is a high-level augmented reality development platform that allows developers to create AR Apps and Experiences by leveraging the CPU power of highly efficient yet capable iOS devices and their cameras.
To make creating an AR experience easier, ARKit integrates device motion tracking, camera scene capture, powerful image processing, and display conveniences. Using these technologies and an iOS device's front or rear camera, you may create a variety of AR experiences.

## Windows Mixed Reality camera setting

The Windows Mixed Reality camera settings provider detects the device on which the app is running and applies the relevant configuration settings based on the display (transparent or opaque). This allows the application's camera to be configured and optimized for usage in mixed reality apps using the Microsoft Mixed Reality Toolkit.

## New data provider

The Mixed Reality Toolkit input system is a modular framework that allows input device support to be added as needed. A unique input data provider may be required to enable compatibility for a new hardware platform. Data sources are available as add-ons from third parties or as part of the Microsoft Mixed Reality Toolkit. The approval process for new data providers submitting to the MRTK varies by situation and will be disclosed at the time of the initial proposal.

## Unity AR camera settings

The Unity AR camera settings provider is a beta MRTK component that lets you run mixed reality apps on Android and iOS devices.
The Unity AR camera settings provider offers a variety of tracking configuration options. These options are exclusive to Unity's version of the Unity AR camera settings provider.

## Strip Engine Code

Strip Engine Code is enabled by default in Unity's Player Settings, as is native code stripping. Remove unnecessary modules and classes from the native Unity engine code by enabling Strip Engine Code. To keep all of the modules in the native Unity engine code, disable Strip Engine Code.
