In a cloud environment, it's easy to create resources, explore features, and try everything that's offered. In the same way, it becomes easy to create these environments without taking into consideration some important best practices.

The [Azure Well-Architected Framework](azure/architecture/framework/) describes five pillars of architectural excellence: reliability, security, cost optimization, operational excellence, and performance efficiency. Azure Advisor is a tool that can give you proactive, actionable, and personalized recommendations to help you track your cloud environment and usage, and follow best practices for the five pillars.

:::image type="content" source="../media/1-advisor-overview.png" alt-text="Screenshot of the Azure portal showing the overview of cost, security, reliability, operational excellence and performance in Azure Advisor." lightbox="media/1-advisor-overview.png":::

## Example scenario

Imagine you're running a critical workload composed of different types of Infrastructure as a Service (IaaS) resources. The resources might include virtual machines and/or database servers. You might also have Platform as a Service (PaaS) resources like storage accounts, bastion hosts, DNS, or application gateways. The following diagram illustrates such an architecture:

:::image type="content" source="../media/1-arch-iaas.png" alt-text="Diagram of an Azure reference architecture with DNS, storage account, and a virtual network hosting a web tier, data tier, and application gateway." lightbox="media/1-arch-iaas.png" border="false":::

## What will we be doing?

As you're running a workload consisting of a mixed set of resources, you want to ensure that you're using the best approach around performance and cost. The tasks aren't always easy. You need deep knowledge on a diverse range of resources, along with good cloud skills expertise.

In the units that follow, you'll learn how Azure Advisor can help you accomplish these management tasks in a smart and efficient way.

## What's the main goal?

By the end of this module, you'll be able to check and validate the recommendations from Azure Advisor and understand how to customize alerts around these actions and recommendations.
