Let's start building *Easy Sales* application based on the SharePoint data, and then add data from other sources if wanted. By following this procedure, you'll be able to design some of the main pages of the application. For example, you'll learn to design a splash screen, product page, notes page, and product details page. We'll also be accessing various data stored in the SharePoint list through Power Apps gallery control.

## Open a blank app

1. Go to the **Power Apps** home page. Then, under **Make your own app**, select **Canvas app from blank** to create a canvas application.

    :::image type="content" source="../media/canvas-app.png" alt-text="Screenshot of select canvas app from blank." lightbox="../media/canvas-app.png":::

2. Specify a name for your app, for example *Easy-Sales*. Select **Phone**, and then click **Create**.

    :::image type="content" source="../media/select-phone.png" alt-text="Screenshot of specifying app name and selecting create." lightbox="../media/select-phone.png":::

    Power Apps Studio creates a blank app for phones.
    >[!Note]
    > You can design an app from scratch for phones or other devices (such as tablets). This topic focuses on designing an app for phones.

3. If the **Welcome to Power Apps Studio** dialog box opens, select **Skip**.

    :::image type="content" source="../media/click-skip.png" alt-text="Screenshot of select skip option." lightbox="../media/click-skip.png":::

## Connect to data

To include data to your **Power Apps**, you must connect to the data via the connectors in your application. Since we have stored all of the data in the **SharePoint** lists, we will select **SharePoint** as one of the connectors.

1. To the **Power Apps Studio**'s left, click the **Data** option.

2. On opening the **Data** pane, click the **Add data** button to connect to the data.

3. In the **Select a data source** window, expand the **Connectors** section and select the **SharePoint** option.

    :::image type="content" source="../media/share-point-connectors.png" alt-text="Screenshot of select add data and sharepoint option." lightbox="../media/share-point-connectors.png":::

4. In the previous exercise, a connection was already created. Select the created connection to add the data to your application. Select the **SharePoint site**, created under the name *Easy Sales*.

    :::image type="content" source="../media/select-easy-sales.png" alt-text="Screenshot of select Easy Sales." lightbox="../media/select-easy-sales.png":::

5. On selecting the **Easy Sales** SharePoint site, all the lists created on that site are displayed. Next, select all the SharePoint lists created concerning the application and click **Connect**.

    :::image type="content" source="../media/select-lists.png" alt-text="Screenshot of selecting lists." lightbox="../media/select-lists.png":::

6. All the required data is connected and ready to use in the application. You can now start building the application.

## Create the splash screen

1. Click the **Tree view** option at the left of **Power Apps Studio**, you should already have a blank screen in the Power Apps Studio. If not, on the **Home** tab, select the down-arrow next to **New screen** to open a list of screen types, and then select **Blank** to create a blank screen.

    :::image type="content" source="../media/new-screen.png" alt-text="Screenshot of creating new screen." lightbox="../media/new-screen.png":::

2. Rename the screen to **Splash screen** by clicking on the **Three dots** present beside the screen name and selecting the **Rename** option.

    :::image type="content" source="../media/rename-splash-screen.png" alt-text="Screenshot of renaming the screen." lightbox="../media/rename-splash-screen.png":::

3. Click the newly created screen to change its properties in the **Properties** tab at the right side of the screen.

4. Click the dropdown present beside the **Background image** property to add an image to the screen. Now, we will add the logo of our application **Easy Sales** to the splash screen.

    :::image type="content" source="../media/add-logo.png" alt-text="Screenshot of adding the easy sales logo." lightbox="../media/add-logo.png":::

5. Set the image position to **Fit** to have the entire image into the specified size. The **Fit** option scales the image proportionally and doesn't crop the image.

    :::image type="content" source="../media/add-easy-sales-logo.png" alt-text="Screenshot of adding Easy Sales logo to the splash screen." lightbox="../media/add-easy-sales-logo.png":::

6. On the **Insert** tab, Expand the **Input** dropdown and select **Timer**. Then, drag the button on the screen and place it where ever required.

    :::image type="content" source="../media/add-timer.png" alt-text="Screenshot of adding the timer." lightbox="../media/add-timer.png":::

