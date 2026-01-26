Containerized applications require dynamic scaling to handle varying workloads while controlling costs. This module guides you through configuring automatic horizontal scaling in Azure Container Apps to build responsive, cost-efficient container deployments that adapt to real-time demand.

Imagine you're a developer building an order processing service for an e-commerce platform. The application experiences predictable traffic spikes during sales events and unpredictable bursts when marketing campaigns launch. Your current deployment uses fixed resources, leading to poor response times during peak periods and wasted capacity during quiet hours. The operations team reports that costs have increased substantially because the application runs at full capacity around the clock. Meanwhile, customer complaints about slow checkout times have increased during flash sales.

Your team decides to implement automatic scaling in Azure Container Apps. You need the application to scale out rapidly when HTTP requests increase, process messages from Azure Service Bus queues during order fulfillment, and scale back to zero during idle periods to minimize costs. The platform must handle both synchronous API traffic and asynchronous background processing with different scaling behaviors. Leadership expects the solution to reduce infrastructure costs by at least 40% while maintaining response times under 200 milliseconds during peak load.

## Learning objectives

After completing this module, you'll be able to:

- Configure HTTP, TCP, CPU, and memory scale rules for container apps
- Implement event-driven scaling using KEDA scalers for Azure services
- Select appropriate compute resources to optimize performance and cost
- Apply revision modes to control scaling behavior and traffic distribution
