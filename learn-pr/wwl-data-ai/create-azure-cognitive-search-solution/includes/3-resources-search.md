To create an Azure Cognitive Search solution, you need to create an **Azure Cognitive Search** resource in your Azure subscription. Depending on the specific solution you intend to build, you may also need Azure resources for data storage and other application services.

## Service tiers and capacity management

When you create an Azure Cognitive Search resource, you must specify a *pricing tier*. The pricing tier you select determines the capacity limitations of your search service and the configuration options available to you, as well as the cost of the service. The available pricing tiers are:

- **Free (F)**. Use this tier to explore the service or try the tutorials in the product documentation.
- **Basic (B)**: Use this tier for small-scale search solutions that include a maximum of 15 indexes and 2 GB of index data.
- **Standard (S)**: Use this tier for enterprise-scale solutions. There are multiple variants of this tier, including **S**, **S2**, and **S3**; which offer increasing capacity in terms of indexes and storage, and **S3HD**, which is optimized for fast read performance on smaller numbers of indexes.
- **Storage Optimized (L)**: Use a storage optimized tier (**L1** or **L2**) when you need to create large indexes, at the cost of higher query latency.

> [!NOTE]
> It's important to select the most suitable pricing tier for your solution, because you can't change it later. If you find that the pricing tier you have chosen is no longer suitable for your solution, you must create a new Azure Cognitive Search resource and recreate all indexes and objects.

### Replicas and partitions

Depending on the pricing tier you select, you can optimize your solution for scalability and availability by creating *replicas* and *partitions*.

- *Replicas* are instances of the search service - you can think of them as nodes in a cluster. Increasing the number of replicas can help ensure there is sufficient capacity to service multiple concurrent query requests while managing ongoing indexing operations.

- *Partitions* are used to divide an index into multiple storage locations, enabling you to split I/O operations such as querying or rebuilding an index.

The combination of replicas and partitions you configure determines the *search units* used by your solution. Put simply, the number of search units is the number of replicas multiplied by the number of partitions (R x P = SU). For example, a resource with four replicas and three partitions is using 12 search units.

> [!TIP]
> You can learn more about pricing tiers and capacity management in the [Azure Cognitive Search documentation](https://docs.microsoft.com/azure/search/search-sku-tier).

## Create resources for Margie's Travel

The solution you will create for Margie's Travel requires the following resources in your Azure subscription:

- An Azure Storage account with a blob container in which the documents to be searched are stored.
- An Azure Cognitive Search resource, which will manage indexing and querying.

A script containing Azure command-line interface (CLI) commands to create these resources has been provided. Use the following steps to run it.

1. In Visual Studio Code, right-click (Ctrl+click if using a Mac) the **01-Create-a-search-solution** folder and select **Open in Integrated Terminal**. This will open a new bash terminal pane.

    > [!TIP]
    > You're going to open multiple terminal sessions during this module, each associated with a folder. They'll all be available in the same **Terminal** pane, and you can switch between them using the drop-down list (which will currently include the *bash* terminal you just opened for the **01-Create-a-search-solution** folder.).

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
    - Search service endpoint
    - Search service admin key
    - Search service query key

6. Open the Azure portal at [https://portal.azure.com](https://portal.azure.com?azure-portal=true), signing in with the credentials associated with your Azure subscription if prompted.
7. In the Azure portal, find the resource group that was created by the setup script, and verify that it contains the Azure Storage account and Azure Cognitive Search resource.
