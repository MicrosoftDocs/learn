The costs of running an Azure Cognitive Search solution vary depending on the capacity and features you use. 

Here, you'll explore the billing model, learn how to estimate baseline costs, and monitor those costs with budgets. 

## Estimate your search solutions baseline costs

The Azure pricing calculator is a great tool that allows you to estimate the costs of using any of the Azure services. Use it to create a baseline for your search service needs. 

1. Browse to the [Azure Cognitive Search pricing calculator](https://azure.microsoft.com/pricing/details/search/).
1. Choose your region, currency, and hour or monthly pricing.

:::image type="content" source="../media/azure-price-calculator.png" alt-text="A screenshot of the Azure pricing tool showing the cost estimates of an S1 and S2 tier service." lightbox="../media/azure-price-calculator.png":::

The above example shows estimates based on the number of search units. The shown monthly costs don't include everything you need for an accurate estimate. The pricing calculator also lists estimates on the additional services.

:::image type="content" source="../media/additional-price-examples.png" alt-text="A screenshot of the additional Cognitive Search services." lightbox="../media/additional-price-examples.png":::

> [!IMPORTANT]
> The prices shown are for illustration purposes, please check the price calculator for the most up-to-date values.

Using the above information an estimate for an S2 tier search solution, using four search units (SU), extracting 80,000 images, and using 200,000 semantic queries would be:


|Item        |Estimate  |
|------------|---------:|
|S2 tier 4SU | $981.12 * 4 = **$3,924.48** |
|Cracking images | 1$ * 80 = **$80**       |
|Semantic search |  **$500**       |
|Total estimate |  **$4,504.48** per month       |

The final costs related to running a search service are the data ingestion and storage costs. So the above estimate doesn't include other infrastructure costs you can accrue. These other costs would be things like the storage and processing of your source data.

Part of running a cost-effective Azure Cognitive Search solution is always optimizing its capacity, from the tier you need, the data you're searching, and the features you use.

## Understand the billing model

Azure Cognitive Search is billed in the same way as other resources you use in Azure. Take the above baseline estimate as an example, after you've created the all the resources you incur costs:

- Hourly for the service tier search units you're using ($3,924.48 ÷ 744 =  $5.27 per hour approximately)

The other premium features are billed as you use them.

|Feature  |Unit  |
|---------|---------|
|Indexer usage     | Per 1000 API calls        |
|Image extraction (AI enrichment)     | Per 1000 text records       |
|Built-in skills (AI enrichment)     | Number of transactions, billed at the same rate as if you had performed the task by calling Azure AI Services directly. You can process 20 documents per indexer per day for free. Larger or more frequent workloads require a multi-resource Azure AI Services key.        |
|Custom Entity Lookup skill (AI enrichment)     |Per 1000 text records         |
|Semantic Search     | Number of queries of "queryType=semantic", billed at a progressive rate        |
|Private Endpoints     | Billed as long as the endpoint exists, and billed for bandwidth        |

Remember you're not charged for the number of search queries, responses, or documents ingested.

> [!NOTE]
> There are service quotas that you should be aware of, see [Service limits in Azure Cognitive Search](/azure/search/search-limits-quotas-capacity).

## Tips to reduce the cost of your search solution

These tips can help you reduce the cost of running your search solution:

1. Minimize bandwidth costs by using as few regions as possible. Ideally, all the resources should reside in the same region.
1. If you have predictable patterns of indexing new data, consider scaling up inside your search tier. Then scale back down for your regular querying.
1. To keep your search requests and responses inside the Azure datacenter boundary, use an Azure Web App front-end as your search app.
1. Enable enrichment caching if you're using AI enrichment on blob storage.

## Manage search service costs using budgets and alerts

The most effective way to manage your costs is to monitor how much you're spending, and take action if the costs have increased over your budget.

All Azure resources can be monitored with budgets in Azure Cost Management. Follow the steps in [Tutorial: Create and manage Azure budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) for a detailed walk-through on how to create budgets.

:::image type="content" source="../media/budgets-cost-management.png" alt-text="A screenshot of the budgets section of Azure cost management." lightbox="../media/budgets-cost-management.png":::

With your budget in place, you can enable alerts to notify you if your organizations search stakeholders to avoid the risks of overspending.