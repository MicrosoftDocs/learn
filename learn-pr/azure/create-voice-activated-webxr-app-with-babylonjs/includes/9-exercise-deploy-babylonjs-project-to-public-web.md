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
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "## Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
