# 4. Create a Holographic Remoting PC Application

The Holographic Remoting Player is a companion programme that links to Holographic Remoting-compatible PC apps and games. Holographic Remoting uses a Wi-Fi connection to transmit holographic content from a PC to your Microsoft HoloLens in real time.

Only PC apps that are intended to support Holographic Remoting can be utilised with the Holographic Remoting Player.

# Internet Client Server Capabilities 
The Network Client server manager can be used to manage connections in many multiuser applications, but you can alternatively utilise the lower-level NetworkServer and NetworkClient classes directly.
Every application that uses the High-Level API must connect to a host server. In a multiuser application, each user can act as a client, a dedicated server, or a server and client at the same time.

# Open XR
OpenXR is an open standard for creating high-performance VR apps that can run on a variety of systems. OpenXR seeks to make VR creation easier by allowing developers to use the same code across several platforms.

# Depth 16
In unity ,the precision of the render texture's depth buffer in bits (0, 16, 24/32 are supported).
16 means at least 16 bit Z buffer and no stencil buffer

# Eye Gaze Interaction
The Eye Tracking Interaction extension provided by Khronos is supported by Unity OpenXR. To get the posture data that the extension returns, use this layout.


# Microsoft Hand Interaction 
The Hololens 2 Hand interaction profile is supported by Unity OpenXR. Bindings that use XR Controller and are available on this device (for example, XRController>/devicePosition) will bind appropriately because this layout inherits from XRController>.

Hand mesh or hand rig data are not included in this interaction profile. These will be added at a later date.
