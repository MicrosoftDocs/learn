
In a typical large-scale analytics solution, data is transferred and transformed across multiple systems until it's loaded into an analytical data store for reporting and analysis. Tracking the *lineage* of data as moves across the enterprise is an important factor in determining the provenance, trustworthiness, and recency of data assets used to inform analysis and decision making.

## Generate and view data lineage information

In Azure Synapse Analytics, data movement and transformation is managed by using *pipelines*, which consist of an orchestrated set of *activities* that operate on data. The design and implementation of pipelines is too large a subject to cover in depth in this module, but a key point to be aware of is that there are two activity types available in Synapse Analytics pipelines that automatically generate data lineage information in a connected Purview catalog:

- The **Copy Data** activity
- The **Data Flow** activity

Running a pipeline that includes either of these activities in a workspace with a connected Purview account will result in the creation or update of data assets with lineage information. The assets recorded include:

- The source from which the data is extracted.
- The activity used to transfer the data.
- The destination where the data is stored.

In the Microsoft Purview Governance Portal, you can open the assets in the Purview catalog, and view the lineage information as shown here:

![A screenshot of a data asset in Purview, showing the lineage tab.](../media/purview-lineage.png)

You can also view the lineage for a pipeline activity in Synapse Studio.

> [!TIP]
> For more information about tracking data lineage for Azure Synapse Analytics pipelines in Microsoft Purview, see [How to get lineage from Azure Synapse Analytics into Microsoft Purview](/azure/purview/how-to-lineage-azure-synapse-analytics?azure-portal=true).
>
> You'll get a chance to generate and view data lineage from a Synapse Analytics pipeline in the exercise later in this module.
