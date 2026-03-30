This guided project consists of the following exercises:

 - Create storage account and enable hosting
 - Upload and verify site content
 - **Update the site content**

In this exercise, you create an updated version of your HTML file, upload it to replace the original, and verify the change is live. You also explore blob properties like access tier and content type to understand how Azure stores your files.

This exercise includes the following tasks:

 - Create the updated HTML file
 - Upload the updated file
 - Verify the updated site
 - Review blob properties and access tier

**Outcome:** The live website displays updated Version 2 content after replacing the original file.

## Task 1: Create the updated HTML file

Prepare a new version of the page content. In a real scenario, this represents a content update from the marketing team that needs to replace the current live page.

1.  On your local computer, open a text editor.
2.  Paste the following content:

    ```html
    <!DOCTYPE html>
    <html>
    <head><title>Product Landing Page</title></head>
    <body>
      <h1>Version 2 - Landing Page</h1>
      <p>Welcome to our updated product page with the latest information.</p>
    </body>
    </html>
    ```

3.  Save the file as **index.html** (overwriting the previous version).

## Task 2: Upload the updated file

Replace the existing file in the **$web** container with your updated version. Uploading a file with the same name overwrites the previous version, which is how you publish content updates to a static website.

1.  In the Azure portal, navigate to your storage account.
2.  Under **Data storage**, select **Containers** and open the **$web** container.
3.  Select **Upload**.
4.  Select **Browse for files** and select the updated **index.html** file.
5.  Check the box for **Overwrite if files already exist**.
6.  Select **Upload**.

## Task 3: Verify the updated site

Confirm that the live website now shows the updated content. Because static website hosting serves files directly from blob storage, the change should appear immediately.

1.  Return to the browser tab showing your static website (or open the **Primary endpoint** URL again).
2.  Refresh the page.
3.  Confirm the page now displays **Version 2 - Landing Page** and the updated message.

> [!NOTE]
> **Validation step:** The live site now shows **Version 2 - Landing Page**, confirming the content update was published successfully.

## Task 4: Review blob properties and access tier

Examine the properties of your uploaded files to understand how Azure stores them. Each blob has metadata, an access tier, and a content type that affects how browsers handle it.

1.  In the Azure portal, navigate to the **$web** container.
2.  Select the **index.html** blob to open its properties.
3.  On the **Overview** tab, note the **URL**, **Access tier** (Hot by default), and **Content type** (text/html).
4.  Select **Edit** and review the raw content to confirm it matches your Version 2 HTML.
5.  Select **Cancel** to return without changes.
6.  Navigate back to the container and select **404.html** to compare its properties with index.html.

> [!NOTE]
> **Validation step:** Both blobs show **Content type** of **text/html** and **Access tier** of **Hot**.