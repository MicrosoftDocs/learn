*Easy-Sales* is a sales oriented Mixed Reality application built to improvise the shopping experience. The salespeople using this application can inspect and measure the customer's surrounding to check which products are feasible in the space. They can also help customers visualize the product through Mixed Reality

In Power Apps, you can connect your data with an already existing application or to an application that you're building from scratch. Your app can connect to SharePoint, Microsoft Dataverse, Salesforce, OneDrive, or any other data source.

We will be using SharePoint as our primary data source for this application. You can connect to a SharePoint site to automatically generate an app from a custom list, create a connection before you add data to an existing app, or build an app from scratch.

## Create a SharePoint site

1. Sign in to the [SharePoint portal](https://netorg4603737.sharepoint.com/_layouts/15/sharepoint.aspx) with your Microsoft organization credentials.

2. Select **+ Create site** on the SharePoint start page to create a **SharePoint** site.

    :::image type="content" source="../media/create-site.png" alt-text="Screenshot showing to create site on the sharePoint start page." lightbox="../media/create-site.png":::

3. On the SharePoint start page, you'll be asked for the following information:

    * It'll ask you to choose a site type, either "communication site" or "Team site." Select **Communication site**.

    * Enter a suitable name for the site, for example, *Easy Sales*

    * Add the **Site description** if needed (Optional).

    * Select **Language** of your choice from the dropdown.

4. Click **Finish** to create a **SharePoint** site in which you can load your data.

    :::image type="content" source="../media/update-site-details.png" alt-text="Screenshot of updating site details." lightbox="../media/update-site-details.png":::

A modern SharePoint site is created and ready for use in seconds. You can now create a list, document library, page, and so on in your newly created site.

>[!Note]
> If you selected a team site, a Microsoft 365 group is also created.

## Create a SharePoint list

A SharePoint list is a collection of data with some structure: it is similar to a table, a spreadsheet, or a simple database. It can include many different types of information like numbers, text, attachments, and even images.

For our **Easy Sales** application, we will create separate lists for each product category: **Sofas**, **Chairs**, **Tables**, and **Carpets**.

1. In the newly created SharePoint site under the name *Easy Sales*, click **+ New** dropdown and select **List** to create a SharePoint list.

    :::image type="content" source="../media/select-list.png" alt-text="Screenshot of select list." lightbox="../media/select-list.png":::

2. In the **Create a List** window, select **Blank list** to create a **SharePoint** list from scratch.

      :::image type="content" source="../media/select-blank-list.png" alt-text="Screenshot of select Blank List." lightbox="../media/select-blank-list.png":::

3. In the **Create** pane configure as following:

    * Enter a suitable name for the list, for example, *Easy Sales-Sofas*
    * Fill in the description, if required. (Optional)
    * Leave the **Show in site navigation** checkbox selected.
    * Click **Create**.

     :::image type="content" source="../media/enter-details.png" alt-text="Screenshot of Create Pane." lightbox="../media/enter-details.png":::

4. Repeat the same procedure to create SharePoint lists for all the product categories. Again, provide a suitable name for each, for example, *Easy sales - Chairs*, *Easy Sales - Tables*, and *Easy Sales - Carpets*.

## Add data to your SharePoint list

Once the list is created, it's time to add the data to it. Here data means the details of a particular product. The product details include the following information: Name, Image, Price, Dimensions, Weight, Color, PrimaryMaterial, Area, Height, and a 3D model/image of the product to be viewed in Mixed Reality.

1. In the created *Easy sales - Sofas* list, select **+ Add column**, to add a column of specific type. The below list shows the columns that need to be created with their name and type in this format *Name of the Column - Column type*.

    * **Name** - Single line of text.
    * **ImageLink** - Single line of text.
    * **Price** - Single line of text.
    * **Dimensions** - Single line of text.
    * **Weight** - Single line of text.
    * **Color** - Single line of text.
    * **PrimaryMaterial** - Single line of text.
    * **Area** - Number
    * **Height** - Number

    Select the column type from the dropdown, for example, select **Single line of text**.

    :::image type="content" source="../media/column-type.png" alt-text="Screenshot of select Single line of text." lightbox="../media/column-type.png":::

    Enter the details of the column in the **Create the column** tab and click on **Save**.

    :::image type="content" source="../media/column-details.png" alt-text="Screenshot of Create a Column." lightbox="../media/column-details.png":::

    Repeat the same procedure for rest of the columns in the above list.

    >[!Note]
    > On creating a **SharePoint** list, a default **Title** column gets created, which can be renamed as **Name** for your use.

2. Once the columns are added, we have to add the actual data under these columns. Start adding data to the respective column by downloading the custom folder that includes all the product details for all four lists.

    [Power Apps custom folder](https://netorg4603737-my.sharepoint.com/:f:/g/personal/developer_onginnovations_com/EtbMYeDiiv1LvCtb3wBKTKUBzKrLW-IazsDrZShq-Js_OA?e=yHPxf3)

3. To add an item to your list, click on **+ New** and fill in the required details as provided in the downloaded **Excel** file. Click **Save** to save the entered details.

    :::image type="content" source="../media/edit-grid-view.png" alt-text="Screenshot of selecting New or Edit in grid view to add new item." lightbox="../media/edit-grid-view.png":::

    >[!Note]
    > Grid view lets you add information freely to different rows or columns.

4. Start adding your data in their respective columns, as shown in the figure.

    :::image type="content" source="../media/add-list-details.png" alt-text="Screenshot of sharepoint list with added details" lightbox="../media/add-list-details.png":::

    >[!Note]
    >If you wish to include images of your own, you can add the image links of public images available on the internet under the **ImageLink** column. You can get the image links by right-clicking and selecting the **Copy image address** option.

5. Follow the same procedure for the *Easy sales - Chairs* and *Easy Sales - Tables* list to add the product details accordingly.

6. For the *Easy sales - Carpets* list, add the columns mentioned below and their types in the format: *Name of the column - Column type*. Later, start adding your data in their respective columns, as shown in the figure.

    * **Name** - Single line of text.
    * **ImageLink** - Single line of text.
    * **Price** - Single line of text.
    * **Dimensions** - Single line of text.
    * **Weight** - Single line of text.
    * **Color** - Single line of text.
    * **PrimaryMaterial** - Single line of text.
    * **Price/cm2** - Number

    :::image type="content" source="../media/carpets-list.png" alt-text="Screenshot of adding the column and their types in the format." lightbox="../media/carpets-list.png":::

    >[!Note]
    > You won't be needing the area and height columns for the *Easy sales - Carpets* list. This product category will take up the area value measured during the **Measure in MR** session and give out the price of the carpet following the area calculated.

## Create a connection

Now that all our data required for the application is stored in the SharePoint list, we will move on to establish a connection in Power Apps. Once the connection is established, you can easily access the SharePoint data through an application.

1. To start creating a connection, sign in to [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) and select **Dataverse > Connections** in the left navigation bar. Then select **+ New connection** near the upper-left corner.

2. Select **SharePoint**. We are selecting **SharePoint**, as we have stored the required data in **SharePoint** lists.

    :::image type="content" source="../media/share-point.png" alt-text="Screenshot of select Sharepoint." lightbox="../media/share-point.png":::

3. To connect to SharePoint Online, select **Connect directly (cloud services)**, select **Create** and then provide credentials (if prompted).

    :::image type="content" source="../media/cloud-services.png" alt-text="Screenshot of select Create." lightbox="../media/cloud-services.png":::

4. The connection is created, and you can build an app from scratch.

>[!Note]
> Even if the connection is created, you can still add, edit and delete data stored in your SharePoint list. All the changes will be reflected in the application through the connection.
