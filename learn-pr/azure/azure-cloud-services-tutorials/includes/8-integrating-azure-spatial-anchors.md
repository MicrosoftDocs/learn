# 8. Integrating Azure Spatial Anchors

## Azure spatial anchors

With a local real-world environment mapped out, we can identify a single point within the 3D space to be used as a reference point.These points are called a number of things including “Reference Points” and “AR Anchors” … but recently the industry seems to have settled on naming them “Spatial Anchors”. Usually, the 3D point cloud exists only locally and for the lifecycle of the application. In order for a mobile device to recognise the same physical location at a later point in time, the point-cloud needs to be persisted to storage.For a self-contained application, this could be local device storage - but if we want multiple users, with multiple devices, to share and collaborate in the same physical space, the point-cloud needs to be persisted in a cloud-storage service, which then lets us share this data between devices.

It is this role that Microsoft’s Azure Spatial Anchors (ASA) fulfils.ASA is a cloud-based service supplied with application-specific SDKs. It is a relatively new service, first announced in February 2019. At the time of writing, we have an SDK for use with the Unity game engine.