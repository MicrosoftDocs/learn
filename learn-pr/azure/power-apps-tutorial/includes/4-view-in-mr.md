In Microsoft Power Apps, users can plan and build a business application using components rather than writing code in a traditional programming language like C#. They can design applications by dragging and dropping components into a canvas, just as they would design a slide in PowerPoint. Indicating logic and working with data can be achieved through Excel-like experience. Users can create apps that combine business data from several Microsoft and third-party sources. They are allowed to share the app so that users can run it in a browser or on a mobile device, and embed the app so they can run it in SharePoint, Power BI, or Teams.

## Controls and properties in canvas apps

* **Buttons** - Associate with the application by clicking or tapping.
* **Gallery** - Show a list of records that contain different sorts of data.
* **Drop down** - Shows the first item in a rundown until a chevron is selected.
* **Image** -  Show a picture from, for instance, a file or a data source.
* **Camera** -  Take and save photographs in the app or to a data source.

## Gallery control

A **Gallery** control can display multiple records from a data source, and each record can contain multiple types of data. For example, you can use **Gallery** control to show multiple products. Each item shows product details that include a name, an image, price, and, so on for each product.

Each data field is displayed in a separate control within the Gallery control. And you can configure these controls in your template. Any changes you make to the template will be reflected throughout the gallery control. Predefined templates are available for displaying images and text in a gallery and a gallery for items with varying heights.

> [!Important]
> If a user scrolls the **Flexible height** gallery control before all items are loaded, the item that's currently in view may be pushed down and out of view when the data loading is finished. To avoid this issue, use a standard **Gallery** control instead of the **Flexible height** variant.

## View in MR

The View in MR is one of the chief features included in the application. It allows the user to view images and 3D models in the natural world environment. The user can access it by clicking on the button; it overlays a selected 3D model or image onto the device's live camera feed.

3D content must be in the .glb file format and the image must be in .jpg or .png format. The MR components in Power Apps uses Babylon React Native.

* **Properties**

  * *Source* - The Data source recognizes the .glb file to display. The View in MR component supports loading models from:

  * *Object width* - Width of images displayed or 3D content.

  * *Object height* - Height of images displayed or 3D content.

  * *Object depth* - Three-dimensional depth of 3D content.

  * *Units* - The unit used for the width, height, and depth fields of the object.

  * *Photos* - The images captured during the mixed reality session.

* **How object scaling is handled**

  When a model is placed with the View in MR component, it uses the original dimensions of the model. These dimensions are labeled as Object Width, Object Height, and Object Depth properties.

  To change the size of the model, certain scaling techniques must be applied:

  * If no dimensions are defined, we accept that the model is already at its expected scale and leave it unchanged.
  * If one dimension is defined and the rest are default value of 0, we scale the entire object based on the specified dimension.
  * If two dimensions are defined, we adjust the model to match the given dimensions and average the scale for the third dimension.

     For example, say you had a model with an Object height of 8, an Object width of 5, and an Object depth of 3. You set Object height to 24, and Object width to 10, leave Object depth unchanged. The height has increased by a factor of 3, the width has increased by a factor of 2 -average of these two measurements to come to 2.5 and then scale the depth by that amount. The final scaled model would have an Object height of 24, Object width of 10, and Object depth of 7.25
  * If all three dimensions are set, we match the size of the model to what you specify.

## View in 3D

3D models can be added to your canvas apps. With simple gestures, users can rotate and zoom inside the model with the **View in 3D** component. A default shape is included in the component. You can change this shape to another by altering the **Source** property. By linking to a Gallery control, you can show a single 3D model or let the user choose from a gallery. The file format feasible with the View in 3D control are **.glb**, **.obj**, or **.stl**. Users can convert 3D models of any file format into **.glb** to use in their application.

If you want a gallery of 3D models, place the **View in 3D** component outside of the gallery and set its source to the gallery's specified property. Make sure your 3D models are optimized for use with Power Apps to assist decrease load times. You can use the View in 3D component to add **Pins** (visible as circular marks) to specified points on 3D models.

>[!Note]
>Multiple instances of the View in 3D component on the same screen can cause performance issues since each version of the component will attempt to load the 3D models simultaneously.