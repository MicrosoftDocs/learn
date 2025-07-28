In a cloud environment, it's easy to create resources, explore features, and try everything on offer. In the same way, it becomes easy to create these environments without taking into consideration some important best practices.

The [Azure Well-Architected Framework](/azure/architecture/framework/index) describes five pillars of architectural excellence: reliability, security, cost optimization, operational excellence, and performance efficiency. Azure Advisor is a tool that can help you follow best practices for the five pillars. It gives you proactive, actionable, and personalized recommendations to help you track your cloud environment and usage.

:::image type="content" source="../media/1-advisor-overview.png" alt-text="Screenshot of the Azure portal showing the overview of cost, security, reliability, operational excellence, and performance in Azure Advisor." lightbox="../media/1-advisor-overview.png":::

## Example scenario

Imagine you're running a critical workload composed of different types of Infrastructure as a Service (IaaS) resources. The resources might include virtual machines and/or database servers. You might also have Platform as a Service (PaaS) resources like storage accounts, Bastion hosts, DNS, or application gateways. The following diagram illustrates such an architecture:

:::image type="content" source="../media/1-arch-iaas.png" alt-text="Diagram of an Azure reference architecture with Domain Name System (DNS), storage account, and a virtual network hosting a web tier, data tier, and application gateway." border="false":::

## What are you going to do?

As you're running a workload consisting of a mixed set of resources, you want to ensure that you're using the best approach around performance and cost. The tasks aren't always easy. You need deep knowledge on a diverse range of resources, along with good cloud skills expertise.

In the following units, you learn how Azure Advisor can help you accomplish these management tasks in a smart and efficient way.

## What's the main goal?

By the end of this module, you're able to check and validate the recommendations from Azure Advisor and understand how to customize alerts around these actions and recommendations.
