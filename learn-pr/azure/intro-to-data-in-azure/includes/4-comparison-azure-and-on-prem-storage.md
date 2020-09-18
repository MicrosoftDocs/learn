Now that you know about the benefits and features of Azure data storage, let's see how it differs from on-premises storage.

The term "on-premises" refers to the storage and maintenance of data on local hardware and servers. There are several factors to consider when comparing on-premises to Azure data storage.

:::row:::
  :::column:::
    :::image type="icon" source="../media/4-cost-effectiveness.png" border="false":::
  :::column-end:::
  :::column span="3":::

## Cost effectiveness

An on-premises storage solution requires dedicated hardware that needs to be purchased, installed, configured, and maintained. This requirement can be a significant up-front expense (or capital cost). Change in requirements can require investment in new hardware. Your hardware needs to be capable of handling peak demand, which means it may sit idle or be under-utilized in off-peak times.

Azure data storage provides a pay-as-you-go pricing model, which is often appealing to businesses as an operating expense instead of an upfront capital cost. It's also scalable, allowing you to scale up or scale out as demand dictates and scale back when demand is low. You are charged for data services only as you need them.

:::column-end:::
:::row-end:::
:::row:::
  :::column:::
    :::image type="icon" source="../media/4-reliability.png" border="false":::
  :::column-end:::
  :::column span="3":::

## Reliability

On-premises storage requires data backup, load balancing, and disaster recovery strategies. These requirements can be challenging and expensive as they often each need dedicated servers requiring a significant investment in both hardware and IT resources.

Azure data storage provides data backup, load balancing, disaster recovery, and data replication as services to ensure data safety and high availability.

:::column-end:::
:::row-end:::
:::row:::
  :::column:::
    :::image type="icon" source="../media/4-storage-types.png" border="false":::
  :::column-end:::
  :::column span="3":::

## Storage types

Sometimes multiple different storage types are required for a solution, such as file and database storage. An on-premises approach often requires numerous servers and administrative tools for each storage type.

Azure data storage provides a variety of different storage options including distributed access and tiered storage. This variety makes it possible to integrate a combination of storage technologies providing the best storage choice for each part of your solution.

:::column-end:::
:::row-end:::
:::row:::
  :::column:::
    :::image type="icon" source="../media/4-agility.png" border="false":::
  :::column-end:::
  :::column span="3":::

## Agility

Requirements and technologies change. For an on-premises deployment, these changes may mean provisioning and deploying new servers and infrastructure pieces, which are a time consuming and expensive activity.

Azure data storage gives you the flexibility to create new services in minutes. This flexibility allows you to change storage back-ends quickly without needing a significant hardware investment.

  :::column-end:::
:::row-end:::

## Compare on-premises storage to Azure data storage

The following table describes the differences between on-premises storage and Azure data storage.

| Needs | On-premises | Azure data storage |
|---|---|---|
| Compliance and security | Dedicated servers required for privacy and security | Client-side encryption and encryption at rest |
| Store structured and unstructured data | Additional IT resources with dedicated servers required | Azure Data Lake and portal analyzes and manages all types of data |
| Replication and high availability | More resources, licensing, and servers required | Built-in replication and redundancy features available |
| Application sharing and access to shared resources | File sharing requires additional administration resources | File sharing options available without additional license |
| Relational data storage | Needs a database server with database admin role | Offers database-as-a-service options |
| Distributed storage and data access | Expensive storage, networking, and compute resources needed | Azure Cosmos DB provides distributed access |
| Messaging and load balancing | Hardware redundancy impacts budget and resources | Azure Queue provides effective load balancing |
| Tiered storage | Management of tiered storage needs technology and labor skill set | Azure offers automated tiered storage of data |
