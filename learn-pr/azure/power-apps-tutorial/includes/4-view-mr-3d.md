To enable numerous 3D and mixed reality (MR) scenarios, you can add several MR components to your canvas app. Components are collections of controls that you can use to address specific requirements. You can, for example, use these MR components to:

* View and manipulate 3D content.
* Overlay 3D content and 2D images onto the feed from the camera.
* Measure distance, area, and volume using your device with MR.
* Identify spaces in the real world through an MR overlay.

We'll incorporate some of these mixed-reality features in our **Easy Sales** application.

## View in MR

View in MR is one of the chief features included in the application. It allows the user to view images and 3D models in the natural-world environment. The user can access it by clicking on the button; it overlays selected 3D models or images onto the device's live camera feed.

3D content must be in the .glb file format, and the image must be in either the .jpg or .png formats. The MR components in Power Apps use Babylon React Native.

* **Properties**

  * **Source**: The Data source recognizes the .glb file to display. The View in the MR component supports loading models from:

    * **Object width**: Width of images displayed or 3D content.

    * **Object height**: Height of images displayed or 3D content.

    * **Object depth**: Three-dimensional depth of 3D content.

    * **Units**: The unit used for the width, height, and depth fields of the object.

    * **Photos** The images captured during the mixed reality session.

* **How object scaling is handled**

  When a model is placed with the View in the MR component, it uses the model's original dimensions. These dimensions are the Object Width, Object Height, and Object Depth properties.

  Let's use the scaling techniques to change the model's size.

  * If no dimensions are defined, we accept that the model is already at its expected scale, and we leave it unchanged.
  * If one dimension is defined and the rest are default values of 0, we scale the entire object based on the specified dimension.
  * If two dimensions are defined, we adjust the model to match the given dimensions and then average the scale for the third dimension.

  For example, say you have a model with an Object height of 8, Object width of 5, and Object depth of 3. You set Object height to 24 and Object width to 10, leaving Object depth unchanged. The height is increased by 3, and the width is increased by 2. The average of these two measurements comes to 2.5. Later, we scale the depth by that amount. The final scaled model would have an Object height of 24, Object width of 10, and Object depth of 7.25.

  * If all three dimensions are set, we match the model's size to what you specify.

## View in 3D

3D models can be added to your canvas apps. With simple gestures, users can rotate and zoom the model with the **View in 3D** component. A default shape is included in the component. You can change this shape to another by altering the **Source** property. By linking to a Gallery control, you can show a single 3D model or let the user choose from a gallery. The feasible file formats with the View in 3D control are **.glb**, **.obj**, or **.stl**. Users can convert 3D models of any file format into **.glb** to use in their application.

If you want a gallery of 3D models, place the **View in 3D** component outside of the gallery and set its source to the gallery's specified property. Make sure your 3D models are optimized for use with Power Apps to help decrease load times. You can use the View in 3D component to add **Pins** (visible as circular marks) to specified points on 3D models.

> [!NOTE]
> Multiple instances of the View in 3D component on the same screen can cause performance issues, because each version of the component will attempt to load the 3D models simultaneously.
