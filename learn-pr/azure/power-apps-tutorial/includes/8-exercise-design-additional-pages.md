## Create notes page

It is allowed to take pictures during the **View in MR** session and display them through a gallery. This is an additional feature included in the application to provide a good user experience. In the **Notes page** you'll be able to store some textual notes and store the images captured during **View in MR** session.

1. Create two new **Blank** screens and rename them as **Product_notes** and **Carpet_notes**.

    :::image type="content" source="../media/add-blank-notes-page.png" alt-text="Screenshot of new screens for notes" lightbox="../media/add-blank-notes-page.png":::

2. Design the **Product_notes** page by, clicking the **Input** dropdown and selecting **Text input**. Rename it as **TextInput_products**.

    :::image type="content" source="../media/add-text-input.png" alt-text="Screenshot of adding Text input" lightbox="../media/add-text-input.png":::

3. Select **Gallery** > **Horizontal** to include a horizontal type of gallery. You will be storing photos taken during the **View in MR** session in this gallery. Rename it as **View_products**

    :::image type="content" source="../media/horizontal-gallery.png" alt-text="Screenshot of adding horizontal gallery" lightbox="../media/horizontal-gallery.png":::

4. Position the gallery at the other part of the screen. Retain only the image by deleting the **Subtitle** and **Title**. Enlarge the image.

    :::image type="content" source="../media/retain-image.png" alt-text="Screenshot of only image in gallery" lightbox="../media/retain-image.png":::

5. Click the gallery added and configure the **Items** property by adding the following line:

    ```PowerApps
    ViewInMR1.Photos
    ```

    :::image type="content" source="../media/configure-items-property.png" alt-text="Screenshot of adding property to gallery" lightbox="../media/configure-items-property.png":::

    By doing so, all the pictures taken in the **View in MR** session is stored in this gallery for future references.

6. Let us now insert a label at the top of the screen. To do so, click on the **Label** option and **Center align** it. Then, customize the position, color, and text display according to your needs. Rename it to **Notes_label**.

    :::image type="content" source="../media/insert-label-notes.png" alt-text="Screenshot of inserting label" lightbox="../media/insert-label-notes.png":::

7. We will add a **Back** icon over the previously added **Label** to help the user navigate the **Home Page** when required. To add the **Back** icon, on the **Insert** tab, expand the **Icons** dropdown and select the **Back icon**.

    :::image type="content" source="../media/add-back-icon-notes.png" alt-text="Screenshot of adding back icon - notes" lightbox="../media/add-back-icon-notes.png":::

