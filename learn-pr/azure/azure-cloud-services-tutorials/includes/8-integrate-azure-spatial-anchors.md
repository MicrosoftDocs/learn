With a local real-world environment mapped out, we can identify a single point within the 3D space as a reference point. These points are called *Spatial Anchors*.

Usually, the 3D point cloud exists only locally and for the lifecycle of the application. For a mobile device to recognize the exact physical location at a later time, the point cloud needs to be persisted to storage. For a self-contained application, this storage could be local device storage. If we want multiple users with multiple devices to share and collaborate in the same physical space, the point cloud needs to be persisted in a cloud-storage service, which lets us share this data between devices.

Microsoft’s Azure Spatial Anchors (ASA) fulfills this role. ASA is a cloud-based service supplied with application-specific SDKs.
