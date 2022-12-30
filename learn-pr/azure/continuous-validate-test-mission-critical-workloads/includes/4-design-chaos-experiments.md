In this unit, you'll learn about chaos engineering and how to use it to introduce faults in your system. 

Chaos engineering is a methodology that can improve your service's resiliency and its ability to react to failures. With chaos engineering, you conduct experiments in a controlled environment to identify problems that are likely to arise during development and deployment. 

To introduce chaos into a system, you deliberately inject real-world faults that cause system components to fail and then observe what happens. Afterward, you'll be able to respond quickly if this failure occurs under adverse conditions in production.

[Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resiliency.

## Failure mode analysis

When you design a chaos experiment, the first step is to conduct a [failure mode analysis (FMA)](/azure/architecture/resiliency/failure-mode-analysis) of the application components. FMA helps you identify any possible failure scenarios that each of these components could encounter. To start:

1. List all the components that are relevant for a user flow. For example, the checkout user flow requires the front-end web application, the checkout Azure Functions capability, and the Azure Cosmos DB database to all be available and functional.

1. For each of the identified components, list possible failure cases and their impact. Also list any potential mitigations that you've already implemented. 

The outcome of FMA can be tables like the following.

### Azure App Service front end

| Risk                   | Impact/Mitigation/Comments                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Availability zone outage**     | If an availability zone encounters an outage, the App Service instances in that zone might become unavailable. <br><br>Because you enabled zone redundancy on the App Service plan, you don't expect to see a full outage. However, you should allow for the extra load on the remaining instances and provide enough head room for this scenario while still achieving the performance targets.                     |
| **Source NAT (SNAT) port exhaustion**             | [SNAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) means no more outbound connections can be created. It's a common scenario on an App Service instance. <br><br>The problem occurs when downstream calls, such as calls to the database, fail. Although you could mitigate this problem by using private endpoints, Contoso Shoes hasn't yet implemented them for all the components.                      |
| **Individual instance becoming unhealthy** | Individual App Service instances can become unhealthy for various reasons, such as memory exhaustion or bad downstream requests. User traffic that gets routed to such an instance might see poor performance or even fail entirely. <br><br>Because you previously configured the App Service health check feature, any such instances will automatically be identified and replaced with new, healthy instances. |

### Azure Functions checkout

| Risk                   | Impact/Mitigation/Comments                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Slow (cold) start performance**     | When you start new instances by using the Azure Functions Consumption plan, you don't have performance guarantees. High demand on the service (from "noisy neighbors") might cause the checkout function to experience a long startup duration that affects performance targets. <br><br>Although the Azure Functions Premium plan would solve this problem, Contoso Shoes hasn't implemented that.                    |
| **Underlying storage outage**             | For Azure Functions to work correctly, it requires an Azure Storage account. If that account becomes unavailable, the function will stop working.                       |

### Azure Cosmos DB database

| Risk                   | Impact/Mitigation/Comments                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Renaming a database or collection**     | If a database or collection is renamed, there will be a mismatch in the configuration when you deploy. Terraform will then overwrite the entire database, which could result in data loss. The application won't be able to access any data until the app configuration is updated and its components are restarted. <br><br>Prevent this situation by using [database and collection-level locks](https://feedback.azure.com/forums/263030-azure-cosmos-db/suggestions/35535298-enable-locks-at-database-and-collection-level-as-w).                     |
| **Write region outage**             | Contoso Shoes has configured its Azure Cosmos DB account with multiple regions and automatic failover. If the primary region (or write region) encounters an outage, the service will automatically fail over and prevent any sustained problems in the application.                     |
| **Extensive throttling due to lack of request units (RUs)** | Depending on how many RUs (the maximum setting for the autoscaler) you want to deploy and what load balancing you want to use on a global load-balancer level, certain stamps might run hot on an Azure Cosmos DB utilization while others can still serve requests. <br><br>Mitigate this problem by using better load distribution to more stamps, or add more RUs.  |

## Design a chaos experiment

To design a chaos experiment, pick a few of the previously identified failure cases. You could pick a case based on the likelihood that it will happen or its possible impact.

The goal of the experiment is to validate resiliency measures that you've implemented in your application. For an example hypothesis, suppose you run your app on App Service with zone redundancy enabled. If all the underlying instances in a zone go down, you expect your app to still be running.

Use Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a [library of faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because the fault library doesn't cover everything, you might need to adjust your scenario. Or you might need to find more tools to help you inject the failure.

## Example: Azure Cosmos DB outage and failover

For the first experiment, pick the "write region outage" failure scenario of Azure Cosmos DB, as described in the previous table. The hypothesis is: *A service-initiated failover shouldn't result in any sustained impact on the application*. If this hypothesis proves to be true, you've validated that your resiliency measure (set up replication to multiple regions) has the desired positive effect on application reliability.

To simulate this fault, use the [Azure Cosmos DB failure](/azure/chaos-studio/chaos-studio-fault-library#azure-cosmos-db-failover) from the Chaos Studio fault library. The following example is for an Azure Cosmos DB failover that runs for 10 minutes (`PT10M`) and uses `West US 2` as the new write region. This example assumes that `West US 2` was already set up as one of the read replication regions.

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

Before you can inject a fault against an Azure resource, you must enable the corresponding [targets and capabilities](/azure/chaos-studio/chaos-studio-targets-capabilities) setting for the Azure Cosmos DB resource. This setting controls which faults can run against the resources that are enabled for fault injection. When you use targets and capabilities along with other security measures, you can avoid accidental or malicious fault injection when you use Chaos Studio.

> [!NOTE]
> Remember to target only a non-production environment with your experiments. Injecting faults into your production environment can be risky and requires experience and planning.
