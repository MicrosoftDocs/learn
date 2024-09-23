In this unit, you'll be using some of the key functional components of **Power Apps**. This includes Measure in MR and Filtering ways. Users can measure distance, area, and volume in the real world with Power Apps' **Measure in MR** component.

## Spatial filtering using Measure in MR

The **Measure in MR** feature is used for spatially filtering the products that can be easily placed in the real world according to the measurements received through the measuring session. Some basic formulas are used to perform the filtering.

1. Navigate to the **Home page**. On the **Insert** tab, expand the **Mixed Reality** dropdown and select **Measure in MR**.

    :::image type="content" source="../media/add-measure-in-mr.png" alt-text="Screenshot to add Measure in MR" lightbox="../media/add-measure-in-mr.png":::

2. Position the **Measure in MR** button as shown in the figure and configure the following properties:

    * **Text**: Filter by Dimensions
    * **Unit of measurement**: Centimeters
    * **Measurement type**: Freeform

    :::image type="content" source="../media/configure-property-measure.png" alt-text="Screenshot to configure the properties of Measure in MR." lightbox="../media/configure-property-measure.png":::

3. On the **Home page**, add a **Gallery** by selecting the **Gallery** > **Vertical**. Change the name of **Gallery** to **Measure_gallery**.

    :::image type="content" source="../media/add-gallery.png" alt-text="Screenshot to add gallery." lightbox="../media/add-gallery.png":::

4. Position the **Vertical Gallery** just below the **Filter by Dimensions** button. Configure the **Layout** property by selecting **Title, Subtitle, and body**.

    :::image type="content" source="../media/configure-layout.png" alt-text="Screenshot to configure layout" lightbox="../media/configure-layout.png":::

5. Configure the **Items** property of the **Measure_gallery** by adding the following line:

    ```PowerApps
    MeasureInMR1.Measurements
    ```

    :::image type="content" source="../media/gallery-data-source.png" alt-text="Screenshot of gallery data source." lightbox="../media/gallery-data-source.png":::

6. Remove the **Separator** and **NextArrow**. Position the **Title**, **Subtitle**, and **Body** equidistant from each other as shown in the image.

    :::image type="content" source="../media/equidistant.png" alt-text="Screenshot of equidistant placement." lightbox="../media/equidistant.png":::

7. Configure the **Text** property of the three labels as follows:

    * **Title**:

        ```PowerApps
        "Unit: "&ThisItem.Unit
        ```

         :::image type="content" source="../media/title-text.png" alt-text="Screenshot of title text" lightbox="../media/title-text.png":::

    * **Subtitle**:

        ```PowerApps
        "Area: "&ThisItem.Area&"cm²"
        ```

         :::image type="content" source="../media/subtitle-text.png" alt-text="Screenshot of subtitle text." lightbox="../media/subtitle-text.png":::

    * **Body**:

        ```PowerApps
        "Height: "&ThisItem.Height&"cm"
        ```

         :::image type="content" source="../media/body-text.png" alt-text="Screenshot of body text." lightbox="../media/body-text.png":::

8. Let's add a **Reload** icon to let the users redo the measurements if they're not happy. On the **Insert** tab, expand the **Icons** dropdown and select the **Reload** icon.

    :::image type="content" source="../media/add-reload-icon.png" alt-text="Screenshot of adding reload icon." lightbox="../media/add-reload-icon.png":::

9. Position the icon as shown in the image and configure the **OnSelect** property as follows:

    ```PowerApps
    UpdateContext({galleryvisible:false});
    ```

    :::image type="content" source="../media/configure-on-select.png" alt-text="Screenshot of configuring OnSelect for reload icon." lightbox="../media/configure-on-select.png":::

    > [!TIP]
    > You can customize the font, font size, and font style to match the design of your application. However, for a better user experience, maintain a consistent font throughout the application.

10. Once the **Measure in MR** component is fully configured, we move to **Spatial filtering**. Here, we spatially filter the products based on the **Width**, **Depth**, and **Height** values received in the **Measure in MR** session.

    Navigate to the **Products** page, then configure the **Items** property of the **Gallery_products** as follows:

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

    :::image type="content" source="../media/configure-item-sofas.png" alt-text="Screenshot of configuring items in Sofas." lightbox="../media/configure-item-sofas.png":::

    > [!IMPORTANT]
    > Provide appropriate names for the **SharePoint** list and **Gallery** to avoid having errors in the future. Maintain the names of the components in the formulas to avoid confusion.

    > [!NOTE]
    > Spatial Filtering is not included for the **Carpets** page since another feature specific to the product is added. The area measured in the **Measure in MR** session will be used to estimate the price of the selected carpet.

    > [!TIP]
    > Save your application frequently by selecting the **File** tab at the top and selecting the **Save** option. If prompted, select the **The cloud** option, and then select **Save**.

## Calculate price based on area

1. Go to the **Carpet_details** page, then add a **Label**, and then rename it **Area_carpets**.

    :::image type="content" source="../media/add-area-label.png" alt-text="Screenshot of adding area label" lightbox="../media/add-area-label.png":::

2. Add another empty **Label** beside the **Area_carpets** label and then configure the **Text** property of the blank label as follows to display the area calculated:

    ```PowerApps
    Measure_gallery.Selected.Area&"cm²"
    ```

    :::image type="content" source="../media/configure-area.png" alt-text="Screenshot of Area calculation." lightbox="../media/configure-area.png":::

3. Configure the label next to the **Price** label as follows to display the calculated price:

    ```PowerApps
    "$"&Measure_gallery.Selected.Area * content_carpets.'Price/cm2'
    ```

    :::image type="content" source="../media/configure-price.png" alt-text="Screenshot of Price calculation." lightbox="../media/configure-price.png":::

After implementing the above steps, your application will spatially filter out products and calculate the accurate price for the carpets based on your real-world measurements.

:::image type="content" source="../media/application-demo-3.gif" alt-text="Animation of application demo after implementing measure in mr and spatial filtering." lightbox="../media/application-demo-3.gif":::