8. Position the **Back** icon correctly and configure the **OnSelect** property by adding the following

    ```PowerApps
    Navigate(Product_details,ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-back-icon-notes.png" alt-text="Screenshot of positioned and OnSelect" lightbox="../media/configure-back-icon-notes.png":::

9. Switch to the **Product_details** screen and add a **Note** icon from the **Icons** dropdown on the **Insert** tab.

    :::image type="content" source="../media/add-note-icon.png" alt-text="Screenshot of adding note icon" lightbox="../media/add-note-icon.png":::

10. Configure the **OnSelect** property of the **Note** icon by adding the following line:

    ```PowerApps
    Navigate(Product_notes,ScreenTransition.CoverRight)
    ```

    :::image type="content" source="../media/configure_note_icon.png" alt-text="Screenshot of OnSelect for note" lightbox="../media/configure_note_icon.png":::

11. Replicate the same procedure for **Notes_carpets**.

>[!Note]
> For the **Notes_carpets** page, exclude adding the **Gallery control** to store photos taken during the **View in MR** session since we won't be including the **View in MR** feature for the **Carpets** category.

>[!Tip]
>You can test your application by pressing the **F5** key on the keyboard or clicking the **Play** button at the top-right corner of Power Apps Studio.

## Create order summary page

1. Add a **Button** to **Product_details** and **Carpet_details** screens. Rename the button to **Order_product** and **Order_carpet** respectively. Change the display text of the button to **Order**.

    :::image type="content" source="../media/add-order-button.png" alt-text="Screenshot of adding order button" lightbox="../media/add-order-button.png":::

2. Create two new **Blank** screens and rename them as **Order_products** and **Order_carpets**.

    :::image type="content" source="../media/create-order-screens.png" alt-text="Screenshot of adding new screens" lightbox="../media/create-order-screens.png":::

3. Select **Product_details** screen configure the **OnSelect** property of the **Order** button as seen below:

    ```PowerApps
    Navigate('Order_products',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-order-button.png" alt-text="Screenshot of Order OnSelect config" lightbox="../media/configure-order-button.png":::

4. Follow the same procedure for **Carpet_details** screen.

5. In the **Order_products** page, insert **Product**, **Price**, **Color**, and **Notes** labels and rename them accordingly.

    :::image type="content" source="../media/insert-order-labels.png" alt-text="Screenshot of labels in Order_sofas" lightbox="../media/insert-order-labels.png":::

6. Insert empty labels next to the **Product**, **Price**, **Color**, and **Notes** as shown in the figure.

    :::image type="content" source="../media/create-empty-labels.png" alt-text="Screenshot of empty labels in Order_sofas" lightbox="../media/create-empty-labels.png":::

7. Configure the **Text** property of these empty labels in the following way:
    * **Product**:

        ```PowerApps
        Gallery_products.Selected.Name
        ```

        :::image type="content" source="../media/configure-product-label.png" alt-text="Screenshot of configuring Product text" lightbox="../media/configure-product-label.png":::

    * **Price**:

        ```PowerApps
        Gallery_products.Selected.Price
        ```

        :::image type="content" source="../media/configure-price-label.png" alt-text="Screenshot of configuring Price text" lightbox="../media/configure-price-label.png":::

    * **Color**:

        ```PowerApps
        Gallery_products.Selected.Color
        ```

        :::image type="content" source="../media/configure-color-label.png" alt-text="Screenshot of configuring Color text" lightbox="../media/configure-color-label.png":::

    * **Notes**:

        ```PowerApps
        TextInput_products.Text
        ```

        :::image type="content" source="../media/configure-notes-label.png" alt-text="Screenshot of configuring Notes text" lightbox="../media/configure-notes-label.png":::

8. Add another label at the top and change its display text to **Order Summary**. Change the font size and font according to your requirement.

    :::image type="content" source="../media/add-page-heading.png" alt-text="Screenshot of adding Order Summary label" lightbox="../media/add-page-heading.png":::

9. Expand the **Gallery** dropdown and select **Horizontal**. Retain only the image and delete other components of the **Gallery**. Rename it as **Order_gallery_products**

    :::image type="content" source="../media/add-horizontal-gallery-order.png" alt-text="Screenshot of adding gallery" lightbox="../media/add-horizontal-gallery-order.png":::

10. Configure the **Items** property of this gallery by adding the line given below:

    ```PowerApps
    ViewInMR1.Photos
    ```

    :::image type="content" source="../media/configure-items-property-order.png" alt-text="Screenshot of configure items in gallery" lightbox="../media/configure-items-property-order.png":::

11. Add three **Labels** and change the display text as **Enter your email to get an order confirmation mail!**, **Organization mail ID:**, and **Customer mail ID:** respectively.

    :::image type="content" source="../media/add-extra-labels.png" alt-text="Screenshot of 3 labels" lightbox="../media/add-extra-labels.png":::

12. Expand the **Input** dropdown and select **Text input**. Add two **Text input** components to the screen and position them as shown in the figure. Rename them as **Input1_products** and **Input2_products** respectively

    :::image type="content" source="../media/add-email-input.png" alt-text="Screenshot of 2 text input" lightbox="../media/add-email-input.png":::

13. Configure the **Hint text** property by adding **Enter mail ID:** and store no value in the **Default** property. Then, adjust the font size and color according to your need.

    :::image type="content" source="../media/add-hint-text.png" alt-text="Screenshot of configuring hint text" lightbox="../media/add-hint-text.png":::

14. Add a button from the **Insert** tab and configure its **Text** property by adding **Confirm**.

    :::image type="content" source="../media/add-confirm-button.png" alt-text="Screenshot of adding confirm button" lightbox="../media/add-confirm-button.png":::

15. Expand the **Icons** dropdown and select **Back** and **Home** icon. Position them correctly, as shown in the figure.

    :::image type="content" source="../media/add-back-home-icon.png" alt-text="Screenshot of adding back and home icon" lightbox="../media/add-back-home-icon.png":::

16. Configure the **OnSelect** property of these two icons in the following way:
    * **Back**:

        ```PowerApps
        Navigate(Product_details,ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-back-icon-order.png" alt-text="Screenshot of back OnSelect config" lightbox="../media/configure-back-icon-order.png":::

    * **Home**:

        ```PowerApps
        Navigate('Home Page',ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-home-icon-order.png" alt-text="Screenshot of configuring OnSelect - Order" lightbox="../media/configure-home-icon-order.png":::

17. Follow the same procedure for **Order_carpets**.

## Create end page

1. Create a **Blank** screen and rename it as **End page**.

    :::image type="content" source="../media/create-end-page.png" alt-text="Screenshot of end page" lightbox="../media/create-end-page.png":::

2. Add a **Label** and change its display text to **Order Successfully Submitted!**. Position the label as required on the screen.

    :::image type="content" source="../media/add-message-label.png" alt-text="Screenshot of adding label for Order Successfully Placed!" lightbox="../media/add-message-label.png":::

3. Add a **Button** at the bottom of the screen. Configure the **Text** property of the button by adding **Shop more**. Let's navigate the user to the home page by clicking the **Shop more** button by adding the following line in the **OnSelect** property.

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-shop-more-button.png" alt-text="Screenshot of show more button" lightbox="../media/configure-shop-more-button.png":::

4. Expand the **Media** dropdown and select **Image** to add an image component to the **End page**.

    :::image type="content" source="../media/add-image-order.png" alt-text="Screenshot of adding image component" lightbox="../media/add-image-order.png":::

5. Position the image as shown in the figure. Select the **logo** file to display.

    :::image type="content" source="../media/add-logo-order.png" alt-text="Screenshot of adding logo file to the image component" lightbox="../media/add-logo-order.png":::

>[!Tip]
> Save your application now and then by clicking the **File** tab at the top and selecting the **Save** option. Next if prompted, select the **The cloud** option and click **Save**.

## Send emails via Power Apps

1. Click the **Data** tab and select **+ Add data**. Next, expand the **Connectors** to select **Office 365 Outlook** to add it as one of the connectors for this application.

    :::image type="content" source="../media/add-office-365-outlook.png" alt-text="Screenshot of add data connectors for mail" lightbox="../media/add-office-365-outlook.png":::

2. Open the **Order_products** and configure the **OnSelect** property of the **Confirm** button by adding the following lines:

    ```PowerApps
    Office365Outlook.SendEmailV2(Input1_products & ";"& Input2_products,"Order Summary","<b> Your order is successfully submitted! </b> <br> Order details are as follows: <ul> <li> Product: " & Order_product_name_details & "</li> <li> Price: " & Order_price_details & "</li> <li> Color: " & Order_color_details & "</li> </ul>Notes: " & TextInput_products & "<br><b> Thank you for shopping with us! </b>");
    Navigate('End page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-confirm-email-button.png" alt-text="Screenshot of configuring confirm button" lightbox="../media/configure-confirm-email-button.png":::

    >[!Note]
    >The names used in the above function follow the namings used in this application at the time of development. You may customize the function concerning your application.

## Test your application in mobile device

1. Choose the download link for your device:
    * For iOS (iPad or iPhone), go to the [App Store](https://itunes.apple.com/app/powerapps/id1047318566?mt=8).
    * For Android, go to [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.msapps).

2. Open Power Apps on your mobile device, and sign in by using your Microsoft account credentials.

3. The apps that you used recently will show on the default screen when you sign in to Power Apps mobile.

    The Home is the default screen when you sign in. It shows the apps that you used recently and the apps that have marked as favorites.

4. To run an app on a mobile device, select the app tile. If this is the first time you're running a canvas app by using Power Apps mobile, a screen shows the swipe gestures.

5. Use your finger to swipe from the left edge of the app to the right to close an app. On Android devices, you can also press the Back button and then confirm that you intended to close the app.

>[!Note]
> If an app requires a connection to a data source or permission to use the device's capabilities (such as the camera or location services), you must give consent before you can use the app. Typically, you're prompted only the first time you run the app.
