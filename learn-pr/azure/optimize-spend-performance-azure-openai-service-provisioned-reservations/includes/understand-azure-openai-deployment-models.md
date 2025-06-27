<!-- ## Azure OpenAI deployment types -->

Azure OpenAI offers customers choices on the hosting structure that best fits their business and usage patterns. The service provides two main types of deployment:

- **Standard (pay-per-token)**
- **Provisioned (uses PTUs)**

Standard deployments provide a pay-per-token billing model on the chosen model. It's the fastest way to get started because you only pay for what you consume during service usage. Specifically, for Azure OpenAI Service, the Standard deployment type lets you pay only for tokens processed. Standard deployments are optimized for low-to-medium-volume workloads with high burstiness. Customers with high, consistent volume may experience a more significant latency variability. Azure OpenAI also offers the Standard deployment type with a global deployment option, routing traffic globally to provide higher throughput.

> [!NOTE]
> Models and throughput availability in each region may be limited.

Provisioned deployments allow you to specify the amount of throughput required in your Azure OpenAI deployment. The service then allocates the necessary model processing capacity and ensures it's ready for you. Throughput is defined in terms of provisioned throughput units or PTUs, which is a normalized way of representing the throughput for your deployment. This deployment type ensures consistent throughput and minimal latency variance for scalable solutions.

> [!NOTE]
> All deployments can perform the same inference operations. However, the billing, scale, and performance are substantially different.

As part of your solution design, you need to make two key decisions:

- **Data residency needs: Data Zone, Global, or Regional**
- **Call volume: Standard versus Provisioned**

**Global Standard**: Global deployments are available in the same Azure OpenAI resources as non-global deployment types but allow you to leverage Azure's global infrastructure to dynamically route traffic to the data center with best availability for each request. Global standard provides the highest default quota and eliminates the need to load balance across multiple resources.

**Global provisioned**: Global deployments are available in the same Azure OpenAI resources as non-global deployment types but allow you to leverage Azure's global infrastructure to dynamically route traffic to the data center with best availability for each request. Global provisioned deployments provide reserved model processing capacity for high and predictable throughput using Azure global infrastructure.

**Global batch**: Global batch is designed to handle large-scale and high-volume processing tasks efficiently. Process asynchronous groups of requests with separate quota, with 24-hour target turnaround.  With batch processing, rather than send one request at a time you send a large number of requests in a single file. Global batch requests have a separate enqueued token quota avoiding any disruption of your online workloads.

**Data zone standard**: Data zone standard deployments are available in the same Azure OpenAI resource as all other Azure OpenAI deployment types but allow you to leverage Azure global infrastructure to dynamically route traffic to the data center within the Microsoft defined data zone with the best availability for each request. Data zone standard provides higher default quotas than our Azure geography-based deployment types.

**Data zone provisioned**: Data zone provisioned deployments are available in the same Azure OpenAI resource as all other Azure OpenAI deployment types but allow you to leverage Azure global infrastructure to dynamically route traffic to the data center within the Microsoft specified data zone with the best availability for each request. Data zone provisioned deployments provide reserved model processing capacity for high and predictable throughput using Azure infrastructure within the Microsoft specified data zone.

**Regional Standard**: Standard deployments provide a pay-per-token billing model on the chosen model. It's the fastest way to get started because you only pay for what you consume during service usage. Specifically, for Azure OpenAI Service, the Standard deployment type lets you pay only for tokens processed. Standard deployments are optimized for low-to-medium-volume workloads with high burstiness. Customers with high, consistent volume may experience a more significant latency variability.

**Regional Provisioned**: Provisioned deployments allow you to specify the amount of throughput required in your Azure OpenAI Service deployment. The service then allocates the necessary model processing capacity and ensures it's ready for you. Throughput is defined in terms of provisioned throughput units or PTUs, which is a normalized way of representing the throughput for your deployment. This deployment type ensures consistent throughput and minimal latency variance for scalable solutions.

> [!NOTE]
> All deployments can perform the same inference operations. However, the billing, scale, and performance are substantially different.

## What does the provisioned deployment type provide?

With the provisioned deployment type, you get:

- **Flexible deployment**: model-independent units for any models and real-time allocation
- **Scalability**: default quota in all regions and self-serve with auto-approval
- **Predictable costs**: hourly billing and reservations

PTUs offer a predictable pricing model where you reserve and deploy a specific amount of model processing capacity. This model is ideal for workloads with consistent or predictable usage patterns, providing stability and cost control.

An Azure OpenAI deployment is a unit of management for a specific OpenAI Model. A deployment provides customer access to a model for inference and integrates more features such as Content Moderation.

Typically, you would choose PTU when an application:

- Is ready for production or in production.

- Has predictable capacity/usage expectations.

- Has real-time/latency sensitive requirements.

When creating a provisioned deployment in Azure OpenAI Foundry, the deployment type on the **Create Deployment** dialog box is **Provisioned-Managed**. When creating a provisioned deployment in Azure OpenAI via command-line interface (CLI) or API, you need to set the SKU name to **Provisioned-Managed**. The SKU capacity specifies the number of PTUs assigned to the deployment.

## Summary

In this unit, you learned about the different Azure OpenAI deployments: Standard, and Provisioned. You learned how they are priced differently, the benefits of each, and the different use cases that best suit each deployment. By understanding these deployment types, you can make informed decisions on which deployment strategy aligns best with your application's needs, ensuring optimal performance and cost management.
