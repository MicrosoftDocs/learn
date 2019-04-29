Azure Search can be used in a code-free way via the Portal. The wizards and editors aren't as feature rich as the SDK and REST APIs, but they will enable you to explore the best features quickly.

Your organization has a website where exercise videos are published. Your organization now needs to add a catalog index capability to enable users to search across the entire catalog using different properties. Azure Search has been chosen as the tool to enrich the web content.

In the unit, you'll create the Azure Search Service.

<!-- Activate the sandbox -->
[!INCLUDE [azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

## Create an Azure Search service in the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. From the portal, select **Create a resource** from the upper left-hand corner. Select **Web**, then select **Azure Search**.

   ![Screenshot of the Azure portal, New Search Service pane](../media/3-exercise-screenshot-2.png)

1. On the **New Search Service** page, fill out the form using this information:

    | Setting      | Value |
    | ------------ | ----- |
    | **URL** | northwindfitness* this needs to be unique  |
    | **Resource group** |  Select the concierge resource group <rgn>[sandbox resource group name]</rgn> |
    | **Location** | Select your nearest data center |

1. Select **Create**.

    Your Azure Search Service is now up and running. There are many options to further configure your new search instance.

    If you were to continue to interact with the search service programmatically, you will need to obtain the URL and API key.

   ![Screenshot of the Azure portal, searching for the created search service](../media/3-exercise-screenshot-3.png)

1. Search **northwindfitness** at the top of the dashboard, then select the search service you created.

    ![Screenshot of the Azure portal, highlighting the URL field on the Overview page](../media/3-exercise-screenshot-4.png)

1. Select **URL** and paste the URL into notepad.

    ![Screenshot of the Azure portal, ](../media/3-exercise-screenshot-5.png)

1. Select on the **Keys** blade in the left hand menu.

1. Select the document icon next to the **Primary Admin Key** to copy the value, and then paste it into notepad.

In the next part, you'll learn how to load data into your newly created Search service and manage indexes.