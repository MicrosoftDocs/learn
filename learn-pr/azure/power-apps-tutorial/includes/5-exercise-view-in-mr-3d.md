*Easy-Sales* is a sales oriented Mixed Reality application built to improvise the shopping experience. The salespeople using this application can inspect and measure the customer's surrounding to check which products are feasible in the space. They can also help customers visualize the product through Mixed Reality.

Here we'll be implementing **View in 3D** and **View in MR** features of Power Apps to visualize products accurately.

## Insert 3D objects to the SharePoint list

The 3D models and images required for the application are stored in the **SharePoint** list. So let's start by adding the required resources in the **SharePoint** list.

1. In the created **SharePoint** list named **Easy Sales**, select the **+ Add column** and select **Show/hide columns**.

    :::image type="content" source="../media/select-add-column.png" alt-text="Screenshot to add column" lightbox="../media/select-add-column.png":::

2. Make sure **Attachments** be selected and press **Apply** at the top.

    :::image type="content" source="../media/apply-attachments.png" alt-text="Screenshot to apply attachments" lightbox="../media/apply-attachments.png":::

3. Select an item in the list and click **Add Attachments**. Select your **3D model** (.glb file) or **Image** (.jpg file) given in the **Power Apps custom folder**. Follow the same procedure for all the items on the list.

    :::image type="content" source="../media/add-attachments.png" alt-text="Screenshot to add attachments" lightbox="../media/add-attachments.png":::

4. Click the dropdown present beside the **Attachments** column and select **Show attachments first**. We want the attachments to be placed at first for easy access.

    :::image type="content" source="../media/select-show-attachments.png" alt-text="Screenshot to select Show attachments first" lightbox="../media/select-show-attachments.png":::

## Create details page and add View in 3D component

The details page includes all the details and information concerning the selected product. It gives you an understanding of certain features of the product. You have to connect the product page designed in the previous section and the details page created in this section. Here, you'll also be using the **View in 3D** component of Power Apps to add 3D content to your canvas app. You'll be able to rotate and zoom in on these 3D contents for a better view.

1. Create two new pages and rename them respectively as **Product_details** and **Carpet_details**.

    :::image type="content" source="../media/create-detail-page.png" alt-text="Screenshot of creating detailed pages" lightbox="../media/create-detail-page.png":::

2. Click on the **>** icon in the gallery control included in the **Products** page and **Carpets** page. Then, configure the **OnSelect** property by adding the following line in the **Functions** tab respectively.

    ```PowerApps
    Navigate(Product_details,ScreenTransition.Cover,{content : ThisItem})
    ```

    ```PowerApps
    Navigate(Carpet_details,ScreenTransition.Cover,{content_carpets : ThisItem})
    ```

    :::image type="content" source="../media/navigate-next-details.png" alt-text="Screenshot of navigation to next details" lightbox="../media/navigate-next-details.png":::

3. Let's start building the **Product_details** page by adding a few labels, namely: **Price**, **Dimensions**, **Weight**, **Color**, and **Material**. You can edit the text inside the label by inserting the desired text beside the **Text** property of the **Label**. Rename the **Labels** accordingly.

    :::image type="content" source="../media/add-labels.png" alt-text="Screenshot of adding labels" lightbox="../media/add-labels.png":::

    >[!Note]
    > You may customize the theme, font, and color palette of your application as required to improve user experience and appearance.

4. Insert another label named **Product name** to display the name of the product at the top and **Center align** it. Configure the **Text** property of the label by adding the following line:

    ```PowerApps
    content.'{Name}'
    ```

    :::image type="content" source="../media/add-title-label.png" alt-text="Screenshot of adding title label" lightbox="../media/add-title-label.png":::

5. Click the **Media** dropdown and select **Image** to insert an image in the **Product_details** screen. Configure the **Image** property in the following way:

    ```PowerApps
    content.ImageLink
    ```

    :::image type="content" source="../media/add-image.png" alt-text="Screenshot of adding image" lightbox="../media/add-image.png":::

6. We will overlap the **View in 3D** component over the **Image** component. The products that do not have 3D models attached to them can be viewed through the **Image** component. To add the **View in 3D** component, click **Media** dropdown and select **View in 3D**.

    :::image type="content" source="../media/add-view-3d.png" alt-text="Screenshot of adding view in 3D" lightbox="../media/add-view-3d.png":::

    >[!Note]
    >A default shape is included in the component. You can change this shape to another by altering the **Source** property.

7. Position the component over the image component, as shown in the figure and configure the **Source** property of **View in 3D** component in the following way to connect 3D models from the SharePoint list

    ```PowerApps
    First(Gallery_products.Selected.Attachments).Value
    ```

    :::image type="content" source="../media/configure-view-3d.png" alt-text="Screenshot of configuring view in 3D" lightbox="../media/configure-view-3d.png":::

8. We will alter the **Visible** property of both **Image** and **View in 3D** component to easily view the products depending on the **File type** stored in the **Attachments** column. Configure the **Visible** property of **Image** and **View in 3D** component in the respective way:

    * **Image** :

        ```PowerApps
        If(Gallery_products.Selected.FileType = "Image", true, false)
        ```

        :::image type="content" source="../media/set-image-visible.png" alt-text="Screenshot of altering image visibility" lightbox="../media/set-image-visible.png":::

    * **View in 3D** :

        ```PowerApps
        If(Gallery_products.Selected.FileType = "Model", true, false)
        ```

        :::image type="content" source="../media/set-view-3d-visible.png" alt-text="Screenshot of altering view in 3D visibility" lightbox="../media/set-view-3d-visible.png":::

