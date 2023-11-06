You're an architect working for a business that wants to build an innovative new online store for your customers. The store can differentiate your business and give you a lead over your competitors. You want to use cloud native patterns and practices to allow you to rapidly deliver an initial version of the store. Then, you can iterate quickly to add new features, adapt to the needs of your business, and stay ahead of your competition. The store itself needs to be highly available, offering a high level of performance to ensure customers have a great experience while using the store. The store also needs to cope with varying levels of demand.

You want to build the application using containers and you're adopting DevOps practices. The application consists of multiple discrete services and some services need to communicate with other services in Azure. This diagram provides a high-level overview of the architecture of the application.

:::image type="content" source="../media/1-introduction-app-architecture.svg" alt-text="Diagram that shows two types of pipeline triggers." border="false":::

Your company has recently standardized on Kubernetes to host all container-based workloads. You've been asked to design the cluster for the new service. You quickly come to realize that the design of the cluster involves the design of the network, and that the needs of the application heavily influence the network design. Where do you begin with designing your network?

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

Upon completing this module, you're able to:

- List the key Kubernetes resource types that require network access.
- Assess an application's needs and how that could impact network design.
- Understand the steps to size an Azure Kubernetes Service cluster for a workload.
- Design a network for an Azure Kubernetes Service cluster using Azure CNI networking.

## Prerequisites

- Understand Docker containers at a beginner level.
- Understand Kubernetes at a beginner level.
- Understand networking basics, such as IP addresses and CIDR address ranges.