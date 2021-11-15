In this module, you'll be using some of the key functional components of **Power Apps**. This includes, Measure in MR, Filtering ways, and so on. Users can measure distance, area, and volume in the real world with Power Apps' **Measure in MR** component.

## Spatial filtering using Measure in MR

**Measure in MR** feature is used to spatially filtering the products that can be easily placed in the real world according to the measurements received through the measuring session. Some basic formulas are used to perform the filtering.

1. Navigate to the **Home page** and on the **Insert** tab, expand the **Mixed Reality** dropdown, and select **Measure in MR**.

    :::image type="content" source="../media/add-measure-in-mr.png" alt-text="Screenshot to add Measure in MR" lightbox="../media/add-measure-in-mr.png":::

2. Position the **Measure in MR** button as shown in the figure and configure the following properties:
    * **Text**: Filter by Dimensions
    * **Unit of measurement**: Centimeters
    * **Measurement type**: Freeform

    :::image type="content" source="../media/configure-property-measure.png" alt-text="Screenshot to configure the properties of Measure in MR" lightbox="../media/configure-property-measure.png":::

3. In the **Home page** add a **Gallery** by selecting the **Gallery** > **Vertical**. Rename the **Gallery** to **Measure_gallery**.

    :::image type="content" source="../media/add-gallery.png" alt-text="Screenshot to add gallery" lightbox="../media/add-gallery.png":::

4. Position the **Vertical Gallery** just below the **Filter by Dimensions** button. Next, configure the **Layout** property by selecting **Title, Subtitle, and body**.

    :::image type="content" source="../media/configure-layout.png" alt-text="Screenshot to configure layout" lightbox="../media/configure-layout.png":::

5. Configure the **Items** property of the **Measure_gallery** by adding the following line:

    ```PowerApps
    MeasureInMR1.Measurements
    ```

    :::image type="content" source="../media/gallery-data-source.png" alt-text="Screenshot of gallery data source" lightbox="../media/gallery-data-source.png":::

6. Remove the **Separator** and **NextArrow**. Position the **Title**, **Subtitle**, and **Body** equidistant from each other as shown in the picture.

    :::image type="content" source="../media/equidistant.png" alt-text="Screenshot of equidistant" lightbox="../media/equidistant.png":::

7. Configure the **Text** property of the three labels in the following way respectively:
    * **Title**:

        ```PowerApps
        "Unit: "&ThisItem.Unit
        ```

         :::image type="content" source="../media/title-text.png" alt-text="Screenshot of title text" lightbox="../media/title-text.png":::

    * **Subtitle**:

        ```PowerApps
        "Area: "&ThisItem.Area&"cm²"
        ```

         :::image type="content" source="../media/subtitle-text.png" alt-text="Screenshot of subtitle text" lightbox="../media/subtitle-text.png":::

    * **Body**:

        ```PowerApps
        "Height: "&ThisItem.Height&"cm"
        ```

         :::image type="content" source="../media/body-text.png" alt-text="Screenshot of body text" lightbox="../media/body-text.png":::

8. Let's add a **Reload** icon to let the users redo the measurements if they are not happy. On the **Insert** tab, expand the **Icons** dropdown and select **Reload** icon.

    :::image type="content" source="../media/add-reload-icon.png" alt-text="Screenshot of adding reload icon" lightbox="../media/add-reload-icon.png":::

9. Position the icon as shown in the figure and configure the **OnSelect** property in the following way:

    ```PowerApps
    UpdateContext({galleryvisible:false});
    ```

    :::image type="content" source="../media/configure-on-select.png" alt-text="Screenshot of configuring OnSelect for reload icon" lightbox="../media/configure-on-select.png":::

    >[!Tip]
    > You may customize the font, font size, and font style to match the design of your application. However, make sure you maintain a harmonious font throughout the application for a better user experience.

10. Once the **Measure in MR** component is fully configured, we move to the **Spatial filtering**. Here we are spatially filtering the products based on the **Width**, **Depth**, and **Height** values received in the **Measure in MR** session.

    Navigate to the **Products** page and configure the **Items** property of the **Gallery_products** by adding the following:

    ```PowerApps
    If(
    ID = 1 And Measure_gallery.Selected.Height = 0,
    (Filter('Easy Sales',(ProductCategory = "Sofa") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth)))),
    ID = 1 And Measure_gallery.Selected.Height > 0,
    (Filter('Easy Sales',(ProductCategory = "Sofa") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth And Height <= Measure_gallery.Selected.Height) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth And Height <= Measure_gallery.Selected.Height)))),
    ID = 1,
    Filter('Easy Sales',ProductCategory = "Sofa"), 
    
    ID = 2,
    Filter('Easy Sales',ProductCategory = "Chair"), 
    ID = 2 And Measure_gallery.Selected.Height = 0,
    (Filter('Easy Sales',(ProductCategory = "Chair") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth)))),
    ID = 2 And Measure_gallery.Selected.Height > 0,
    (Filter('Easy Sales',(ProductCategory = "Chair") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth And Height <= Measure_gallery.Selected.Height) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth And Height <= Measure_gallery.Selected.Height)))),
    
    ID = 3,
    Filter('Easy Sales',ProductCategory = "Table"),
    ID = 3 And Measure_gallery.Selected.Height = 0,
    (Filter('Easy Sales',(ProductCategory = "Table") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth)))),
    ID = 3 And Measure_gallery.Selected.Height > 0,
    (Filter('Easy Sales',(ProductCategory = "Table") And ((Depth < Measure_gallery.Selected.BoundingDepth And Width < Measure_gallery.Selected.BoundingWidth And Height <= Measure_gallery.Selected.Height) Or (Depth < Measure_gallery.Selected.BoundingWidth And Width < Measure_gallery.Selected.BoundingDepth And Height <= Measure_gallery.Selected.Height))))
    )
    ```

    :::image type="content" source="../media/configure-item-sofas.png" alt-text="Screenshot of configuring items in Sofas" lightbox="../media/configure-item-sofas.png":::

>[!Important]
> Provide appropriate names for the **SharePoint** list and **Gallery** to avoid having errors in the future. Maintain the names of the components in the formulas to avoid confusion.

>[!Note]
> Spatial Filtering is not included for **Carpets** page as another feature specific to the product is added. The area measured in **Measure in MR** session will be used to estimate the price of the selected carpet.

>[!Tip]
> Save your application now and then by clicking the **File** tab at the top and selecting the **Save** option. Next if prompted, select the **The cloud** option and click **Save**.

## Calculate price based on area

1. Click on **Carpet_details** page, Add a **Label** and rename it as **Area_carpets**.

    :::image type="content" source="../media/add-area-label.png" alt-text="Screenshot of adding area label" lightbox="../media/add-area-label.png":::

2. Add another empty **Label** beside the **Area_carpets** label and configure the **Text** property of the empty label following way to display the area calculated:

    ```PowerApps
    Measure_gallery.Selected.Area&"cm²"
    ```

    :::image type="content" source="../media/configure-area.png" alt-text="Screenshot of Area calculation" lightbox="../media/configure-area.png":::

3. Configure the label next to the **Price** label in the following way to display the calculated price:

    ```PowerApps
    "$"&Measure_gallery.Selected.Area * content_carpets.'Price/cm2'
    ```

    :::image type="content" source="../media/configure-price.png" alt-text="Screenshot of Price calculation" lightbox="../media/configure-price.png":::
