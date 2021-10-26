In this module, you'll be using some of the key functional components of **Power Apps**. This includes, Measure in MR, Emailing via Power Apps, Filtering ways and techniques, and so on. Users can measure distance, area, and volume in the real world with Power Apps' **Measure in MR** component.

## Spatial filtering using Measure in MR

We will leverage the power of **Measure in MR** in spatially filtering the products that can be easily placed in the real world according to the measurements received through the measuring session. We will also use some basic formulas to perform the filtering.

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

    ```Power Apps
    MeasureInMR1.Measurements
    ```

    :::image type="content" source="../media/gallery-data-source.png" alt-text="Screenshot of gallery data source" lightbox="../media/gallery-data-source.png":::

6. Remove the **Separator** and **NextArrow**. Position the **Title**, **Subtitle**, and **Body** equidistant from each other as shown in the picture.

    :::image type="content" source="../media/equidistant.png" alt-text="Screenshot of equidistant" lightbox="../media/equidistant.png":::

7. Configure the **Text** property of the three labels in the following way respectively:
    * **Title**:

        ```Power Apps
        "Unit: "&ThisItem.Unit
        ```

         :::image type="content" source="../media/title-text.png" alt-text="Screenshot of title text" lightbox="../media/title-text.png":::

    * **Subtitle**:

        ```Power Apps
        "Area: "&ThisItem.Area&"cm²"
        ```

         :::image type="content" source="../media/subtitle-text.png" alt-text="Screenshot of subtitle text" lightbox="../media/subtitle-text.png":::

    * **Body**:

        ```Power Apps
        "Height: "&ThisItem.Height&"cm"
        ```

         :::image type="content" source="../media/body-text.png" alt-text="Screenshot of body text" lightbox="../media/body-text.png":::

8. Let's add a **Reload** icon to let the users redo the measurements if they are not happy. On the **Insert** tab, expand the **Icons** dropdown and select **Reload** icon.
    :::image type="content" source="../media/add-reload-icon.png" alt-text="Screenshot of adding reload icon" lightbox="../media/add-reload-icon.png":::

9. Position the icon as shown in the figure and configure the **OnSelect** property in the following way:

    ```Power Apps
    UpdateContext({galleryvisible:false});
    ```

    :::image type="content" source="../media/configure-on-select.png" alt-text="Screenshot of configuring OnSelect for reload icon" lightbox="../media/configure-on-select.png":::

    >[!Tip]
    > You may customize the font, font size, and font style to match the design of your application. However, make sure you maintain a harmonious font throughout the application for a better user experience.

10. Once the **Measure in MR** component is fully configured, we move to the **Spatial filtering**. Navigate to the **Sofas** page and configure the **Items** property of the **Gallery_sofas** by adding the following:

    ```PowerApps
    If (
    Measure_gallery.Selected.Height = 0,
    Filter('Easy Sales - Sofas', Area <= Measure_gallery.Selected.Area),
    Measure_gallery.Selected.Height > 0,
    Filter('Easy Sales - Sofas', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Sofas'
    )
    ```

    :::image type="content" source="../media/configure-item-sofas.png" alt-text="Screenshot of configuring items in Sofas" lightbox="../media/configure-item-sofas.png":::

    >[!Important]
    > Provide appropriate names for the **SharePoint** list and **Gallery** to avoid having errors in the future. Maintain the names of the components in the formulas to avoid confusion.

11. Follow the same procedure for **Chairs** and **Tables** page. Configure the **Items** property in the following way respectively:

    * **Chairs**:

        ```Power Apps
        If (
        Measure_gallery.Selected.Height = 0,
        Filter('Easy Sales - Chairs', Area <= Measure_gallery.Selected.Area),
        Measure_gallery.Selected.Height > 0,
        Filter('Easy Sales - Chairs', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Chairs'
        )
        ```

    * **Tables**:

        ```Power Apps
        If (
        Measure_gallery.Selected.Height = 0,
        Filter('Easy Sales - Tables', Area <= Measure_gallery.Selected.Area),
        Measure_gallery.Selected.Height > 0,
        Filter('Easy Sales - Tables', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Tables'
        )
        ```

>[!Note]
> Spatial Filtering is not included for **Carpets** page as another feature specific to the product is added. The area measured in **Measure in MR** session will be used to estimate the price of the selected carpet.

>[!Tip]
> Save your application now and then by clicking the **File** tab at the top and selecting the **Save** option. Next if prompted, select the **The cloud** option and click **Save**.

## Calculate price based on area

