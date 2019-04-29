Azure Search is a rich search experience over a variety of content wherever the content is stored.

Your organization has a website where exercise videos are published. Your organization now needs to add a catalog index capability to enable users to search across the entire catalog using different properties. Azure search has been chosen as the tool of choice to enrich the web content.

In the unit, you'll create the Azure Search Service.

<!-- Activate the sandbox -->
[!INCLUDE [azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

## Create an Azure Search service in the Azure portal

[!INCLUDE [TODO - azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. From the portal, click **Create a resource** from the upper left-hand corner. Select **Web**, then select **Azure Search**.

   ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. On the **New Search Service** page, fill out the form using this information:

    | Setting      | Value |
    | ------------ | ----- |
    | **URL** | **contosofitness** |
    | **Subscription** | Your subscription |
    | **Resource group** |  Create Use the existing group <rgn>[sandbox resource group name]</rgn> |
    | **Location** | Select your nearest data centre |

    ![TODO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

1. Click **Pricing tier** to specify the service tier. Select the **Basic** service tier, then click **Select**.

1. Click **Create** to create your Azure Search Service.

1. On the toolbar, click **Notifications** to monitor the deployment process.

When the process completes, click **Pin to dashboard** to pin your database server to the dashboard so that you have quick access when you need it later.

   ![TO DO - INSERT SCREENSHOT.](../media/3-exercise-screenshot-2.png)

Your Azure Search Service is now up and running. There are many options to further configure your new search instance.

If you were to continue to interact with the search service programmatically you will need to obtain the URL and API key.

1. Go to the overview blade of the ContosoFitness Search Service database. If you pinned the service earlier, you can click the **ContosoFitness** tile on the dashboard to get there.

1. Click **URL** and paste the URL into notepad.

1. Click on the **Keys** blade in the left hand menu.

    ![TODO - INSERT SCREENSHOT OF KEYS.](../media/3-exercise-screenshot.png)

1. Click the document icon next to the **Primary Admin Key** and paste into notepad.

In the next part, you'll learn how to load data into your newly created Search service and manage indexes.