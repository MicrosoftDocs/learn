To create an Azure Cognitive Search solution, you need to create an **Azure Cognitive Search** resource in your Azure subscription. To use AI skills in an enrichment pipeline, you also need an **Azure Cognitive Services** resource to provide the AI services used by Azure Cognitive Search built-in skills.

> [!NOTE]
> You can use built-in skills without a Cognitive Services resource, but doing so restricts the number of documents you can enrich to 20 per day, per indexer.

## Create resources for Margie's Travel

The solution you will create for Margie's Travel requires the following resources in your Azure subscription:

- An Azure Storage account with a blob container in which the documents to be searched are stored.
- An Azure Cognitive Search resource, which will manage indexing and querying.
- An Azure Cognitive Services resource, which provides the AI services for skills in your enrichment pipeline

A script containing Azure command-line interface (CLI) commands to create these resources has been provided. Use the following steps to run it.

1. In the **km** project in Visual Studio Code, right-click (Ctrl+click if using a Mac) the **02-Create-an-enrichment-pipeline** folder and select **Open in Integrated Terminal**. This will open a new bash terminal pane.

    > [!TIP]
    > You're going to open multiple terminal sessions during this module, each associated with a folder. They'll all be available in the same **Terminal** pane, and you can switch between them using the drop-down list (which will currently include the *bash* terminal you just opened).

2. In the terminal pane, enter the following command to establish an authenticated connection to your Azure subscription.

    ```bash
    az login --output none
    ```

3. When prompted, open `https://microsoft.com/devicelogin`, enter the provided code, and sign into your Azure subscription. Then return to Visual Studio Code and wait for the sign-in process to complete.
4. In the terminal pane, enter the following command to create the resources in the East US region. If you want to use a different region, change `eastus` to the region name of your choice - for example, `westus` or `northeurope` (for a full list of available regions, use the `az account list-locations -o table` command):

    ```bash
    bash setup.sh eastus
    ```

5. When the script completes, review the output it displays and note the following information about your Azure resources (you will need these values later):
    - Resource group name
    - Storage account name
    - Storage connection string
    - Cognitive Services account
    - Cognitive Services key
    - Search service endpoint
    - Search service admin key
    - Search service query key

6. In a new browser tab, open the Azure portal at [https://portal.azure.com](https://portal.azure.com?azure-portal=true), signing in with the credentials associated with your Azure subscription if prompted.
7. In the Azure portal, find the resource group that was created by the setup script, and verify that it contains the Azure Storage account, Azure Cognitive Services resource, and Azure Cognitive Search resource.
