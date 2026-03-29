This guided project focuses on deploying a static website using Azure Blob Storage.

Azure Blob Storage can serve HTML, CSS, and image files directly to browsers without a web server. When you enable the static website hosting feature on a storage account, Azure creates a public endpoint and a special container where you upload your site files.

## Scenario

Your marketing team needs to publish a product landing page quickly without provisioning virtual machines or web servers. The team wants to upload content, verify it's live, push an update, and confirm the change — all through the Azure portal.

- Exercise 1 - Create a storage account and enable static website hosting.
- Exercise 2 - Upload HTML content and verify the live site.
- Exercise 3 - Update the site content and confirm the change.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing a static website on Azure Blob Storage with storage account, $web container, and public endpoint." border="false":::

By the end of this project, you have a working public website hosted entirely from blob storage, and you understand how to publish and update content with minimal cost.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Create and configure a storage account**
+ Create a resource group and storage account.
+ Enable static website hosting and configure index and error documents.
+ Locate the primary endpoint URL.

**Upload and manage blob content**
+ Upload HTML files to the $web container.
+ Overwrite existing blobs to publish content updates.
+ Review blob properties including access tier and content type.

**Verify a public endpoint**
+ Browse to the static website endpoint and confirm content.
+ Test a custom 404 error page.
+ Verify that content updates appear immediately.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