7. To edit some of the timer properties, you can either use the **Property** dropdown at the top-left corner or use the **Properties** pane. Set the following properties as given below:

    * **AutoStart** - true
    * **Duration** - 2000
    * **Visible** - false

    :::image type="content" source="../media/update-properties-timer.png" alt-text="Screenshot of updating the properties of timer." lightbox="../media/update-properties-timer.png":::

    >[!Note]
    > By default, the unit taken to measure duration is in milliseconds. Since 1 second = 1000 milliseconds, we enter 2000 as the value for the duration.

8. We want the splash screen to be visible for only 2 seconds and later navigate to the Home page. To do this, create a **Blank** screen as we did in the previous step and rename it as **Home Page**. Later click on the timer button added to the **Splash** screen and configure the **OnTimerEnd** property. Replace *false* with the following content:

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Fade)
    ```

    :::image type="content" source="../media/configure-on-timer-end.png" alt-text="Screenshot of configuring OnTimerEnd property." lightbox="../media/configure-on-timer-end.png":::

9. Save your application by navigating to **File** > **Save**. Next, select the **The cloud** option and click **Save**.

## Create the home page

1. Click the **Home Page** which was created previously. To insert four buttons, navigate to the **Insert tab** and click the **Button** option to add buttons to the screen. Adjust the size and position of these buttons as required. Rename them as **Sofas_button**, **Chairs_button**, **Tables_button**, and **Carpets_button** respectively.

    :::image type="content" source="../media/add-buttons.png" alt-text="Screenshot of adding buttons." lightbox="../media/add-buttons.png":::

2. Change the display text of the buttons to indicate product categories like **Sofas, Chairs, Tables, and Carpets**.

    :::image type="content" source="../media/edit-display-text-1.png" alt-text="Screenshot of editing display text." lightbox="../media/edit-display-text-1.png":::

3. We will use these buttons to navigate to the list of products under various categories. To do so, we need to create separate screens for each category. So, first, create four new **Blank** screens and rename it with your product categories, i.e., **Sofas**, **Chairs**, **Tables**, and **Carpets**.

    :::image type="content" source="../media/edit-display-text-2.png" alt-text="Screenshot of adding new screens." lightbox="../media/edit-display-text-2.png":::

4. Click the newly created **Sofas_button** button and configure the **OnSelect** property. On clicking the button, it must navigate us to the product list page created in the previous step. Replace the *false* by the below-given code:

    ```PowerApps
    Navigate(Sofas,ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/navigate-sofas-page.png" alt-text="Screenshot of navigation of sofas page" lightbox="../media/navigate-sofas-page.png":::

5. Repeat the same procedure for the other three buttons. Again, make sure to provide proper screen names in the **Navigate** function; for example, for configuring the **OnSelect** property of the **Chairs**, **Tables**, and **Carpets** button, use the following navigate function respectively:

    ```PowerApps
    Navigate(Chairs,ScreenTransition.Cover)
    ```

    ```PowerApps
    Navigate(Tables,ScreenTransition.Cover)
    ```

    ```PowerApps
    Navigate(Carpets,ScreenTransition.Cover)
    ```

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option.

>[!Note]
> The default syntax of the **Navigate** function is: **Navigate**(*Screen* [, *Transition* [, *UpdateContextRecord*]])
>
>* **Screen** - Required. The screen to display.
>* **Transition** - Optional. The visual transition to use between the current screen and the next screen. The default value is None.
>* **UpdateContextRecord** - Optional. A record that contains the name of at least one column and a value for each column. This record updates the context variables of the new screen as if passed to the UpdateContext function.

>[!Tip]
>You can test your application by pressing the **F5** key on the keyboard or clicking the **Play** button at the top-right corner of Power Apps Studio.

## Use Gallery control

Now that we have added the product categories, we will display the list of products under each category. In Power Apps, we use **Gallery control** to display a record of data.

1. In the **Sofas** screen; on the Insert tab, select **Gallery** > **Vertical** to add **Gallery control** to your screen.

    :::image type="content" source="../media/select-vertical-gallery.png" alt-text="Screenshot of adding gallery" lightbox="../media/select-vertical-gallery.png":::

2. Rename it to **Gallery_sofas**. On the **Properties** tab of the right-hand pane, configure the **Data source** property. Click the dropdown next to it and select the appropriate **SharePoint List**, for example, *Easy sales - Sofas*.

    :::image type="content" source="../media/configure-data-source.png" alt-text="Screenshot of connecting sharepoint" lightbox="../media/configure-data-source.png":::

3. Configure the **Gallery** > **Fields** property in the **Properties** pane by clicking on **Edit**:
    * Assign the **Price** to the **Subtitle1** heading.
    * Assign the **Name(Title)** to the **Title1** heading.

    :::image type="content" source="../media/configure-gallery-fields.png" alt-text="Screenshot of configuring fields - Sofas" lightbox="../media/configure-gallery-fields.png":::

    On assigning the above fields, you'll observe data getting reflected in your **Gallery**

4. Adjust the size of the **Gallery_sofas** as required. To add the **ImageLink** to the **Image1** heading, click the **Image** in the gallery and configure the **Image** property on the **Property** tab by adding this line of code:

    ```PowerApps
    ThisItem.ImageLink
    ```

    :::image type="content" source="../media/configure-image-property.png" alt-text="Screenshot of configuring image property - Sofas" lightbox="../media/configure-image-property.png":::

5. Let us now insert a label at the top of the screen. To do so, click on the **Label** option. Then, customize the position, color, and text display as shown in the figure:

    :::image type="content" source="../media/insert-label.png" alt-text="Screenshot of adding label - Sofas" lightbox="../media/insert-label.png":::

6. Add a **Back** icon over the previously added **Label** to help the user navigate to the **Home Page** when required. To add the **Back** icon, expand the **Icons** dropdown and select the **Back** icon.

    :::image type="content" source="../media/insert-back-icon.png" alt-text="Screenshot of adding back icon - home page" lightbox="../media/insert-back-icon.png":::

7. Position the **Back** icon correctly and change its display color if required. Configure its **OnSelect** property by adding the following

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-back-icon.png" alt-text="Screenshot of configuring OnSelect property " lightbox="../media/configure-back-icon.png":::

8. Follow the same procedure for the **Chairs**, **Tables**, and **Carpets** pages.

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option.

## Create details page

The details page includes all the details and information concerning the selected product. It gives you an understanding of certain features of the product. You have to connect the product page designed in the previous section and the details page created in this section.

1. Create four new pages and rename them respectively as **Details_sofas**, **Details_chairs**, **Details_tables**, and **Details_carpets**.

    :::image type="content" source="../media/create-detail-page.png" alt-text="Screenshot of creating detailed pages" lightbox="../media/create-detail-page.png":::

2. Click on the **>** icon in the gallery control included in the **Sofas** page and all other similar pages. Then, configure the **OnSelect** property by adding the following line in the **Functions** tab.

    ```PowerApps
    Navigate(Details_sofas,ScreenTransition.Cover,{content_sofas : ThisItem})
    ```

    > [!Note]
    > Customize the **Navigate** function by providing different destination pages and UpdateContextRecord, for example, **Navigate(Details_chairs,ScreenTransition.Cover,{content_chairs : ThisItem})** to navigate to the **Details_chairs** page with **content_chairs** as the **UpdateContextRecord**.

    :::image type="content" source="../media/navigate-next-details.png" alt-text="Screenshot of navigation to next details" lightbox="../media/navigate-next-details.png":::

3. Let's start building the **Details_sofas** page by adding a few labels, namely: **Price**, **Dimensions**, **Weight**, **Color**, and **Material**. You can edit the text inside the label by inserting the desired text beside the **Text** property of the **Label**. Rename the **Labels** accordingly.

    :::image type="content" source="../media/add-labels.png" alt-text="Screenshot of adding labels" lightbox="../media/add-labels.png":::

    >[!Note]
    > You may customize the theme, font, and color palette of your application as required to improve user experience and appearance.

4. Insert another label named **Product name** to display the name of the product at the top and **Center align** it. Configure the **Text** property of the label by adding the following line:

    ```PowerApps
    content_sofas.'Name (Title)'
    ```

    :::image type="content" source="../media/add-title-label.png" alt-text="Screenshot of adding title label" lightbox="../media/add-title-label.png":::

5. Click the **Media** dropdown and select **Image** to insert an image in the **Details_sofas** screen. Configure the **Image** property in the following way:

    ```PowerApps
    content_sofas.ImageLink
    ```

    :::image type="content" source="../media/add-image.png" alt-text="Screenshot of adding image" lightbox="../media/add-image.png":::

6. Add blank labels beside **Price**, **Dimensions**, **Weight**, **Color**, and **Material** labels as shown in the figure to display the product information under those headings. Configure the **Text** property of these labels respectively:

    * **Price** :

        ``` PowerApps
        content_sofas.Price
        ```

        :::image type="content" source="../media/blank-label-price.png" alt-text="Screenshot of blank label for price" lightbox="../media/blank-label-price.png":::

    * **Dimensions** :

        ``` PowerApps
        content_sofas.Dimensions
        ```

        :::image type="content" source="../media/blank-label-dimensions.png" alt-text="Screenshot of blank label for dimension" lightbox="../media/blank-label-dimensions.png":::

    * **Weight** :

        ``` PowerApps
        content_sofas.Weight
        ```

        :::image type="content" source="../media/blank-label-weight.png" alt-text="Screenshot of blank label for weight" lightbox="../media/blank-label-weight.png":::

    * **Color** :

        ``` PowerApps
        content_sofas.Color
        ```

        :::image type="content" source="../media/blank-label-color.png" alt-text="Screenshot of blank label for color" lightbox="../media/blank-label-color.png":::

    * **Material** :

        ``` PowerApps
        content_sofas.PrimaryMaterial
        ```

        :::image type="content" source="../media/blank-label-material.png" alt-text="Screenshot of blank label for material" lightbox="../media/blank-label-material.png":::

7. We will add a **Back** icon to navigate to the previous screen. To add the **Back** icon, expand the **Icons** dropdown and select the **Back icon**. Position the **Back** icon correctly and configure the **OnSelect** property by adding the following:

    ```PowerApps
    Navigate('Sofas',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/add-back-icon.png" alt-text="Screenshot of adding back icon and OnSelect" lightbox="../media/add-back-icon.png":::

    Likewise, follow the same procedure for **Details_chairs**, **Details_tables**, and **Details_carpets**. Customize the **Navigate** function accordingly.

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option.

## Insert and connect a 3D object to the View in MR component

**View in MR** is a mixed reality feature provided by Power Apps which enables users to place **3D objects** or **Images** in their real world. The 3D models and images required for the application are stored in the **SharePoint** lists. So let's start by adding the required resources in the respective **SharePoint** lists.

1. In the created **SharePoint** list named **Easy Sales-Sofas**, select the **+ Add column** and select **Show/hide columns**.

    :::image type="content" source="../media/select-add-column.png" alt-text="Screenshot to add column" lightbox="../media/select-add-column.png":::

2. Make sure **Attachments** be selected and press **Apply** at the top.

    :::image type="content" source="../media/apply-attachments.png" alt-text="Screenshot to apply attachments" lightbox="../media/apply-attachments.png":::

3. Select an item in the list and click **Add Attachments**. Select your **3D model** (.glb file) or **Image** (.jpg file) given in the **Power Apps custom folder**. Follow the same procedure for all the items on the list.

    :::image type="content" source="../media/add-attachments.png" alt-text="Screenshot to add attachments" lightbox="../media/add-attachments.png":::

4. Click the dropdown present beside the **Attachments** column and select **Show attachments first**. We want the attachments to be placed at first for easy access.

    :::image type="content" source="../media/select-show-attachments.png" alt-text="Screenshot to select Show attachments first" lightbox="../media/select-show-attachments.png":::

5. Switch to **Power Apps Studio**, add the **View in MR** component to the **Details_sofas** screen, Open the **Insert** tab, expand the **Mixed Reality**. Then, select the component **View in MR**.
    :::image type="content" source="../media/add-view-in-mr-button.png" alt-text="Screenshot of adding View in MR button" lightbox="../media/add-view-in-mr-button.png":::

6. In the **Properties** tab for the **View in MR** component, select the **Source** field and enter to access the 3D models stored in your **SharePoint** list:

    ```PowerApps
    First(Gallery_sofas.Selected.Attachments).Value
    ```

    :::image type="content" source="../media/add-source.png" alt-text="Screenshot to add source for view in MR" lightbox="../media/add-source.png":::

7. Repeat the same procedure in the **Details_chairs** and **Details_tables** screen. While duplicating the procedure, make sure to change the **Gallery** names accordingly, for example,

    ```PowerApps
    First(Gallery_chairs.Selected.Attachments).Value
    ```

>[!Note]
> We do not include the **View in MR** feature for the **Carpets** category. Instead, we will be estimating the **Price** of the carpet depending upon the area calculated in the **Measure in MR** session.

Another unique property provided by the **View in MR** component is **Object scaling**. You can edit the sizes of your 3D models externally by changing the **Object width**, **Object height**, and **Object depth** properties.

* Set the  following properties in the **Property** pane as shown in figure:

  * **Object width** = 1.5
  * **Object height** = 1
  * **Object depth** =  1
  * **Unit of measurement** = Meters
  
  These values are set according to the 3D models included in this application.

    :::image type="content" source="../media/object-scaling.png" alt-text="Screenshot to scale object for view in MR" lightbox="../media/object-scaling.png":::

>[!Information]
> You can also customise the values passed to **Object width**, **Object height**, and **Object depth** according to your needs. The values passed are taken in the units specified in **Unit of measurement**. Choose an appropriate measure unit from the dropdown and later enter the values.

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option.

## Create notes page

It is allowed to take pictures during the **View in MR** session and display them through a gallery. This is an additional feature included in the application to provide a good user experience. In the **Notes page** you'll be able to store some textual notes and store the images captured during **View in MR** session.

1. Create four new **Blank** screens and rename them as **Notes_sofas**, **Notes_chairs**, **Notes_tables**, and **Notes_carpets**.

    :::image type="content" source="../media/add-blank-notes-page.png" alt-text="Screenshot of new screens for notes" lightbox="../media/add-blank-notes-page.png":::

2. Design the **Notes_sofas** page by, clicking the **Input** dropdown and selecting **Text input**. Rename it as **TextInput_sofas**.

    :::image type="content" source="../media/add-text-input.png" alt-text="Screenshot of adding Text input" lightbox="../media/add-text-input.png":::

3. Select **Gallery** > **Horizontal** to include a horizontal type of gallery. You will be storing photos taken during the **View in MR** session in this gallery. Rename it as **View_sofas**

    :::image type="content" source="../media/horizontal-gallery.png" alt-text="Screenshot of adding horizontal gallery" lightbox="../media/horizontal-gallery.png":::

4. Position the gallery at the other part of the screen. Retain only the image by deleting the **Subtitle** and **Title**. Enlarge the image.

    :::image type="content" source="../media/retain-image.png" alt-text="Screenshot of only image in gallery" lightbox="../media/retain-image.png":::

5. Click the gallery added and configure the **Items** property by adding the following line:

    ```PowerApps
    ViewInMR.Photos
    ```

    :::image type="content" source="../media/configure-items-property.png" alt-text="Screenshot of adding property to gallery" lightbox="../media/configure-items-property.png":::

    By doing so, all the pictures taken in the **View in MR** session is stored in this gallery for future references.

6. Let us now insert a label at the top of the screen. To do so, click on the **Label** option and **Center align** it. Then, customize the position, color, and text display according to your needs. Rename it to **Notes_label**.

    :::image type="content" source="../media/insert-label-notes.png" alt-text="Screenshot of inserting label" lightbox="../media/insert-label-notes.png":::

7. We will add a **Back** icon over the previously added **Label** to help the user navigate the **Home Page** when required. To add the **Back** icon, on the **Insert** tab, expand the **Icons** dropdown and select the **Back icon**.

    :::image type="content" source="../media/add-back-icon-notes.png" alt-text="Screenshot of adding back icon - notes" lightbox="../media/add-back-icon-notes.png":::

8. Position the **Back** icon correctly and configure the **OnSelect** property by adding the following

    ```PowerApps
    Navigate('Details_sofas',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-back-icon-notes.png" alt-text="Screenshot of positioned and OnSelect" lightbox="../media/configure-back-icon-notes.png":::

9. Switch to the **Details_sofas** screen and add a **Note** icon from the **Icons** dropdown on the **Insert** tab.

    :::image type="content" source="../media/add-note-icon.png" alt-text="Screenshot of adding note icon" lightbox="../media/add-note-icon.png":::

10. Configure the **OnSelect** property of the **Note** icon by adding the following line:

    ```PowerApps
    Navigate(Notes_sofas,ScreenTransition.CoverRight)
    ```

    :::image type="content" source="../media/configure_note_icon.png" alt-text="Screenshot of OnSelect for note" lightbox="../media/configure_note_icon.png":::

11. Replicate the same procedure for **Notes_chairs**, **Notes_tables**, **Notes_carpets**, and its respective **Details** page.

>[!Note]
> For the **Notes_carpets** page, exclude adding the **Gallery control** to store photos taken during the **View in MR** session since we won't be including the **View in MR** feature for the **Carpets** category.

>[!Tip]
>You can test your application by pressing the **F5** key on the keyboard or clicking the **Play** button at the top-right corner of Power Apps Studio.
