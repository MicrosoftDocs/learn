Your mission-critical application needs to be resilient and be ready to respond to failures. But, it's difficult to predict potential failure scenarios in the cloud. Chaos engineering allows you to conduct failure experiments in a controlled environment to identify problems that are likely to arise during development and deployment. You deliberately inject real-world faults and observe how the system reacts. 

In this unit, we'll use [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview). The service will help you measure, understand, and improve your cloud application and service resiliency. You'll be prepared to respond quickly if this failure occurs under adverse conditions in production.

## Conduct failure mode analysis

When you design a chaos experiment, the first step is to conduct [failure mode analysis (FMA)](/azure/architecture/resiliency/failure-mode-analysis) of the application components to identify potential failure scenarios.

1. List all the components that are relevant for a user flow that need to be available and functional. For example, the checkout user flow uses Azure App Services, Functions, and Cosmos DB database.

1. For each component, list possible failure cases, their impact, and any potential mitigations. 

Let's see the outcome of FMA done for the components of the Contoso Shoes checkout user flow example. 

##### Azure App Service for hosting the front end application

|Risk|Impact|Possible mitigation|
|---|---|---|
|**Availability zone outage**| Instances in that zone might become unavailable. </br>Full outage isn't expected because zone redundancy is enabled on the App Service plan.| Allow for the extra load on the remaining instances and provide enough head room for this scenario while still achieving the performance targets.|
|[**SNAT port exhaustion**](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors)| Outbound connections can't be created. As a result, downstream calls, such as calls to the database, fail.|Use private endpoints for connecting to the downstream components.  
|**Individual instance becoming unhealthy** | User traffic routed to an unhealthy instance might see poor performance or even fail entirely.|The App Service health check feature will cause unhealthy instances to be automatically identified and replaced with new, healthy instances. |

##### Azure Functions for checkout logic

|Risk|Impact|Possible mitigation|
|---|---|---|
| **Slow (cold) start performance**| Because Azure Functions Consumption plan is used, new instances won't have performance guarantees. </br> High demand on the service (from "noisy neighbors") might cause the checkout function to experience a long startup duration that affects performance targets.|Upgrade to the Azure Functions Premium plan.|
| **Underlying storage outage**| If the underlying storage account becomes unavailable, the function will stop working.|Use [Load balanced compute with regional storage](/azure/azure-functions/durable/durable-functions-disaster-recovery-geo-distribution#scenario-2---load-balanced-compute-with-regional-storage) or [Load balanced compute with GRS shared storage](/azure/azure-functions/durable/durable-functions-disaster-recovery-geo-distribution#scenario-3---load-balanced-compute-with-grs-shared-storage).|

##### Azure Cosmos DB database

|Risk|Impact|Possible mitigation|
|---|---|---|
| **Renaming a database or collection**| Because of mismatch in configuration, there could be data loss. The application won't be able to access any data until the configuration is updated and its components are restarted.| Prevent this situation by using [database and collection-level locks](/azure/cosmos-db/resource-locks).|
| **Write region outage**|If the primary region (or write region) encounters an outage, the Azure Cosmos DB account will automatically promote a secondary region to be the new primary write region when automatic (service-managed) failover is configured on the Azure Cosmos DB account. The failover will occur to another region in the order of region priority you've specified.|Configure the database account with multiple regions and automatic failover. If there's a failure, the service will automatically fail over and prevent any sustained problems in the application.|
| **Extensive throttling due to lack of request units (RUs)** | Certain stamps might run hot on Azure Cosmos DB utilization while others can still serve requests. |Use better load distribution to more stamps, or add more RUs.|

## Design a chaos experiment

To design a chaos experiment, pick a few failure cases. The choice can be based on the likelihood that the failure will happen or the possible impact.

The goal of the experiment is to validate resiliency measures that you've implemented in your application. For an example hypothesis, suppose you run your application on App Service with zone redundancy enabled. If all the underlying instances in a zone go down, you expect your application to be still running.

Use Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a [library of faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because the fault library doesn't cover everything, you might need to adjust your scenario. Or you might need to find more tools to help you inject the failure.

> [!IMPORTANT]
> Target only a non-production environment with your experiments. Injecting faults into your production environment can be risky and requires experience and planning.

##### Example: Azure Cosmos DB outage and failover

Suppose you pick the "write region outage" failure scenario of Azure Cosmos DB listed in the table. The hypothesis is: *A service-initiated failover shouldn't result in any sustained impact on the application*. If this hypothesis proves to be true, you've validated that your resiliency measure of replicating to multiple regions has the desired positive effect on application reliability.

To simulate this fault, use the [Azure Cosmos DB failure](/azure/chaos-studio/chaos-studio-fault-library#azure-cosmos-db-failover) from the Chaos Studio fault library. 

This example is for an Azure Cosmos DB failover that runs for 10 minutes (`PT10M`) and uses `West US 2` as the new write region. It assumes that `West US 2` was already set up as one of the read replication regions.

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

Before you can inject a fault against an Azure resource, you must enable the corresponding [targets and capabilities](/azure/chaos-studio/chaos-studio-targets-capabilities) setting for that resource. This setting controls the faults that can run against the resources enabled for fault injection. When you use targets and capabilities with other security measures, you can avoid accidental or malicious fault injection.

Now that you've designed both load tests and chaos experiments, you need to automate them into your pipelines so that they run consistently and regularly. In the next unit, you'll learn about adding the tests your CI/CD pipelines. 
