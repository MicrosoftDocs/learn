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

- **Data residency needs: global versus regional resources**
- **Call volume: Standard versus Provisioned**

For Standard deployment types, you can have two configurations within your resource: global or regional.
Global deployments use Azure's global infrastructure, and dynamically route customer traffic to the data center with the best availability for the customer's inference requests. This means customers will get the highest initial throughput limits and best model availability while still providing an uptime service-level agreement (SLA) and low latency. However, you must choose regional deployment if you have specific data residency requirements. For high-volume workloads above the specified usage tiers, you might experience increased latency variation. Provisioned throughput is recommended for customers who require a lower latency variance at large workload usage.

The following table describes usage scenarios best suited for the various Azure OpenAI deployment types.

| Global-Batch | Global-Standard | Global-Provisioned | Standard | Provisioned |
| --- | --- | --- | --- | --- |
| Offline scoring | Recommended starting place for customers. | Real-time scoring for large consistent volume. | For customers with data residency requirements. | Real-time scoring for large consistent volume. |
| Workloads that are not latency-sensitive and can be completed in hours. | Global-Standard will have a higher default quota and a larger number of models available than Standard. | Includes the highest commitments and limits. | Optimized for low-to-medium volume. | Includes the highest commitments and limits. |
| For use cases that do not have data processing residency requirements. | *Not applicable* | For use cases that do not have data residency requirements. | *Not applicable* | *Not applicable* |

It is important to note that the Global-Batch deployment type is an asynchronous API that does offline processing by using files. This deployment type returns completion within 24 hours for a 50 percent discount on Global Standard Pricing. It also provides access to all new models with larger quota allocations. For Global-Standard and Global-Batch, your prompts might be routed to any location worldwide. For Standard deployment type, you can set the location for processing.

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

When creating a provisioned deployment in Azure OpenAI Studio, the deployment type on the **Create Deployment** dialog box is **Provisioned-Managed**. When creating a provisioned deployment in Azure OpenAI via command-line interface (CLI) or API, you need to set the SKU name to **Provisioned-Managed**. The SKU capacity specifies the number of PTUs assigned to the deployment.

## Summary

In this unit, you learned about the different Azure OpenAI deployments: Standard, and Provisioned. You learned how they are priced differently, the benefits of each, and the different use cases that best suit each deployment. By understanding these deployment types, you can make informed decisions on which deployment strategy aligns best with your application's needs, ensuring optimal performance and cost management.
