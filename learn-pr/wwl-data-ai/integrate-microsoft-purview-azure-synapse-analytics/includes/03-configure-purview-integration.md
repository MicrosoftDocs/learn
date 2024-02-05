
So far, you've learned how you can use Azure Synapse Analytics data stores as sources for a Microsoft Purview catalog; which is similar in most respects to using any other data source.

What sets Azure Synapse Analytics apart from many other data sources is the ability to configure direct integration between an Azure Synapse Analytics workspace and a Microsoft Purview account. By linking your workspace to a Purview account, you can:

- Search the Purview catalog in the Synapse Studio user interface.
- Push details of data pipeline activities to Purview in order to track data lineage information.

## Connect a Purview account to a Synapse Analytics workspace

You connect a Microsoft Purview account to an Azure Synapse Analytics workspace on the **Manage** page of Synapse Studio, as shown here:

![A screenshot of the Manage page in Synapse Studio with a Purview account connected.](../media/synapse-purview.png)

### Security considerations

To connect a Purview account by using the Synapse Studio interface, you require **Collection Administrator** access to the Purview account's root collection. After successfully connecting the account, the managed identity used by your Azure Synapse Analytics workspace will be added to the collection's **Data Curator** role.

If your Microsoft Purview account is behind a firewall, you need to create a managed endpoint, and configure the connection to access Purview using that endpoint. For more information, see [Access a secured Microsoft Purview account from Azure Synapse Analytics](/azure/synapse-analytics/catalog-and-governance/how-to-access-secured-purview-account?azure-portal=true).

> [!TIP]
> To learn more about connecting Azure Synapse Analytics to Microsoft Purview, see [QuickStart: Connect a Synapse workspace to a Microsoft Purview account](/azure/synapse-analytics/catalog-and-governance/quickstart-connect-azure-purview?azure-portal=true).
>
> You'll get a chance to connect an Azure Synapse Analytics workspace to a Microsoft Purview account in the exercise later in this module.
