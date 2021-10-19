11In Power Apps, you can connect your data with an already existing application or to an application that you're building from scratch. Your app can connect to SharePoint, Microsoft Dataverse, Salesforce, OneDrive, or any other data source.

We will be using SharePoint as our primary data source for this application. You can connect to a SharePoint site to automatically generate an app from a custom list, create a connection before you add data to an existing app, or build an app from scratch.

## Create a SharePoint site

1. Sign in to the [SharePoint portal](https://netorg4603737.sharepoint.com/_layouts/15/sharepoint.aspx) with your Microsoft organization credentials.

2. Select **+ Create site** on the SharePoint start page.

    :::image type="content" source="../media/1.png" alt-text="Screenshot showing to create site on the sharePoint start page." lightbox="../media/1.png":::

3. In the wizard:

    * Select whether you'd like to create a **Communication site**.

    * Enter a suitable name for the site, for example, *Easy Sales*

    * You can select **Edit** and then edit the group email address or site address if you want.

4. Select **Finish**.

    :::image type="content" source="../media/2.png" alt-text="Screenshot of updating site details." lightbox="../media/2.png":::

A modern SharePoint site is created and ready for use in seconds. You can now create a list, document library, page, and so on in your newly created site.

>[!Note]
> If you selected a team site, a Microsoft 365 group is also created.

## Create a SharePoint list

A SharePoint list is a collection of data with some structure: it is similar to a table, a spreadsheet, or a simple database. It can include many different types of information like numbers, text, attachments, and even images.

For our **Easy Sales** application, we will create separate lists for each product category: **Sofas**, **Chairs**, **Tables**, and **Carpets**.

1. Open the newly created SharePoint site under the name *Easy Sales*.

    :::image type="content" source="../media/3.png" alt-text="Screenshot of newly created Easy Sales site." lightbox="../media/3.png":::

2. Click **+ New** dropdown.

    :::image type="content" source="../media/4.png" alt-text="Screenshot desicribing to click on the New dropdown." lightbox="../media/4.png":::

3. Select **List** to create a SharePoint list.

    :::image type="content" source="../media/5.png" alt-text="Screenshot of select list." lightbox="../media/5.png":::

4. In the **Create a List** window, Select **Blank list**.

      :::image type="content" source="../media/6.png" alt-text="Screenshot of select Blank List." lightbox="../media/6.png":::

5. In the **Create** pane:

    * Enter a suitable name for the list, for example, *Easy Sales-Sofas*
    * Leave the **Show in site navigation** checkbox selected.
    * Click **Create**.

     :::image type="content" source="../media/7.png" alt-text="Screenshot of Create Pane." lightbox="../media/7.png":::

6. Repeat the same procedure to create SharePoint lists for all the product categories. Again, provide a suitable name for each, for example, *Easy sales - Chairs*, *Easy Sales - Tables*, and *Easy Sales - Carpets*.

## Add data to your SharePoint list

Once the list is created, it's time to add the data to it. Here data means the product details of a particular product. The product details include the following information: Name, Image, Price, Dimensions, Weight, Color, PrimaryMaterial, Area, Height, and a 3D model/image of the product to be viewed in Mixed Reality.

1. When your *Easy sales - Sofas* list opens, select **+ Add column**, and create the following columns with the specified column type. The below list shows the columns that need to be created with their name and type in this format *Name of the Column - Column type*.

    * **Name** - Single line of text.
    * **ImageLink** - Single line of text.
    * **Price** - Single line of text.
    * **Dimensions** - Single line of text.
    * **Weight** - Single line of text.
    * **Color** - Single line of text.
    * **PrimaryMaterial** - Single line of text.
    * **Area** - Number
    * **Height** - Number

    :::image type="content" source="../media/8.png" alt-text="Screenshot of select Add Column." lightbox="../media/8.png":::

    :::image type="content" source="../media/9.png" alt-text="Screenshot of select Single line of text." lightbox="../media/9.png":::

    :::image type="content" source="../media/10.png" alt-text="Screenshot of Create a Column." lightbox="../media/10.png":::

2. Once the columns are added, let's start adding the actual data under these columns. First, add an item to your list by either selecting **+ New** or **Edit in grid view**.

    :::image type="content" source="../media/11.png" alt-text="Screenshot of selecting New or Edit in grid view to add new item." lightbox="../media/11.png":::

    >[!Note]
    > Grid view lets you add information freely to different rows or columns.

3. Start adding your data in their respective columns, as shown in the figure.

    >[!Note]
    > Under the **ImageLink** column, add the image links of public images available on the internet. You can get the image links by right-clicking and selecting the **Copy image address** option.

4. Follow the same procedure for the other three lists and add the product details accordingly.

5. For the *Easy sales - Carpets* list, add the columns mentioned below and their types in the format: *Name of the column - Column type*. Later, start adding your data in their respective columns, as shown in the figure.

    * **Name** - Single line of text.
    * **ImageLink** - Single line of text.
    * **Price** - Single line of text.
    * **Dimensions** - Single line of text.
    * **Weight** - Single line of text.
    * **Color** - Single line of text.
    * **PrimaryMaterial** - Single line of text.
    * **Price/cm2** - Number

    :::image type="content" source="../media/12.png" alt-text="Screenshot of adding the column and their types in the format." lightbox="../media/12.png":::

    >[!Note]
    > You won't be needing the area and height columns for the *Easy sales - Carpets* list. This product category will take up the area value measured during the **Measure in MR** session and give out the price of the carpet following the area calculated.

## Create a connection

1. Sign in to [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), select **Dataverse > Connections** in the left navigation bar, and then select **+ New connection** near the upper-left corner.

    :::image type="content" source="../media/13.png" alt-text="Screenshot of select New connection." lightbox="../media/13.png":::

2. Select **SharePoint**.

    :::image type="content" source="../media/14.png" alt-text="Screenshot of select Sharepoint." lightbox="../media/14.png":::

3. To connect to SharePoint Online, select **Connect directly (cloud services)**, select **Create** and then provide credentials (if prompted).

    :::image type="content" source="../media/15.png" alt-text="Screenshot of select Create." lightbox="../media/15.png":::

4. The connection is created, and you can build an app from scratch.