9. Add blank labels beside **Price**, **Dimensions**, **Weight**, **Color**, and **Material** labels as shown in the figure to display the product information under those headings. Configure the **Text** property of these labels respectively:

    * **Price** :

        ``` PowerApps
        content.Price
        ```

        :::image type="content" source="../media/blank-label-price.png" alt-text="Screenshot of blank label for price" lightbox="../media/blank-label-price.png":::

    * **Dimensions** :

        ``` PowerApps
        content.Dimensions
        ```

        :::image type="content" source="../media/blank-label-dimensions.png" alt-text="Screenshot of blank label for dimension" lightbox="../media/blank-label-dimensions.png":::

    * **Weight** :

        ``` PowerApps
        content.Weight
        ```

        :::image type="content" source="../media/blank-label-weight.png" alt-text="Screenshot of blank label for weight" lightbox="../media/blank-label-weight.png":::

    * **Color** :

        ``` PowerApps
        content.Color
        ```

        :::image type="content" source="../media/blank-label-color.png" alt-text="Screenshot of blank label for color" lightbox="../media/blank-label-color.png":::

    * **Material** :

        ``` PowerApps
        content.PrimaryMaterial
        ```

        :::image type="content" source="../media/blank-label-material.png" alt-text="Screenshot of blank label for material" lightbox="../media/blank-label-material.png":::

10. We will add a **Back** icon to navigate to the previous screen. To add the **Back** icon, expand the **Icons** dropdown and select the **Back icon**. Position the **Back** icon correctly and configure the **OnSelect** property by adding the following:

    ```PowerApps
    Navigate('Products',ScreenTransition.Cover)
    ```

    :::image type="content" source="../media/add-back-icon.png" alt-text="Screenshot of adding back icon and OnSelect" lightbox="../media/add-back-icon.png":::

    Likewise, follow the same procedure for **Carpet_details**. Customize the **Navigate** function accordingly.

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option. You can also use **Ctrl+S** to save your progress.

>[!Note]
> Avoid including **View in 3D** component to **Carpet_details** page as we do not use 3D models for the **Carpet** category.

## View in MR component

**View in MR** is a mixed reality feature provided by Power Apps which enables users to place **3D objects** or **Images** in their real world. The 3D models and images required for the application are stored in the **SharePoint** list. So let's start by adding the required resources in the **SharePoint** list.

1. In the created **SharePoint** list named **Easy Sales**, select the **+ Add column** and select **Show/hide columns**.

    :::image type="content" source="../media/select-add-column.png" alt-text="Screenshot to add column" lightbox="../media/select-add-column.png":::

2. Make sure **Attachments** be selected and press **Apply** at the top.

    :::image type="content" source="../media/apply-attachments.png" alt-text="Screenshot to apply attachments" lightbox="../media/apply-attachments.png":::

3. Select an item in the list and click **Add Attachments**. Select your **3D model** (.glb file) or **Image** (.jpg file) given in the **Power Apps custom folder**. Follow the same procedure for all the items on the list.

    :::image type="content" source="../media/add-attachments.png" alt-text="Screenshot to add attachments" lightbox="../media/add-attachments.png":::

4. Click the dropdown present beside the **Attachments** column and select **Show attachments first**. We want the attachments to be placed at first for easy access.

    :::image type="content" source="../media/select-show-attachments.png" alt-text="Screenshot to select Show attachments first" lightbox="../media/select-show-attachments.png":::

5. Switch to **Power Apps Studio**, add the **View in MR** component to the **Product_details** screen, Open the **Insert** tab, expand the **Mixed Reality**. Then, select the component **View in MR**.

    :::image type="content" source="../media/add-view-in-mr-button.png" alt-text="Screenshot of adding View in MR button" lightbox="../media/add-view-in-mr-button.png":::

6. In the **Properties** tab for the **View in MR** component, select the **Source** field and enter to access the 3D models stored in your **SharePoint** list:

    ```PowerApps
    First(Gallery_products.Selected.Attachments).Value
    ```

    :::image type="content" source="../media/add-source.png" alt-text="Screenshot to add source for view in MR" lightbox="../media/add-source.png":::

>[!Note]
> We do not include the **View in MR** feature for the **Carpets** category. Instead, we will be estimating the **Price** of the carpet depending upon the area calculated in the **Measure in MR** session.

Another unique property provided by the **View in MR** component is **Object scaling**. You can edit the sizes of your 3D models externally by changing the **Object width**, **Object height**, and **Object depth** properties.

* Set the following properties in the **Property** pane as shown in figure:

  * **Object width** = 1.5
  * **Object height** = 1
  * **Object depth** =  1
  * **Unit of measurement** = Meters
  
  These values are set according to the 3D models included in this application.

    :::image type="content" source="../media/object-scaling.png" alt-text="Screenshot to scale object for view in MR" lightbox="../media/object-scaling.png":::

>[!Information]
> You can also customise the values passed to **Object width**, **Object height**, and **Object depth** according to your needs. The values passed are taken in the units specified in **Unit of measurement**. Choose an appropriate measuring unit from the dropdown and later enter the values.

>[!Tip]
> To save your progress, click the **File** tab at the top and select the **Save** option. You can also use **Ctrl+S** to save your progress.

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
