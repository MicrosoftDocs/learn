Chaos engineering is a methodology that can improve your service's resiliency and its ability to react to failures. With it, you conduct experiments in a controlled environment to identify issues that are likely to arise during development and deployment. To introduce chaos into a system, deliberately inject faults that cause system components to fail, and then observe what happens. Afterwards, you'll be able to respond quickly if this failure occurs under adverse conditions during production.

[Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resilience. Chaos engineering is a methodology by which you inject real-world faults into your application to run controlled fault injection experiments.

# Failure Mode Analysis

When you design a chaos experiment, the first step is what is called the **failure mode analysis**. It is a "paper exercise" in which you think of possible failures scenarios that each of these components could encounter.

1. List all the components that are relevant for a given user flow. Let's take the checkout user flow. It requires the web app frontend, the checkout Azure Function and the Cosmos DB database to all be available and performant.

1. Next, for each of the identified components, list possible failure cases and their impact as well as potential mitigations that you have already implemented. The outcome can be a table like this:

### Frontend App Service

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Availability Zone outage**     | If an Availability Zone encounters an outage, the App Service instances in that zone might become unavailable. Since we have enable zonal redundancy on the App Service plan, we expect to not see a full outage. However, we need to cater for the additional load on the remaining instances. So there should be enough head room to cater for this scenario while still achieving our performance targets.                     |
| **SNAT port exhaustion**             | [Source NAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) is a common scenario on App Services when no more outbound connection can be created. The problem manifests in downstream calls failing, for instance to the database. Could for example be mitigated by the use of Private Endpoints, but as of today Contoso shoes has not implemented them for all the components.                      |
| **Individual instance becoming unhealthy** | Due to various reasons such as memory exhaustion, bad downstream requests etc., individual App Service instances might become unhealthy. Any user traffic that gets routed to such an instance might see poor performance or fail entirely. We have already configured the App Service Health Check feature which should determine such instances automatically and replace them with new, healthy ones. |

### Checkout Azure Function

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Slow (cold) start performance**     | Azure Functions on Consumption plan do not have performance guarantees when it comes to startup of new instances. Thus, due to high demand on the service ("noisy neighbors"), our checkout function might experience long startup duration which will impact our performance targets. Azure Functions Premium SKU would solve this issue but have not been implemented by Contoso Shoes at the moment.                    |
| **Underlying storage outage**             | Azure Functions require an Azure Storage Account to work correctly. If that storage account becomes unavailable, we expect the Function to also not work correctly anymore.                       |

### Cosmos DB

| **Risk**                   | **Impact/Mitigation/Comment**                |
| -------------------------------------------- | ------------------------------------------------------------ |
| **Database/collection is renamed**     | Can happen due to mismatch in configuration when deploying – Terraform would overwrite the whole database, which could result in data loss (this can be prevented by using [database/collection  level locks](https://feedback.azure.com/forums/263030-azure-cosmos-db/suggestions/35535298-enable-locks-at-database-and-collection-level-as-w)). <br />**Application will not be able to access any data**. App configuration needs to be updated and components restarted.                     |
| **Regional outage**             | Azure Mission-Critical has multi-region writes enabled, so in case of failure on read or write, the **client retries the current operation** and all the future operations are permanently [routed to the next region](https://docs.microsoft.com/azure/cosmos-db/troubleshoot-sdk-availability#regional-outage) in order of preference. In case the preference list only had one entry (or was empty) but the account has other regions available, it will route to the next region in the account list.                     |
| **Extensive throttling due to lack of RUs** | Depending on how we decide on how many RUs (max setting for the auto scaler), we want to deploy and what load balancing we employ on a global load balancer level, it could be that certain stamp(s) run hot on Cosmos utilization while others could still serve more requests. <br />Could be mitigated by better load distribution to more stamps – or of course more RUs. |

# Design chaos experiment

Pick a few of the previously identified failures cases for a chaos experiment. You might pick one based on the likelihood of it happening or its possible impact.

   The goal of the experiment isn't to break the system, but rather to validate resiliency measures that you've implemented in your application. For an example hypothesis, suppose you run your app on App Service with zonal redundancy enabled. If all the underlying instances in a zone go down, you expect your app to still be running.

We will use Azure Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a wide selection of [faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because it doesn't cover everything, you might need to adjust your scenario, or find additional tools to help you inject the failure.

   Injecting failures in isolation isn't meaningful. To be able to properly observe a system's behavior, you must run a load against the system at the same time as the failure, preferably your previously designed load test. However, when you run your load test, you might need to consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails but you still expect the test to pass.

Before you can inject a fault against an Azure resource, the resource must first have corresponding **targets and capabilities** enabled. Targets and capabilities control which resources are enabled for fault injection and which faults can run against those resources. Using targets and capabilities along with other security measures you can avoid accidental or malicious fault injection with Chaos Studio.
