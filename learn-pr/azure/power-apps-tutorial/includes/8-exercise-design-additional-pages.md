In this unit, you'll design some additional pages to support your mixed reality features. These pages carry out some specific functions that are required in order for the application to behave appropriately. You'll also be using the emailing functionality of Power Apps to send the order details to the customers.

## Create notes page

The user can take pictures during the **View in MR** session and display them through a gallery. On the **Notes page**, you can store textual notes and images captured during **View in MR** session.

1. Create two new **Blank** screens and rename them **Product_notes** and **Carpet_notes**.

    :::image type="content" source="../media/add-blank-notes-page.png" alt-text="Screenshot of new screens for notes." lightbox="../media/add-blank-notes-page.png":::

2. Design the **Product_notes** page: Select the **Input** dropdown, and then select **Text input**. Rename it **TextInput_products**.

    :::image type="content" source="../media/add-text-input.png" alt-text="Screenshot of adding Text input." lightbox="../media/add-text-input.png":::

3. Select **Gallery** > **Horizontal** to include a horizontal type of gallery. You'll be storing photos taken during the **View in MR** session in this gallery. Rename the gallery **View_products**.

    :::image type="content" source="../media/horizontal-gallery.png" alt-text="Screenshot of adding horizontal gallery." lightbox="../media/horizontal-gallery.png":::

4. Position the gallery at the other part of the screen. Retain only the image by deleting the **Subtitle** and **Title**. Enlarge the image.

    :::image type="content" source="../media/retain-image.png" alt-text="Screenshot of only image in gallery." lightbox="../media/retain-image.png":::

5. Select the gallery and configure the **Items** property by adding the following line:

    ```PowerApps
    ViewInMR1.Photos
    ```

    :::image type="content" source="../media/configure-items-property.png" alt-text="Screenshot of adding property to gallery." lightbox="../media/configure-items-property.png":::

    All the pictures taken in the **View in MR** session are stored in this gallery for future reference.

6. Let's insert a label at the top of the screen. Select the **Label** option and then **Center align** it. Customize the position, color, and text display according to your needs. Rename it  **Notes_label**.

    :::image type="content" source="../media/insert-label-notes.png" alt-text="Screenshot of inserting label." lightbox="../media/insert-label-notes.png":::

7. We'll place a **Back** icon over the previously added **Label** to help the user navigate to the **Home Page** when required. To add the **Back** icon, on the **Insert** tab, expand the **Icons** dropdown and then select the **Back icon**.

    :::image type="content" source="../media/add-back-icon-notes.png" alt-text="Screenshot of adding back icon." lightbox="../media/add-back-icon-notes.png":::