1. Click on **Details_carpets** page, Add a **Label** and rename it as **Area_carpets**.

    :::image type="content" source="../media/add-area-label.png" alt-text="Screenshot of Area calculation" lightbox="../media/add-area-label.png":::

2. Add another empty **Label** beside the **Area_carpets** label and configure the **Text** property of the empty label following way to display the area calculated:

    ```Power Apps
    Measure_gallery.Selected.Area&"cm²"
    ```

    :::image type="content" source="../media/configure-area.png" alt-text="Screenshot of Area calculation" lightbox="../media/configure-area.png":::

3. Configure the label next to the **Price** label in the following way to display the calculated price:

    ```Power Apps
    "$"&Measure_gallery.Selected.Area * content_carpets.'Price/cm2'
    ```

    :::image type="content" source="../media/configure-price.png" alt-text="Screenshot of Price calculation" lightbox="../media/configure-price.png":::

## Create order summary page

1. Add a **Button** to **Details_sofas**, **Details_chairs**, **Details_tables**, and **Details_carpets** screens. Rename the button to **Order_button_(category_name)** and change the display text of the button to **Order**.

    :::image type="content" source="../media/add-order-button.png" alt-text="Screenshot of adding order button" lightbox="../media/add-order-button.png":::

2. Create four new **Blank** screens and rename them as **Order_sofas**, **Order_chairs**, **Order_tables**, and **Order_carpets**.

    :::image type="content" source="../media/create-order-screens.png" alt-text="Screenshot of adding new screens" lightbox="../media/create-order-screens.png":::

