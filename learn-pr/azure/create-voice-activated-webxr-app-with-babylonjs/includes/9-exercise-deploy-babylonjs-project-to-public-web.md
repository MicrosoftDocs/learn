Azure Blob Storage allows developers to serve static content on the web by storing the source files in the *$web* container.

Recall that in the scenario of the amusement park application, we need to make the Babylon.js WebXR application available on the public web.

In this exercise, you''ll use Azure Blob Storage to serve the amusement park application as a public static website.

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

## Build the web project

Before jumping into hosting the website, we must first package our Node.js web project into a folder of static files.

1. If you don't already have a terminal open in VSCode, select **Terminal** in the menu of Visual Studio Code, and then select **New Terminal** to create a new terminal.
1. Within the terminal, make sure that you are in the root folder of the repository.
1. Run `npm run-script build` in the terminal to package the project into static files.
1. After the command finishes running, you should see a folder named *dist* created in the root folder of the project.

## Create a storage account

Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and make sure that you're using the same account that you used to create the Azure Speech resource.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.
1. After landing on the **Marketplace** page, in the **Search the Marketplace** box, type **storage account** and press the Enter key.
1. Select **Storage Account** from the results.

    :::image type="content" source="../media/marketplace-storage-account.png" alt-text="A screenshot of the Azure Marketplace results. There's a red box around the Speech service.":::

1. On the page for the Storage Account resource, select **Create**.

1. On the **Basics** tab, enter the following values for each setting.

    |Field  |Value  |Details  |
    |---------|---------|---------|
    | **Project details**| | |
    |**Subscription**    |   Concierge subscription      |    The resource you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs or will belong, if you're creating the resource group within the wizard.     |
    |**Resource group**     |   <rgn>[Sandbox resource group]</rgn>      |    The resource group to which the Speech service will belong. All Azure resources must belong to a resource group.     |
    | **Instance details**| | |
    |**Name**     |    Enter a unique name     |   Choose a globally unique name for the resource. For example, you might name the resource *webxrmagicxxx*, where the x's are replaced with your initials or a series of numbers. If the name isn't globally unique, you can try any other combination. Valid characters are a-z and 0-9. The name must be 3 to 24 characters long and will be used to generate the public URL for accessing data in the account.      |
    |**Region**     |    Geographical location near you     |   The geographical location where your app will be used.      |
    |**Performance** | Standard | This option decides the type of disk storage used to hold the data in the Storage account. Standard uses traditional hard disks, and Premium uses solid-state drives (SSD) for faster access. |
    |**Redundancy** | Geo-redundant storage (GRS) | In the case of a regional unavailability, the data in the storage account will still be present and accessible thanks to redundancy in other regions. Keep "Make read access to data available in the event of regional unavailability" checked. |

    :::image type="content" source="../media/create-storage-account.PNG" alt-text="Screenshot of values for creating a storage account on Azure portal":::

1. Select **Review + Create**.

> [!NOTE]
> It can take a few seconds to get the storage account created and ready for use. A notification will appear after deployment is complete.

## Enable Static Website Hosting

1. On the Azure portal menu or from the **Home** page, select **All resources**.

1. Select the storage account from the list.

    :::image type="content" source="../media/all-resources-storage-account.png" alt-text="A screenshot of the list of all resources. There's a red box around the Web X R dash magic dash spell resource.":::

1. In the **Data management** section, select **Static website**.

    :::image type="content" source="../media/select-static-website.png" alt-text="A screenshot of the Speech service resource page. There's a red box around the menu item Keys and Endpoint.":::

1. Toggle the Static website switch to **Enabled**, and put **index.html** as the **Index document name**.

    :::image type="content" source="../media/static-website-settings.PNG" alt-text="Settings page for the static website hosted using Azure Blob Storage":::

1. Select **Save**.
1. After the settings are applied, you will see the default URLs provided for your website.

    :::image type="content" source="../media/static-website-url.png" alt-text="Screenshot of the static website U R L s provided by default.":::

## Upload static source files for the website

1. In the page of your storage account instance, select **Storage Explorer (preview)** from the side menu.

    :::image type="content" source="../media/select-storage-explorer.png" alt-text="Screenshot of the side menu of the web X R magic storage account. The Storage Explorer preview tab is surrounded by a red box.":::

1. Under **BLOB CONTAINERS**, select the **$web** container. Then select the **Upload** button to open the Upload side panel. Select the **folder** icon to choose the files to upload.

    :::image type="content" source="../media/storage-upload-ui.png" alt-text="Screenshot of the Storage Explorer with $web, Upload, and a folder icon surrounded with a red box.":::

1. Select the **Upload** button to upload the source files within the *dist* folder (excluding the **assets** folder).

    :::image type="content" source="../media/source-files-uploaded.PNG" alt-text="Screenshot of the website source files uploaded to blob storage.":::

1. Next, let's upload the *assets* folder. Select **New Folder** and name the folder **assets**.

    :::image type="content" source="../media/create-assets-folder.png" alt-text="A screenshot of the Storage Explorer preview page with the New Folder button and the assets text input box surrounded with a redbox.":::

1. Select **OK** to create the folder. You should be taken to the newly created directory.

1. In this directory, upload the files from your local *assets* folder.

    :::image type="content" source="../media/uploaded-assets.PNG" alt-text="A screenshot of the Storage Explorer page with the list of assets files uploaded.":::

## Accessing the website from your device
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
