## 4. Create A Holographic Remoting PC Application

The Holographic Remoting Player is a companion program that links to Holographic Remoting-compatible PC apps and games. Holographic Remoting uses a Wi-Fi connection to transmit holographic content from a PC to your Microsoft HoloLens in real-time.

You can only use PC apps that are intended to support Holographic Remoting with the Holographic Remoting Player.

## Internet Client Server Capabilities 
The Network Client-server manager can be used to manage connections in many multiuser applications, but you can also use the lower-level NetworkServer and NetworkClient classes directly.
Every application that uses the high-level API must connect to a host server. In a multiuser application, each user can act as a client, a dedicated server, or a server and client simultaneously.

## Open XR
OpenXR is an open standard for creating high-performance VR apps that can run on a variety of systems. OpenXR seeks to make VR creation easier by allowing developers to use the same code across several platforms.

## Depth 16
In Unity, the precision of the render texture's depth buffer in bits (0, 16, 24/32 are supported).
Sixteen means at least a 16-bit Z-buffer and no stencil buffer.

## Eye Gaze Interaction
Unity OpenXR supports the Eye Tracking Interaction extension provided by Khronos. To get the pose data that the extension returns, use this layout.

## Microsoft Hand Interaction 
Unity OpenXR supports the Hololens 2 Hand interaction profile. Bindings that use XR Controller and are available on this device (for example, XRController>/device position) will bind appropriately because this layout inherits from XRController>.

Hand mesh or hand rig data are not included in this interaction profile. Hand  will be added at a later date.