3. Select **Details_sofas** screen configure the **OnSelect** property of the **Order** button as seen below:

    ```Power Apps
    Navigate('Order_sofas',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-order-button.png" alt-text="Screenshot of Order OnSelect config" lightbox="../media/configure-order-button.png":::

4. Follow the same procedure for **Details_chairs**, **Details_tables**, and **Details_carpets** screens.

5. In the **Order_sofas** page, insert **Product**, **Price**, **Color**, and **Notes** labels and rename them accordingly.

    :::image type="content" source="../media/insert-order-labels.png" alt-text="Screenshot of labels in Order_sofas" lightbox="../media/insert-order-labels.png":::

6. Insert empty labels next to the **Product**, **Price**, **Color**, and **Notes** as shown in the figure.

    :::image type="content" source="../media/create-empty-labels.png" alt-text="Screenshot of empty labels in Order_sofas" lightbox="../media/create-empty-labels.png":::

7. Configure the **Text** property of these empty labels in the following way:
    * **Product**:

        ```Power Apps
        Gallery_sofas.Selected.'Name (Title)'
        ```

        :::image type="content" source="../media/configure-product-label.png" alt-text="Screenshot of configuring Product text" lightbox="../media/configure-product-label.png":::

    * **Price**:

        ```Power Apps
        Gallery_sofas.Selected.Price
        ```

        :::image type="content" source="../media/configure-price-label.png" alt-text="Screenshot of configuring Price text" lightbox="../media/configure-price-label.png":::

    * **Color**:

        ```Power Apps
        Gallery_sofas.Selected.Color
        ```

        :::image type="content" source="../media/configure-color-label.png" alt-text="Screenshot of configuring Color text" lightbox="../media/configure-color-label.png":::

    * **Notes**:

        ```Power Apps
        TextInput_sofas.Text
        ```

        :::image type="content" source="../media/configure-notes-label.png" alt-text="Screenshot of configuring Notes text" lightbox="../media/configure-notes-label.png":::

8. Add another label at the top and change its display text to **Order Summary**. Change the font size and font according to your requirement.

    :::image type="content" source="../media/add-page-heading.png" alt-text="Screenshot of adding Order Summary label" lightbox="../media/add-page-heading.png":::

9. Expand the **Gallery** dropdown and select **Horizontal**. Retain only the image and delete other components of the **Gallery**. Rename it as **Order_gallery_sofas**

    :::image type="content" source="../media/add-horizontal-gallery-order.png" alt-text="Screenshot of adding gallery" lightbox="../media/add-horizontal-gallery-order.png":::

10. Configure the **Items** property of this gallery by adding the line given below:

    ```Power Apps
    ViewInMR.Photos
    ```

    :::image type="content" source="../media/configure-items-property-order.png" alt-text="Screenshot of configure items in gallery" lightbox="../media/configure-items-property-order.png":::

11. Add three **Labels** and change the display text as **Enter your email to get an order confirmation mail!**, **Organization mail ID:**, and **Customer mail ID:** respectively.

    :::image type="content" source="../media/add-extra-labels.png" alt-text="Screenshot of 3 labels" lightbox="../media/add-extra-labels.png":::

12. Expand the **Input** dropdown and select **Text input**. Add two **Text input** components to the screen and position them as shown in the figure. Rename them as **Input1_sofas** and **Input2_sofas** respectively

    :::image type="content" source="../media/add-email-input.png" alt-text="Screenshot of 2 text input" lightbox="../media/add-email-input.png":::

13. Configure the **Hint text** property by adding **Enter mail ID:** and store no value in the **Default** property. Then, adjust the font size and color according to your need.

    :::image type="content" source="../media/add-hint-text.png" alt-text="Screenshot of configuring hint text" lightbox="../media/add-hint-text.png":::

14. Add a button from the **Insert** tab and configure its **Text** property by adding **Confirm**.

    :::image type="content" source="../media/add-confirm-button.png" alt-text="Screenshot of adding confirm button" lightbox="../media/add-confirm-button.png":::

15. Expand the **Icons** dropdown and select **Back** and **Home** icon. Position them correctly, as shown in the figure.

    :::image type="content" source="../media/add-back-home-icon.png" alt-text="Screenshot of adding back and home icon" lightbox="../media/add-back-home-icon.png":::

16. Configure the **OnSelect** property of these two icons in the following way:
    * **Back**:

        ```Power Apps
        Navigate(Details_sofas,ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-back-icon-order.png" alt-text="Screenshot of back OnSelect config" lightbox="../media/configure-back-icon-order.png":::

    * **Home**:

        ```Power Apps
        Navigate('Home Page',ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-home-icon-order.png" alt-text="Screenshot of configuring OnSelect - Order" lightbox="../media/configure-home-icon-order.png":::

17. Follow the same procedure for  **Order_chairs**, **Order_tables**, and **Order_carpets**.

## Create end page

1. Create a **Blank** screen and rename it as **End page**.

    :::image type="content" source="../media/create-end-page.png" alt-text="Screenshot of end page" lightbox="../media/create-end-page.png":::

2. Add a **Label** and change its display text to **Order Successfully Submitted!**. Position the label as required on the screen.

    :::image type="content" source="../media/add-message-label.png" alt-text="Screenshot of adding label for Order Successfully Placed!" lightbox="../media/add-message-label.png":::

3. Add a **Button** at the bottom of the screen. Configure the **Text** property of the button by adding **Shop more**. Let's navigate the user to the home page by clicking the **Shop more** button by adding the following line in the **OnSelect** property.

    ```Power Apps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-shop-more-button.png" alt-text="Screenshot of show more button" lightbox="../media/configure-shop-more-button.png":::

4. Expand the **Media** dropdown and select **Image** to add an image component to the **End page**.

    :::image type="content" source="../media/add-image-order.png" alt-text="Screenshot of show more button" lightbox="../media/add-image-order.png":::

5. Position the image as shown in the figure. Select the **logo** file to display.

    :::image type="content" source="../media/add-logo-order.png" alt-text="Screenshot of show more button" lightbox="../media/add-logo-order.png":::

>[!Tip]
> Save your application now and then by clicking the **File** tab at the top and selecting the **Save** option. Next if prompted, select the **The cloud** option and click **Save**.

## Send emails via Power Apps

1. Click the **Data** tab and select **+ Add data**. Next, expand the **Connectors** to select **Office 365 Outlook** to add it as one of the connectors for this application.

    :::image type="content" source="../media/add-office-365-outlook.png" alt-text="Screenshot of add data connectors for mail" lightbox="../media/add-office-365-outlook.png":::

2. Open the **Order_sofas** and configure the **OnSelect** property of the **Confirm** button by adding the following lines:

    ```Power Apps
    Office365Outlook.SendEmailV2(Input1_sofas & ";"& Input2_sofas,"Order Summary","<b> Your order is successfully submitted! </b> <br>
    Order details are as follows: <ul> <li> Product: " & Sofas_product_details & "</li> <li> Price: " & Sofas_price_details & "</li> <li> Color: " & Sofas_color_details & "</li> </ul>Notes: " & TextInput_sofas & "<br><b> Thank you for shopping with us! </b>");
    Navigate('End page',ScreenTransition.Cover) 
    ```

    :::image type="content" source="../media/configure-confirm-email-button.png" alt-text="Screenshot of configuring confirm button" lightbox="../media/configure-confirm-email-button.png":::

    >[!Note]
    >The names used in the above function follow the namings used in this application at the time of development. You may customize the function concerning your application.
