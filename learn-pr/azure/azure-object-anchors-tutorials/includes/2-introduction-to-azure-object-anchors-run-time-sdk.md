In this tutorial series, you will be using a sample application that uses Azure Object Anchors to detect objects in the physical world. Before you get started with the sample application, this chapter will provide you with a high-level overview of **Object Anchors Runtime SDK**, which is used to detect objects using Object Anchors model.

How convenient would it be to have a resource to help detect objects using visual and geometrics information only? Object Anchors Runtime SDK does just that; it uses parameters to determine how an object can be detected by the object observer and detects the required objects.

The main components are:

* **ObjectObserver** that detects and tracks multiple object instances simultaneously based on a list of user-provided object models.
* **ObjectQuery** that stores the parameters associated with the Object Model.
* **Diagnostic Session** for offline debugging.

Brief walk-through of the Azure Object Anchors Runtime SDK will help you understand how an object is represented and the various components used.

## ObjectModel

An [ObjectModel](/dotnet/api/microsoft.azure.objectanchors.objectmodel) captures the geometry of a physical object and encodes the parameters required for detection and pose estimation. The Object Anchors service must be used to construct it. Then, using the Object Anchors API, an application may load the produced model file and query the mesh stored in it for viewing.

## ObjectSearchArea

The search area for one or more objects is defined by an [ObjectSearchArea](/dotnet/api/microsoft.azure.objectanchors.objectsearcharea). A spatial graph node ID and spatial boundaries in the coordinate system represented by the spatial graph node ID describe it. **Field of view**, **bounding box**, **sphere**, and **location** are all supported by the Object Anchors Runtime SDK.

## ObjectObserver

An [ObjectObserver](/dotnet/api/microsoft.azure.objectanchors.objectobserver) loads object models, detects their instances, and reports 6-DoF in HoloLens coordinate system for each instance.

Although an observer creates an object model or instance, their lifetimes are independent. An application can get rid of an **observer** while still using the object model or instance.

## ObjectQuery

An [ObjectQuery](/dotnet/api/microsoft.azure.objectanchors.objectquery) instructs an **object observer** on how to locate objects belonging to a specific model. It comes with the following adjustable options, the default settings of which may be found in an object model.

## MinSurfaceCoverage

The [MinSurfaceCoverage](/dotnet/api/microsoft.azure.objectanchors.objectquery.minsurfacecoverage)parameter specifies the minimum amount of surface coverage that an instance must have to be considered detected.
An observer computes the ratio of overlapped surfaces between the modified object model and the scene for each object candidate, then reports the candidate to the application only if the coverage ratio exceeds a certain threshold.

## IsExpectedToBeStandingOnGroundPlane

The [IsExpectedToBeStandingOnGroundPlane](/dotnet/api/microsoft.azure.objectanchors.objectquery.isexpectedtobestandingongroundplane) property indicates do the target object stands on the ground plane.
The lowest horizontal floor in the search area is called a ground plane. It restricts the number of possible item poses. By enabling this flag, the **observer** will be guided to estimate the pose in a confined space, perhaps improving accuracy. If the model isn't designed to stand on the ground plane, this parameter will be ignored.

## ExpectedMaxVerticalOrientationInDegrees

The [ExpectedMaxVerticalOrientationInDegrees](/dotnet/api/microsoft.azure.objectanchors.objectquery.expectedmaxverticalorientationindegrees) property indicates the maximum angle between the up direction of an object instance and gravity specified in.
This parameter adds to the constraints on an estimated pose's upward direction. This option can be 0 if an item is up-right, for example. Object Anchors isn't meant to recognize things that aren't the same as the model. If a model is upright, it will not detect a sideways instance. For the side-down layout, a new model would be used. For articulation, the same criterion applies.

## MaxScaleChange

The [MaxScaleChange](/dotnet/api/microsoft.azure.objectanchors.objectquery.maxscalechange) property indicates the maximum object scale change (within 0 ~ 1) concerning spatial mapping. The estimated scale is applied to transformed object vertices that are axis-aligned and centered at the origin. Estimated scales may not be the exact scale between a CAD model and its physical representation, but specific parameters enable the app to create an object model with spatial mapping that is close to that of the physical thing.

## SearchAreas

The [SearchAreas](/dotnet/api/microsoft.azure.objectanchors.objectquery.searchareas) property indicates an array of spatial bounds that can be used to find the object.
The **observer** searches the union space of all search regions given in a query for objects. To save delay, we will only return one object with the highest confidence in this release.

## ObjectDiagnosticsSession

The [ObjectDiagnosticSession](/dotnet/api/microsoft.azure.objectanchors.diagnostics.objectdiagnosticssession) records diagnostics and writes data to an archive.

The scene point cloud, observer status, and model information are all stored in a diagnostics archive. This data is essential for identifying potential runtime difficulties. See the [FAQ](/azure/object-anchors/faq) for further information.
