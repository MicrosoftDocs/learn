This guided project consists of the following exercises:

 - Create storage account and enable hosting
 - **Upload and verify site content**
 - Update the site content

In this exercise, you create an HTML page and a custom error page, upload both to the $web container, and visit your live site to confirm everything works. This is where your static website goes from an empty endpoint to a real page that anyone can visit.

This exercise includes the following tasks:

 - Create the HTML file locally
 - Upload the file to the $web container
 - Create and upload a custom error page
 - Verify the live site and error page

**Outcome:** A live public website displaying your Version 1 content.

## Task 1: Create the HTML file locally

Create a simple HTML file on your computer that will serve as the initial version of your website. This file represents the content your team wants to publish.

1.  On your local computer, open a text editor (such as Notepad).
2.  Paste the following content:

    ```html
    <!DOCTYPE html>
    <html>
    <head><title>Product Landing Page</title></head>
    <body>
      <h1>Version 1 - Landing Page</h1>
      <p>Welcome to our product page. This is the initial published version.</p>
    </body>
    </html>
    ```

3.  Save the file as **index.html**.

## Task 2: Upload the file to the $web container

Upload your HTML file to the special **$web** container that Azure created when you enabled static website hosting. Files in this container are automatically served to visitors who browse to your site endpoint.

1.  In the Azure portal, return to your storage account.
2.  In the left menu, under **Data storage**, select **Containers**.
3.  Select the **$web** container.
4.  Select **Upload**.
5.  Select **Browse for files**, select the **index.html** file you created, and upload it.
6.  Confirm that **index.html** appears in the container file list.

## Task 3: Create and upload a custom error page

Create a custom 404 error page that visitors see when they browse to a page that doesn't exist. Without this file, visitors get a generic XML error, which looks unprofessional.

1.  On your local computer, open a text editor.
2.  Paste the following content:

    ```html
    <!DOCTYPE html>
    <html>
    <head><title>Page Not Found</title></head>
    <body>
      <h1>404 - Page Not Found</h1>
      <p>The page you requested does not exist. Return to the <a href="/">home page</a>.</p>
    </body>
    </html>
    ```

3.  Save the file as **404.html**.
4.  In the Azure portal, return to the **$web** container.
5.  Select **Upload**, select **Browse for files**, select the **404.html** file, and upload it.
6.  Confirm that both **index.html** and **404.html** appear in the container.

> [!NOTE]
> **Validation step:** The **$web** container should list both **index.html** and **404.html**.

## Task 4: Verify the live site and error page

Open the public endpoint in a browser to confirm your website is live, and then test the custom error page. This validates that static website hosting is correctly configured for both normal pages and missing pages.

1.  In the Azure portal, navigate back to your storage account (use the portal search bar to search for **Storage accounts** and select your account if needed).
2.  In the left menu, under **Data management**, select **Static website**.
3.  Select the **Primary endpoint** link to open the site in a new browser tab.
3.  Confirm the page displays **Version 1 - Landing Page** and the welcome message.
4.  In the browser address bar, add **/fakepage** to the end of the URL and press Enter.
5.  Confirm the custom 404 page appears with the **Page Not Found** heading and a link back to the home page.
6.  Select the **home page** link and confirm it returns to the Version 1 landing page.

> [!NOTE]
> **Validation step:** The landing page displays **Version 1 - Landing Page**, and browsing to a nonexistent path shows your custom **404 - Page Not Found** page.