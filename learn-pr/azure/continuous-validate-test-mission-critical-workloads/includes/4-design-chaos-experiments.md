Chaos engineering is a methodology that can improve your service's resiliency and its ability to react to failures. With it, you conduct experiments in a controlled environment to identify issues that are likely to arise during development and deployment. To introduce chaos into a system, deliberately inject real-world faults that cause system components to fail, and then observe what happens. Afterwards, you'll be able to respond quickly if this failure occurs under adverse conditions during production.

[Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resilience.

## Failure mode analysis

When you design a chaos experiment, the first steps are known as *failure mode analysis*. It's a paper exercise in which you think of possible failures scenarios that each of these components could encounter:

1. List all the components that are relevant for a given user flow. For example, the checkout user flow requires the front-end web application, the checkout Azure Function and the Cosmos DB database to all be available and performant.

1. For each of the identified components, list possible failure cases and their impact, and any potential mitigations that you've already implemented. The outcome can be a table like this:

### Front-end app service

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Availability zone outage**     | If an availability zone encounters an outage, the app service instances in that zone might become unavailable. Because we've enabled zonal redundancy on the app service plan, we expect to not see a full outage. However, we need to cater for the extra load on the remaining instances. So, there should be enough head room to cater for this scenario while still achieving our performance targets.                     |
| **SNAT port exhaustion**             | [Source NAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) is a common scenario on an app service when no more outbound connection can be created. The problem occurs in downstream calls failing, for example, calls to the database. It could, for example, be mitigated by the use of private endpoints, but Contoso Shoes hasn't yet implemented them for all the components.                      |
| **Individual instance becoming unhealthy** | For various reasons, such as memory exhaustion or bad downstream requests, individual app service instances might become unhealthy. Any user traffic that gets routed to such an instance might see poor performance or even fail entirely. Because we've previously configured the App Service health check feature, any such instances should automatically be identified and replaced with new, healthy instances. |

### Checkout Azure Function

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Slow (cold) start performance**     | When you start new instances using the Azure Functions Consumption plan, it doesn't have performance guarantees. Therefore, due to high demand on the service (from "noisy neighbors"), our checkout function might experience a long startup duration that might impact our performance targets. Although the Azure Functions Premium plan will solve this issue, it hasn't yet been implemented by Contoso Shoes.                    |
| **Underlying storage outage**             | For Azure Functions to work correctly, it requires an Azure Storage account. If that account becomes unavailable, the function will stop working.                       |

### Azure Cosmos DB

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Database/collection is renamed**     | Caused by a mismatch in configuration when you deploy. In this case, Terraform will overwrite the entire database, which could result in data loss. Prevent this situation by using [database/collection level locks](https://feedback.azure.com/forums/263030-azure-cosmos-db/suggestions/35535298-enable-locks-at-database-and-collection-level-as-w). <br />**Application won't be able to access any data**. App configuration needs to be updated and its components restarted.                     |
| **Write region outage**             | Contoso Shoes has configured their Azure Cosmos DB account with multiple regions and automatic failover. In case the primary region (that is, write region) encounters an outage, the service will automatically fail over and we shouldn't see any sustained issues on the application.                     |
| **Extensive throttling due to lack of RUs** | Depending on how we decide how many RUs (max setting for the auto scaler) we want to deploy and what load balancing to employ on a global load balancer level, that certain stamps might run hot on an Azure Cosmos DB utilization while others might be able to serve more requests. <br />Might be mitigated by better load distribution to more stamps or more RUs. |

## Design a chaos experiment

For a chaos experiment, pick a few of the previously identified failures cases. You might pick one based on the likelihood of it happening, or its possible impact.

   The goal of the experiment isn't to break the system, but rather to validate resiliency measures that you've implemented in your application. For an example hypothesis, suppose you run your app on App Service with zonal redundancy enabled. If all the underlying instances in a zone go down, you expect your app to still be running.

We'll use Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a wide selection of [faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because it doesn't cover everything, you might need to adjust your scenario, or find more tools to help you inject the failure.

## Cosmos DB outage and failover

For our first experiment, we'll pick the **Write region outage** failure scenario of Azure Cosmos DB as described in the previous table. We've stated what we're calling our hypothesis: *A service-initiated failover shouldn't result in any sustained impact on our application*. If this hypothesis proves to be true, we've validated that our taken resiliency measure (set up replication to multiple regions) does indeed have the desired positive effect on our application reliability.

To simulate this fault, we use the [Azure Cosmos DB failure](/azure/chaos-studio/chaos-studio-fault-library#azure-cosmos-db-failover) from the Chaos Studio fault library.

The following example is for an Azure Cosmos DB failover that will be running for 10 minutes (`PT10M`) and will make `West US 2` as the new write region. This  assumes that West US 2 was already set up as one of the read replication regions.

```json
{
  "name": "branchOne",
  "actions": [
    {
      "type": "continuous",
      "name": "urn:csci:microsoft:cosmosDB:failover/1.0",
      "parameters": [
        {
          "key": "readRegion",
          "value": "West US 2"
        }
      ],
      "duration": "PT10M",
      "selectorid": "myCosmosDbResource"
    }
  ]
}
```

After the experiment ends, Chaos Studio switches the write region back to its original value.

Before you can inject a fault against an Azure resource, our Azure Cosmos DB resource must first have the corresponding **targets and capabilities** enabled. [Targets and capabilities](/azure/chaos-studio/chaos-studio-targets-capabilities) control which resources are enabled for fault injection and which faults can run against those resources. Using targets and capabilities along with other security measures you can avoid accidental or malicious fault injection with Chaos Studio.

_Remember to target only a non-production environment with your experiments_. Although it's desirable to be in a situation where you can confidently inject faults into your production environment, doing so requires much experience and planning.
