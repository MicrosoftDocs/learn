
Chaos engineering is a methodology that's aimed at increasing your service's resiliency and its ability to react to failures. By conducting experiments in a controlled environment, you can identify issues that are likely to arise during development and deployment. A common way to introduce chaos in a system is to deliberately inject faults that cause system components to fail. The goal is to observe, monitor, respond to, and improve your system's reliability under adverse circumstances. 

[Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resilience.

To design a chaos experiment, follow these steps:

1. List all the components that are relevant for a given user flow. These should include application components and cloud services such as Azure Cosmos DB or Azure App Service.

2. Think of possible failures scenarios that each of these components could encounter. This process is called failure mode analysis.

3. Pick a few of the previously identified failures cases for a chaos experiment. You might pick one based on the likelihood of it happening or its possible impact.

   The goal of the experiment isn't to break the system, but rather to validate resiliency measures that you've implemented in your application. For example, suppose you run your app on virtual machines (VMs) in multiple availability zones. If all the VMs in a zone go down, you expect your app to still be running (this result is called a hypothesis).  

4. Use Azure Chaos Studio to inject the faults into the relevant components. Chaos Studio offers a wide selection of [faults](/azure/chaos-studio/chaos-studio-fault-library) for you to choose from. However, because it doesn't cover everything, you might need to adjust your scenario, or find additional tools to help you inject the failure.

   Injecting failures on its own isn't meaningful. You need to run a load against the system at the same time as the failure to be able to observe the behavior. This is where you can use your previously designed load test. However, you might need to think about adjusted baselines. For example, you might accept a higher response time when a certain component fails but still expect the test to pass.
