This guided project consists of the following exercises:

 - **Create storage account and enable hosting**
 - Upload and verify site content
 - Update the site content

In this exercise, you create a resource group, set up a storage account, and turn on the static website hosting feature. By the end, you have a public URL ready to serve web content—even though you haven't uploaded any files yet.

This exercise includes the following tasks:

 - Prepare the environment
 - Create the storage account
 - Enable static website hosting

**Outcome:** A storage account with static website hosting enabled and a public endpoint ready to serve content.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment before you begin. You create a resource group to organize all the resources for this project together, which makes cleanup easier when you finish.

> [!WARNING]
> This project creates Azure resources that may incur charges. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create storage resources.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**. Name the resource group **rg-gp-static-website**, choose your preferred region, and select **Review + create** then **Create**.

## Task 2: Create the storage account

Create a general-purpose storage account that will host your website files. Azure Blob Storage can serve static HTML, CSS, and image files directly to browsers without requiring a web server.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the Basics tab, select **rg-gp-static-website** as the resource group.
4.  For **Storage account name**, enter a globally unique name (for example, **stgpstaticsite** followed by your initials and a number). Storage account names must be 3-24 characters, lowercase letters and numbers only.
5.  For **Region**, choose the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then select **Create**.
10. When deployment finishes, select **Go to resource**.

## Task 3: Enable static website hosting

Turn on the built-in static website feature. This creates a special container named **$web** where you upload your site files, and provides a public URL that serves those files to visitors.

1.  In the storage account left menu, under **Data management**, select **Static website**.
2.  Set Static website to **Enabled**.
3.  For **Index document name**, enter **index.html**.
4.  For **Error document path**, enter **404.html**.
5.  Select **Save**.
6.  Note the **Primary endpoint** URL that appears after saving. This is the public URL for your website.

> [!NOTE]
> **Validation step:** Confirm that static website hosting shows **Enabled**, and that a Primary endpoint URL is displayed.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go—you'll review them all in the validation unit at the end of this module.