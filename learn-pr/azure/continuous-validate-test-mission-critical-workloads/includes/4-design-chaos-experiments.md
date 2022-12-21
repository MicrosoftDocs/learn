Chaos engineering is a methodology that can improve your service's resiliency and its ability to react to failures. With it, you conduct experiments in a controlled environment to identify issues that are likely to arise during development and deployment. To introduce chaos into a system, deliberately inject faults that cause system components to fail, and then observe what happens. Afterwards, you'll be able to respond quickly if this failure occurs under adverse conditions during production.

[Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resilience. Chaos engineering is a methodology by which you inject real-world faults into your application to run controlled fault injection experiments.

When you design a chaos experiment, follow these steps:

1. List all the components that are relevant for a given user flow. In this example, the relevant components are the backend inventory management application, Azure Cosmos DB, and Azure App Service.

2. Next is what is called the **failure mode analysis**. Is is a "paper exercise" in which you think of possible failures scenarios that each of these components could encounter.

3. Pick a few of the previously identified failures cases for a chaos experiment. You might pick one based on the likelihood of it happening or its possible impact.

   The goal of the experiment isn't to break the system, but rather to validate resiliency measures that you've implemented in your application. For an example hypothesis, suppose you run your app on Azure Kubernetes Service (AKS) with zonal redundancy enabled. If all the underlying nodes (VMs) in a zone go down, you expect your app to still be running.

4. Use Azure Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a wide selection of [faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because it doesn't cover everything, you might need to adjust your scenario, or find additional tools to help you inject the failure.

   Injecting failures in isolation isn't meaningful. To be able to properly observe a system's behavior, you must run a load against the system at the same time as the failure, preferably your previously designed load test. However, when you run your load test, you might need to consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails but you still expect the test to pass.

Before you can inject a fault against an Azure resource, the resource must first have corresponding **targets and capabilities** enabled. Targets and capabilities control which resources are enabled for fault injection and which faults can run against those resources. Using targets and capabilities along with other security measures you can avoid accidental or malicious fault injection with Chaos Studio.
