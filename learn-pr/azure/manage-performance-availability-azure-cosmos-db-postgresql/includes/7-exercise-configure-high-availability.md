Woodgrove Bank wants to ensure that their data is highly available and that standby servers can step in when an active server fails.

> [!IMPORTANT]
> This exercise relies on the Azure Cosmos DB for PostgreSQL database created in the Scale and Rebalance exercise in this module.

## Toggle high availability

1. Navigate to the Azure Cosmos DB for PostgreSQL resource in the Azure portal.
1. From the navigation, select **High availability**.
1. Select the **Enable high availability (HA)** checkbox.

    :::image type="content" source="../media/scale-enable-high-availability.png" alt-text="Screenshot of the High availability screen for the Azure Cosmos DB for PostgreSQL resource. The 'High availability' navigation is highlighted. The 'Enable high availability (HA)' checkbox is highlighted.":::

    While enabling the feature is quick in the portal, it takes time to spin up or tear down the standby replicas. This feature has an effect on the cost due to having resources on standby.

## Check the High Availability state

As high availability is enabled, the **High Availability** state shows in the Nodes list on the **Overview** for the Azure Cosmos DB for PostgreSQL resource.

:::image type="complex" source="../media/overview-high-availability-status.png" alt-text="Screenshot of the Overview screen for the Azure Cosmos DB for PostgreSQL resource.":::
    Screenshot of the Overview screen for the Azure Cosmos DB for PostgreSQL resource. The 'High availability' column in the Nodes section is highlighted. The coordinator and all worker nodes have a high availability state of Healthy.
:::image-end:::

High availability is enabled when all nodes show a high availability state of *Healthy*.

## Disable high availability

Once high availability is enabled, there are essentially two servers for every one - a primary server and a standby server. For this part, disable high availability. This process can take some time, as the standby servers are torn down.

1. Navigate to the Azure Cosmos DB for PostgreSQL resource in the Azure portal.
1. From the navigation, select **High availability**.
1. Uncheck the **Enable high availability (HA)** checkbox.