8. Position the **Back** icon correctly and configure the **OnSelect** property by adding the following:

    ```PowerApps
    Navigate(Product_details,ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-back-icon-notes.png" alt-text="Screenshot of positioned and OnSelect." lightbox="../media/configure-back-icon-notes.png":::

9. Switch to the **Product_details** screen and add a **Note** icon from the **Icons** dropdown on the **Insert** tab.

    :::image type="content" source="../media/add-note-icon.png" alt-text="Screenshot of adding note icon." lightbox="../media/add-note-icon.png":::

10. Configure the **OnSelect** property of the **Note** icon by adding the following line:

    ```PowerApps
    Navigate(Product_notes,ScreenTransition.CoverRight)
    ```

    :::image type="content" source="../media/configure-note-icon.png" alt-text="Screenshot of OnSelect for note." lightbox="../media/configure-note-icon.png":::

11. Replicate the same procedure for **Notes_carpets**.

    > [!NOTE]
    > We won't include the **View in MR** feature for the **Carpets** category. For the **Notes_carpets** page, exclude adding the **Gallery control** to store photos taken during the **View in MR** session.

    > [!TIP]
    > You can test your application by pressing the **F5** key on the keyboard or selecting the **Play** button at the top-right corner of Power Apps Studio.

## Create order summary page

1. Add buttons to the **Product_details** and **Carpet_details** screens. Rename the buttons **Order_product** and **Order_carpet**. Change the display text of the buttons to **Order**.

    :::image type="content" source="../media/add-order-button.png" alt-text="Screenshot of adding order button." lightbox="../media/add-order-button.png":::

2. Create two new **Blank** screens and rename them **Order_products** and **Order_carpets**.

    :::image type="content" source="../media/create-order-screens.png" alt-text="Screenshot of adding new screens." lightbox="../media/create-order-screens.png":::

3. Select the **Product_details** screen and then configure the **OnSelect** property of the **Order** button as follows:

    ```PowerApps
    Navigate('Order_products',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-order-button.png" alt-text="Screenshot of Order OnSelect configuration." lightbox="../media/configure-order-button.png":::

4. Follow the same procedure for the **Carpet_details** screen.

5. In the **Order_products** page, insert **Product**, **Price**, **Color**, and **Notes** labels and rename them accordingly.

    :::image type="content" source="../media/insert-order-labels.png" alt-text="Screenshot of labels in Order_sofas." lightbox="../media/insert-order-labels.png":::

6. Insert empty labels next to the **Product**, **Price**, **Color**, and **Notes** as shown in the figure.

    :::image type="content" source="../media/create-empty-labels.png" alt-text="Screenshot of empty labels in Order_sofas." lightbox="../media/create-empty-labels.png":::

7. Configure the **Text** property of these empty labels as follows:

    * **Product**:

        ```PowerApps
        Gallery_products.Selected.Name
        ```

        :::image type="content" source="../media/configure-product-label.png" alt-text="Screenshot of configuring Product text." lightbox="../media/configure-product-label.png":::

    * **Price**:

        ```PowerApps
        Gallery_products.Selected.Price
        ```

        :::image type="content" source="../media/configure-price-label.png" alt-text="Screenshot of configuring Price text." lightbox="../media/configure-price-label.png":::

    * **Color**:

        ```PowerApps
        Gallery_products.Selected.Color
        ```

        :::image type="content" source="../media/configure-color-label.png" alt-text="Screenshot of configuring Color text." lightbox="../media/configure-color-label.png":::

    * **Notes**:

        ```PowerApps
        TextInput_products.Text
        ```

        :::image type="content" source="../media/configure-notes-label.png" alt-text="Screenshot of configuring Notes text." lightbox="../media/configure-notes-label.png":::

8. Add another label at the top and change its display text to **Order Summary**. Change the font size and font according to your needs.

    :::image type="content" source="../media/add-page-heading.png" alt-text="Screenshot of adding Order Summary label." lightbox="../media/add-page-heading.png":::

9. Expand the **Gallery** dropdown and select **Horizontal**. Retain only the image; delete other components of the **Gallery**. Rename it **Order_gallery_products**

    :::image type="content" source="../media/add-horizontal-gallery-order.png" alt-text="Screenshot of adding gallery." lightbox="../media/add-horizontal-gallery-order.png":::

10. Configure the **Items** property of this gallery by adding the following line:

    ```PowerApps
    ViewInMR1.Photos
    ```

    :::image type="content" source="../media/configure-items-property-order.png" alt-text="Screenshot of configuring items in gallery." lightbox="../media/configure-items-property-order.png":::

11. Add three **Labels** and change the display text to **Enter your email to get an order confirmation mail!**, **Organization mail ID:**, and **Customer mail ID:**, respectively.

    :::image type="content" source="../media/add-extra-labels.png" alt-text="Screenshot of three labels." lightbox="../media/add-extra-labels.png":::

12. Expand the **Input** dropdown and select **Text input**. Add two **Text input** components to the screen and position them as shown in the image. Rename them **Input1_products** and **Input2_products**.

    :::image type="content" source="../media/add-email-input.png" alt-text="Screenshot of two text input fields." lightbox="../media/add-email-input.png":::

13. Configure the **Hint text** property by adding **Enter mail ID:**; store no value in the **Default** property. Adjust the font size and color according to your need.

    :::image type="content" source="../media/add-hint-text.png" alt-text="Screenshot of configuring hint text." lightbox="../media/add-hint-text.png":::

14. Add a button from the **Insert** tab and configure its **Text** property by adding **Confirm**.

    :::image type="content" source="../media/add-confirm-button.png" alt-text="Screenshot of adding confirm button." lightbox="../media/add-confirm-button.png":::

15. Expand the **Icons** dropdown and select **Back** and **Home** icon. Position them correctly, as shown in the image.

    :::image type="content" source="../media/add-back-home-icon.png" alt-text="Screenshot of adding back and home icons." lightbox="../media/add-back-home-icon.png":::

16. Configure the **OnSelect** property of these two icons as follows:

    * **Back**:

        ```PowerApps
        Navigate(Product_details,ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-back-icon-order.png" alt-text="Screenshot of back OnSelect config." lightbox="../media/configure-back-icon-order.png":::

    * **Home**:

        ```PowerApps
        Navigate('Home Page',ScreenTransition.CoverRight)
        ```

        :::image type="content" source="../media/configure-home-icon-order.png" alt-text="Screenshot of configuring OnSelect: Order." lightbox="../media/configure-home-icon-order.png":::

17. Follow the same procedure for **Order_carpets**.

## Create end page

1. Create a **Blank** screen and rename it **End page**.

    :::image type="content" source="../media/create-end-page.png" alt-text="Screenshot of the end page." lightbox="../media/create-end-page.png":::

2. Add a **Label** and change its display text to **Order Successfully Submitted!**. Position the label as required on the screen.

    :::image type="content" source="../media/add-message-label.png" alt-text="Screenshot of adding label for Order Successfully Placed." lightbox="../media/add-message-label.png":::

3. Add a **Button** at the bottom of the screen. Configure the **Text** property of the button by adding **Shop more**. Let's direct the user to the home page: select the **Shop more** button, then add the following line in the **OnSelect** property.

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-shop-more-button.png" alt-text="Screenshot of show more button." lightbox="../media/configure-shop-more-button.png":::

4. Expand the **Media** dropdown and select **Image** to add an image component to the **End page**.

    :::image type="content" source="../media/add-image-order.png" alt-text="Screenshot of adding image component." lightbox="../media/add-image-order.png":::

5. Position the image as shown in the image. Select the **logo** file to display.

    :::image type="content" source="../media/add-logo-order.png" alt-text="Screenshot of adding logo file to the image component." lightbox="../media/add-logo-order.png":::

    > [!TIP]
    > Save your application frequently by selecting the **File** tab at the top and selecting the **Save** option. If prompted, select the **The cloud** option and then select **Save**.

## Send emails via Power Apps

1. Select the **Data** tab and select **+ Add data**. Expand the **Connectors**, then select **Office 365 Outlook** to add it as one of the connectors for this application.

    :::image type="content" source="../media/add-office-365-outlook.png" alt-text="Screenshot of adding data connectors for Outlook." lightbox="../media/add-office-365-outlook.png":::

2. Open **Order_products** and then configure the **OnSelect** property of the **Confirm** button by adding the following lines:

    ```PowerApps
    Office365Outlook.SendEmailV2(Input1_products & ";"& Input2_products,"Order Summary","<b> Your order is successfully submitted! </b> <br> Order details are as follows: <ul> <li> Product: " & Order_product_name_details & "</li> <li> Price: " & Order_price_details & "</li> <li> Color: " & Order_color_details & "</li> </ul>Notes: " & TextInput_products & "<br><b> Thank you for shopping with us! </b>");
    Navigate('End page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-confirm-email-button.png" alt-text="Screenshot of configuring confirm button." lightbox="../media/configure-confirm-email-button.png":::

    > [!NOTE]
    > The names used in the preceding function follow the naming conventions used in this application at the time of development. You can customize the function according to your application.

Implementing the preceding steps must make your application work in the following way: your application will include a **Notes page** to store all the session notes, an **Order summary page** to review your order and send mails, and an **End page** to provide an excellent closure to the application.

:::image type="content" source="../media/application-demo-4.gif" alt-text=" Animation of application demo after adding additional pages and email functionality." lightbox="../media/application-demo-4.gif":::

## Test your application on a mobile device

1. Choose the download link for your device:

    * For iOS (iPad or iPhone), go to the [App Store](https://itunes.apple.com/app/powerapps/id1047318566?mt=8).
    * For Android, go to [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.msapps).

2. Open Power Apps on your mobile device and sign in with your Microsoft account credentials.

3. The apps that you used recently will appear on the default screen when you sign in to Power Apps mobile.

    The **Home** is the default screen when you sign in. It displays the apps you used recently and the apps that you've marked as favorites.

4. To run an app on a mobile device, select the app tile. If this is the first time you're running a canvas app by using Power Apps mobile, a screen shows the swipe gestures.

5. To close an app, use your finger to swipe from the left edge of the app to the right. On Android devices, you can also select the **Back** button and confirm that you intended to close the app.

    > [!NOTE]
    > If an app requires a connection to a data source or permission to use the device's capabilities (such as the camera or location services), you must give consent before you can use the app. Typically, you're prompted only the first time you run the app.
