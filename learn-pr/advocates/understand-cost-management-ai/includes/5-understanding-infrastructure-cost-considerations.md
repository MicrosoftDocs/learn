In some respects, an AI application is like any other cloud workload. It needs something to run on, like a virtual machine, containers, or an event-driven service. It needs to be available on a network (using public or private endpoints), and the AI service needs to connect with other resources in the application. It requires storage or databases, and should be secured, monitored for performance, and backed up.

Infrastructure components for AI workloads can include:

- Azure Virtual Machines
- Azure Kubernetes Service
- Azure Functions
- Availability zones
- Storage
- Networking
- Load balancing
- Security products
- Azure Monitor
- Azure Backup

Specific details of which infrastructure resources to deploy will be driven by the business requirements for the application. Is it for internal use only in your organization, but is expected to become business critical? Is it public facing but subject to seasonal or event driven peaks in demand? Is it a small proof of concept or a test application?  Many of the factors considered by an organization when defining their recovery time objective (the amount of the time the application can be down before it impacts business operations) will influence the specific size, features, or SKU of the application's infrastructure.

A business-critical application has a higher requirement to be fault-tolerant and available, and additional redundancy and features in premium resources SKUs come at a higher cost. This may feel hard to justify, until you're facing downtime.

Remember, before you get to the AI service specifics of an application, make sure you understand the business requirements and ensure that the infrastructure resources (and other non-AI services) have been sized and costed appropriately.
