## Example scenario

You're an architect working for a business that wants to build a new online store for its customers. This new online store can differentiate the business and give it a lead over its competitors. The store needs to be highly available and performant to ensure customers have a great experience. The store also needs to be able to handle varying levels of demand. The application consists of multiple discrete services. Some services need to communicate with other services in Azure. 

The following diagram provides a high-level overview of the application's architecture:

:::image type="content" source="../media/1-introduction-app-architecture.svg" alt-text="Diagram that shows two types of pipeline triggers." border="false":::

Your team is tasked with building and delivering an initial version of the store as quickly as possible. From there, you can iterate to add new features, adapt to business needs, and stay ahead of the competition.

Your team plans to build the application using DevOps and cloud native patterns and practices. Your company has recently standardized on Kubernetes to host all container-based workloads and decided to use the Azure Container Networking Interface (CNI) for the cluster. You're tasked with designing the cluster for the new service, which involves designing the network. To effectively design the network, you need to understand the requirements, constraints, and considerations of the Azure CNI networking model.

Before you begin, it's important you understand the details about some key Kubernetes components. In the next unit, we provide an overview of key Kubernetes networking concepts.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]
