Microsoft Purview can be integrated directly into Azure Synapse. If Azure Synapse Studio is massively deployed in your organization, you can get the data catalog experience directly in Azure Synapse Studio.

This integrated experience allows you to discover Microsoft Purview assets, interact with them through Synapse capabilities, and push lineage information to Microsoft Purview.

>[!NOTE]
>To connect an Microsoft Purview Account to a Synapse workspace, you need 2 types of permissions. You need a contributor role in Synapse workspace from Azure portal identity and access management (IAM). You also need access to that Microsoft Purview Account. For more information, see [Microsoft Purview permissions](/azure/purview/catalog-permissions).

Let’s imagine you need to find and understand some assets before working with them in pipelines or notebooks. From Azure Synapse Studio, you can easily query your Microsoft Purview data catalog.

In Azure Synapse Studio, from the **Data** blade on the left, select **Purview** in the dropdown next to the search bar.

![Dropdown on the left of the search bar displays the option to search the Synapse Workspace or Microsoft Purview.](../media/azure-purview-integrate-synapse-1.png)

Search for the asset that exists in Purview. Imagine you're looking for movie files. Enter the keyword **movie** in the search bar, and fine tune your search by selecting **Files** as the object type and **Raw** as the collection.

![The term movie is in the search bar. The search can be refined by specifying an object typye and collection in the filter pane on the left side of the search results.](../media/azure-purview-integrate-synapse-2.png)

Select the first asset “Movies.csv” to get asset details. Because you are in Azure Synapse Studio, you can also leverage Azure Synapse capabilities.

![The develop tab of the asset on the right side of the horizontal menu allows you to use Synapse develop capabilities on the asset.](../media/azure-purview-integrate-synapse-3.png)

For instance, you can use Azure Synapse serverless to query your assets. Select **Develop**, **New SQL Script** and **Select top 100**.

![Option to create new SQL script on the develop menu item, on the far right side of the horizontal menu.](../media/azure-purview-integrate-synapse-4.png)

Double check you're connected to your serveless instance and select **Run** to execute the script and get an overview of your data.

![Display of executed SQL script including a table with columns MovieID, MovieTitle, Category, Rating, RunTimeMin, and ReleaseDate.](../media/azure-purview-integrate-synapse-5.png)

After reviewing data, you can use the asset, for example, adding to a new dataflow in Azure Synapse. 

[![Create new dataflow from purview search interface in Azure Synapse studio.](../media/azure-purview-synapse-data-flow.png)](../media/azure-purview-synapse-data-flow.png#lightbox)

>[!NOTE]
>See [Connect an Microsoft Purview Account](/azure/synapse-analytics/catalog-and-governance/quickstart-connect-azure-purview) for detailed information about integrating Microsoft Purview into Azure Synapse Analytics.