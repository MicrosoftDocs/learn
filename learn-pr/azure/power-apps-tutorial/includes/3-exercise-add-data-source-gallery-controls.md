In Power Apps, you can connect your data with an already existing application or to an application that you're building from scratch. Your app can connect to SharePoint, Microsoft Dataverse, Salesforce, OneDrive, or any other data source.

We'll be using SharePoint as our primary data source for this application. You can connect to the SharePoint site to automatically generate an app from a custom list, create a connection before adding data to an existing app, or build an app from scratch.

## Create a SharePoint site

1. Sign in to the [SharePoint portal](https://netorg4603737.sharepoint.com/_layouts/15/sharepoint.aspx) with your Microsoft organization credentials.

2. Select **+ Create site** on the SharePoint start page to create the **SharePoint** site.

    :::image type="content" source="../media/create-site.png" alt-text="Screenshot showing to create site on the SharePoint start page." lightbox="../media/create-site.png":::

3. On the SharePoint start page, you'll find the following information:

    * Choose the site type; the choice is *Communication site* or *Team site*. Select **Communication site**.

    * Enter a suitable name for the site; for example, *Easy Sales*.

    * Add the **Site description** if needed (optional).

    * Select the **Language** of your choice from the dropdown.

4. Select **Finish** to create a **SharePoint** site for loading your data.

    :::image type="content" source="../media/update-site-details.png" alt-text="Screenshot of updating site details." lightbox="../media/update-site-details.png":::

A modern SharePoint site is created and ready for use in seconds. You can now create a list, document library, page, and so on in your newly created site.

> [!NOTE]
> If you selected **Team site**, a Microsoft 365 group is also created.

## Create SharePoint list

A SharePoint list collects data with some structure, similar to a table, spreadsheet, or simple database. It can include many different types of information, such as numbers, text, attachments, and even images.

For our **Easy Sales** application, we'll create a list containing details of all the product categories: **Sofas**, **Chairs**, **Tables**, and **Carpets**.

1. In the newly created SharePoint site under the name *Easy Sales*, select the **+ New** dropdown and then select **List** to create your SharePoint list.

    :::image type="content" source="../media/select-list.png" alt-text="Screenshot of selecting list." lightbox="../media/select-list.png":::

2. In the **Create a List** window, select **Blank list** to create a **SharePoint** list from scratch.

      :::image type="content" source="../media/select-blank-list.png" alt-text="Screenshot of selecting Blank List." lightbox="../media/select-blank-list.png":::

3. Configure the **Create** pane as follows:

    * Enter a suitable name for the list; for example, *Easy Sales*.
    * Fill in the description, if required (optional).
    * Leave the **Show in site navigation** checkbox selected.
    * Select **Create**.

        :::image type="content" source="../media/enter-details.png" alt-text="Screenshot of Create Pane." lightbox="../media/enter-details.png":::

## Add data to your SharePoint list

Once the list is created, it's time to add the data. Here, "data" means the details of any particular product. The product details include the following information: Name, Image, Price, Dimensions, Weight, Color, PrimaryMaterial, Area, Height, and 3D model/image of the product to be viewed in mixed reality.

1. In the created *Easy sales* list, select **+ Add column** to add a column of a specific type. The list below shows the columns that need to be created, with their names and types in this format: *Name of the Column - Column type*.

    * **Name**: Single line of text
    * **ImageLink**: Single line of text
    * **Price**: Single line of text
    * **Dimensions**: Single line of text
    * **Weight**: Single line of text
    * **Color**: Single line of text
    * **PrimaryMaterial**: Single line of text
    * **Height**: Number
    * **Depth**: Number
    * **Width**: Number
    * **Price/cm2**: Number
    * **ProductCategory**: Single line of text
    * **FileType**: Single line of text

    Select the column type from the drop-down; for example, select **Single line of text**.

    :::image type="content" source="../media/column-type.png" alt-text="Screenshot of selecting Single line of text." lightbox="../media/column-type.png":::

    Enter the details of the column in the **Create the column** tab and select **Save**.

    :::image type="content" source="../media/column-details.png" alt-text="Screenshot of Creating a Column." lightbox="../media/column-details.png":::

    Repeat the same procedure for rest of the columns in the preceding list.

    > [!NOTE]
    > After you create a **SharePoint** list, a default **Title** column is created that you can rename as **Name**.

2. Once we add the columns, we have to add the actual data under these columns. Start adding data to columns by downloading the custom folder that includes all the product details for all four lists. To access the data, select the following link, select the **More file actions** button (**...**) at the top-right of the page, and select **Download**.

    [Power Apps custom folder](https://github.com/MicrosoftDocs/mslearn-developer-tools-power-platform/blob/master/custom-folder/PowerAppsFiles.zip)

3. Select **+ New** to add an item and then fill in the required details as provided in the downloaded **Excel** file. Select **Save** to save the entered details.

    :::image type="content" source="../media/edit-grid-view.png" alt-text="Screenshot of selecting New or Edit in grid view to add new item." lightbox="../media/edit-grid-view.png":::

    > [!NOTE]
    > Grid view lets you add information freely to different rows or columns.

4. Start adding your data in their respective columns, as shown in the figure:

    :::image type="content" source="../media/add-list-details.png" alt-text="Screenshot of sharepoint list with added details" lightbox="../media/add-list-details.png":::

    > [!NOTE]
    > If you want to include images of your own, you can add the image links of public images available on the Internet under the **ImageLink** column. You can get the image links by right-clicking and selecting the **Copy image address** option.

    > [!NOTE]
    > You won't be needing the height, depth, and width values for the *Carpet* category list. This product category will take up the area value measured during the **Measure in MR** session and give out the price of the carpet following the area calculated. However, we have added the **Price/cm2** column to assist the process of calculation.

## Create connection

Now that all our data required for the application is stored in the SharePoint list, we'll establish a connection in Power Apps. Once the connection is established, you can easily access the SharePoint data through the application.

1. To start creating a connection, sign in to [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) and select **Connections** in the left navigation bar. Then select **+ New connection** near the upper-left corner.

2. Select **SharePoint**. We're selecting **SharePoint** because we've stored the required data in **SharePoint** lists.

    :::image type="content" source="../media/share-point.png" alt-text="Screenshot of selecting Sharepoint." lightbox="../media/share-point.png":::

3. To connect to SharePoint Online, select **Connect directly (cloud-services)**, then select **Create**, and then, if prompted, provide credentials.

    :::image type="content" source="../media/cloud-services.png" alt-text="Screenshot of selecting Create." lightbox="../media/cloud-services.png":::

4. The connection is created, and you can build an app from scratch.

    > [!NOTE]
    > Even if the connection is created, you can still add, edit, and delete data stored in your SharePoint list. All the changes get reflected in the application through the connection.

Let's start building the *Easy Sales* application based on the SharePoint data, and then add data from other sources, if wanted. By following this procedure, you'll be able to design some of the main pages of the application. For example, you'll learn to design a splash screen, product page, and product list page. We'll also be accessing data stored in the SharePoint list through the Power Apps gallery control.

## Open a blank app

1. Go to the **Power Apps** home page, then select **Create** in the left menu. Select **Blank app**, then select **Create** under **Blank canvas app**.

    :::image type="content" source="../media/canvas-app.png" alt-text="Screenshot of selecting canvas app from blank." lightbox="../media/canvas-app.png":::

2. Specify a name for your app; for example, *Easy-Sales*. Select **Phone**, and then select **Create**.

    :::image type="content" source="../media/select-phone.png" alt-text="Screenshot of specifying app name and selecting create." lightbox="../media/select-phone.png":::

    Power Apps Studio creates a blank app for phones.

    > [!Note]
    > While you can design an app from scratch for various devices, this topic focuses on designing an app for phones.

3. If the **Welcome to Power Apps Studio** dialog box opens, select **Skip**.

    :::image type="content" source="../media/click-skip.png" alt-text="Screenshot of selecting skip option." lightbox="../media/click-skip.png":::

## Connect to data

To include data in your Power App, you must connect to the data via the connectors in your application. Because we've stored all of the data in a **SharePoint** list, we'll select **SharePoint** as one of the connectors.

1. To the **Power Apps Studio**'s left, select the **Data** option.

2. After opening the **Data** pane, select the **Add data** button to connect to the data.

3. In the **Select a data source** window, expand the **Connectors** section and select the **SharePoint** option.

    :::image type="content" source="../media/share-point-connectors.png" alt-text="Screenshot of selecting add data and sharepoint option." lightbox="../media/share-point-connectors.png":::

4. In the previous exercise, we already created a connection. Select the created connection to add the data to your application. Select the **SharePoint site** that was created under the name *Easy Sales*.

    :::image type="content" source="../media/select-easy-sales.png" alt-text="Screenshot of selecting Easy Sales." lightbox="../media/select-easy-sales.png":::

5. After selecting the **Easy Sales** SharePoint site, all the lists created on that site are displayed. Next, select the SharePoint list created concerning the application and click **Connect**.

    :::image type="content" source="../media/select-lists.png" alt-text="Screenshot of selecting the list." lightbox="../media/select-lists.png":::

6. All the required data is connected and ready to use in the application. You can now start building the application.

## Create the splash screen

1. Select the **Tree view** option at the left of **Power Apps Studio**. You should already have a blank screen in the Power Apps Studio; if not, on the **Home** tab, select the down-arrow next to **New screen** that opens the screen type list. Then, select **Blank** to create a blank screen.

    :::image type="content" source="../media/new-screen.png" alt-text="Screenshot of creating new screen." lightbox="../media/new-screen.png":::

2. Rename the screen to **Splash screen** by selecting the three dots icon (**...**) present beside the screen name and selecting the **Rename** option.

    :::image type="content" source="../media/rename-splash-screen.png" alt-text="Screenshot of renaming the screen." lightbox="../media/rename-splash-screen.png":::

3. Select the newly created screen to change its properties in the **Properties** tab at the right side of the screen.

4. Select the drop-down beside the **Background image** property to add an image to the screen. Select **+ Add an image file** to select the downloaded logo file.

    :::image type="content" source="../media/add-logo.png" alt-text="Screenshot of adding the easy sales logo." lightbox="../media/add-logo.png":::

5. Set the image position to **Fit** to have the entire image fit into the specified size. The **Fit** option scales the image proportionally and doesn't crop the image.

    :::image type="content" source="../media/add-easy-sales-logo.png" alt-text="Screenshot of adding Easy Sales logo to the splash screen." lightbox="../media/add-easy-sales-logo.png":::

6. On the **Insert** tab, expand the **Input** dropdown and select **Timer**. Then, drag the button on the screen and place it wherever you want.

    :::image type="content" source="../media/add-timer.png" alt-text="Screenshot of adding the timer." lightbox="../media/add-timer.png":::

7. To edit some of the timer properties, you can either use the **Property** dropdown at the top-left corner or use the **Properties** pane. Set the following properties:

    * **AutoStart**: true
    * **Duration**: 2000
    * **Visible**: false

        :::image type="content" source="../media/update-properties-timer.png" alt-text="Screenshot of updating the properties of timer." lightbox="../media/update-properties-timer.png":::

        > [!NOTE]
        > By default, duration is measured in milliseconds. Since 1 second = 1000 milliseconds, we enter 2000 as the value for the duration.

8. We want the splash screen to be visible for only two seconds and then transition to the Home page. Create a **Blank** screen as we did in the previous step and rename it as **Home Page**. Later, select the timer button added to the **Splash** screen and configure the **OnTimerEnd** property. Replace *false* with the following content:

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Fade)
    ```

    :::image type="content" source="../media/configure-on-timer-end.png" alt-text="Screenshot of configuring OnTimerEnd property." lightbox="../media/configure-on-timer-end.png":::

9. Save your application by navigating to **File** > **Save**. Next, select the **The cloud** option and select **Save**.

## Create the home page

1. Select the **Home Page** created previously. To insert four buttons, navigate to the **Insert tab** and select the **Button** option to add buttons to the screen. Adjust the size and position of these buttons as required. Rename them as **Sofas_button**, **Chairs_button**, **Tables_button**, and **Carpets_button**, respectively.

    :::image type="content" source="../media/add-buttons.png" alt-text="Screenshot of adding buttons." lightbox="../media/add-buttons.png":::

2. Change the display text of the buttons to indicate product categories such as **Sofas, Chairs, Tables, and Carpets**.

    :::image type="content" source="../media/edit-display-text-1.png" alt-text="Screenshot of editing display text." lightbox="../media/edit-display-text-1.png":::

3. We'll use these buttons to navigate to the list of products under various categories. To do so, we need to filter out the products from the SharePoint list based on **Product Category**. Create two new **Blank** screens and rename them **Products** and **Carpets**.

    :::image type="content" source="../media/edit-display-text-2.png" alt-text="Screenshot of adding new screens." lightbox="../media/edit-display-text-2.png":::

4. Select the newly created **Sofas_button** button and configure the **OnSelect** property. After selecting the button, it needs to take us to the product list page created in the previous step. Replace the *false* with the following code:

    ```PowerApps
    Navigate(Products,ScreenTransition.Cover, {ID:1});
    ```

    :::image type="content" source="../media/navigate-sofas-page.png" alt-text="Screenshot of navigation of sofas page" lightbox="../media/navigate-sofas-page.png":::

    > [!NOTE]
    > The **ID** is a context variable with some assigned value. This value is passed on to the destination page mentioned in the **Navigate** function. The value assigned to the variable filters out the products based on **Product Category**.

5. Repeat the same procedure for the other three buttons. Again, make sure you provide proper screen names in the **Navigate** function; for example, to configure the **OnSelect** property of the **Chairs**, **Tables**, and **Carpets** buttons, use the Navigate function as follows:

    ```PowerApps
    Navigate(Products,ScreenTransition.Cover, {ID:2});
    ```

    ```PowerApps
    Navigate(Products,ScreenTransition.Cover, {ID:3});
    ```

    ```PowerApps
    Navigate(Carpets,ScreenTransition.Cover)
    ```

    > [!TIP]
    > To save your progress, select the **File** tab at the top and select the **Save** option. You can also use **Ctrl+S** to save your progress.

    > [!NOTE]
    > The default syntax of the **Navigate** function is: **Navigate**(*Screen* [, *Transition* [, *UpdateContextRecord*]])
    >
    >* **Screen**: Required. The screen to display.
    >* **Transition**: Optional. The visual transition to use between the current screen and the next screen. The default value is None.
    >* **UpdateContextRecord**: Optional. A record that contains the name of at least one column and a value for each column. This record updates the context variables of the new screen as if passed to the UpdateContext function.

    > [!TIP]
    > You can test your application by pressing the **F5** key on the keyboard or clicking the **Play** button at the top-right corner of Power Apps Studio.

## Use Gallery control

Now that we've added the product categories, we'll display the list of products under each category. In Power Apps, we use **Gallery control** to see a record of data.

1. In the **Products** screen, on the **Insert** tab, select **Gallery** > **Vertical** to add **Gallery control** to your screen.

    :::image type="content" source="../media/select-vertical-gallery.png" alt-text="Screenshot of adding gallery" lightbox="../media/select-vertical-gallery.png":::

2. Rename it to **Gallery_products**. On the **Properties** tab of the left-hand pane, configure the **Items** property as follows:

    ```PowerApps
    If(
   ID = 1,
   Filter('Easy Sales',(ProductCategory = "Sofa")),
   ID = 2,
   Filter('Easy Sales',(ProductCategory = "Chair")),
   ID = 3,
   Filter('Easy Sales',(ProductCategory = "Table")),
   ID = 4,
   Filter('Easy Sales',(ProductCategory = "Carpet")))
   ```

    :::image type="content" source="../media/configure-data-source.png" alt-text="Screenshot of connecting sharepoint" lightbox="../media/configure-data-source.png":::

    We filter the **Products** stored in the **SharePoint** list based on the **Product Category**. The context variables are used for the filtering process.

3. Configure the **Gallery** > **Fields** property in the **Properties** pane by selecting **Edit**:
    * Assign the **Price** to the **Subtitle1** heading.
    * Assign the **Title** to the **Title1** heading.

        :::image type="content" source="../media/configure-gallery-fields.png" alt-text="Screenshot of configuring fields in products page" lightbox="../media/configure-gallery-fields.png":::

    On assigning the preceding fields, you'll observe data getting reflected in your **Gallery**.

4. Adjust the size of the **Gallery_products** as required. To add the **ImageLink** to the **Image1** heading, select the **Image** in the gallery and configure the **Image** property on the **Property** tab by adding this line of code:

    ```PowerApps
    ThisItem.ImageLink
    ```

    :::image type="content" source="../media/configure-image-property.png" alt-text="Screenshot of configuring image property in product page" lightbox="../media/configure-image-property.png":::

5. Now, let's insert a label at the top of the screen by selecting the **Label** option. Then, customize the position, color, and text display as shown in the figure:

    :::image type="content" source="../media/insert-label.png" alt-text="Screenshot of adding label in products page" lightbox="../media/insert-label.png":::

6. Add a **Back** icon over the previously added **Label** to help the user navigate to the **Home Page** when required. To add the **Back** icon, expand the **Icons** dropdown and select the **Back** icon.

    :::image type="content" source="../media/insert-back-icon.png" alt-text="Screenshot of adding back icon in home page" lightbox="../media/insert-back-icon.png":::

7. Position the **Back** icon correctly and change its display color, if required. Configure its **OnSelect** property by adding the following:

    ```PowerApps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/configure-back-icon.png" alt-text="Screenshot of configuring OnSelect property " lightbox="../media/configure-back-icon.png":::

8. Follow the same procedure for the **Carpets** page. Configure the **Items** property of the gallery added to the **Carpets** page in the following way:

    ```PowerApps
    Filter('Easy Sales',ProductCategory = "Carpet")
    ```

    :::image type="content" source="../media/replicate-procedure.png" alt-text="Screenshot of following the same procedure for carpets page " lightbox="../media/replicate-procedure.png":::

    > [!TIP]
    > To save your progress, select the **File** tab at the top and select the **Save** option. You can also use **Ctrl+S** to save your progress.

After implementing the preceding steps, here's how your application must look. The application will include an excellent **Splash screen**, a **Home page**, and a product inventory to browse products.

:::image type="content" source="../media/application-demo-1.gif" alt-text="application demo after connecting to a data source." lightbox="../media/application-demo-1.gif":::
