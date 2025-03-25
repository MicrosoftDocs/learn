The cloud has changed the way organizations solve their business challenges, and how applications and systems are designed. The role of a solution architect isn't limited to delivering business value through the functional requirements of the application. They must also ensure that the solution is designed in ways that are scalable, resilient, efficient, and secure.

Solution architecture is concerned with the planning, design, implementation, and ongoing improvement of a technology system. The architecture of a system must balance and align the business requirements with the technical capabilities that are needed to execute those requirements. The finished architecture is a balance of risk, cost, and capability throughout the system and its components.

## Azure Well-Architected Framework

The Azure Well-Architected Framework is a set of guiding tenets to build high-quality solutions on Azure. There's no one-size-fits-all approach to designing an architecture, but there are some universal concepts that apply regardless of the architecture, technology, or cloud provider.

These concepts aren't all-inclusive, but focusing on them can help you build a reliable, secure, and flexible foundation for your application.

The Azure Well-Architected Framework consists of five pillars:

- Cost Optimization
- Operational Excellence
- Performance Efficiency
- Reliability
- Security

![An illustration that shows the pillars of the Azure Well-Architected Framework.](../media/pillars.png)

### Cost Optimization

The Cost Optimization pillar focuses on how to consider your return on investment (ROI) and financial constraints when you create business goals. This guidance helps you determine how to allocate budgets, define spending patterns and priority areas, and maximize your resource investments.

![An illustration that shows increasing quality, speed, and efficiency while maintaining decreasing costs.](../media/efficiency.png)

### Operational Excellence

The Operational Excellence pillar focuses on DevOps practices to help ensure workload quality through standardized workflows and team cohesion. This pillar defines procedures for development, observability, and release management to minimize process variance, human error, and customer disruption. 

### Performance Efficiency

The Performance Efficiency pillar focuses on the ability of your workload to adjust to changes in demands. A workload must be able to handle an increase in load without compromising user experience. Conversely, when there's a decrease in load, the workload must conserve its resources. Capacity, which indicates resource availability (CPU and memory), is a significant factor. You need a comprehensive strategy to sustain performance targets over time.

![An illustration that shows how resources in the cloud scale dynamically based on demand, resulting in highly efficient usage. When resources are implemented at a fixed level, it results in inefficient usage during low demand and shortage during high demand.](../media/performance-demand.png)

### Reliability

The Reliability pillar focuses on the resiliency, availability, and recoverability of your workload. A reliable workload must survive outages and malfunctions and continue to consistently provide its intended functionality. It must be resilient so that it can detect, withstand, and recover from failures within an acceptable time period. It must also be available so that users can access the workload during the promised time period at the promised quality level.

:::image type="content" source="../media/system-failure.png" alt-text="An illustration that shows two virtual machines in a virtual network. One of the machines is shown as failed, while the other is working to service customer requests." loc-scope="other"::: <!--no-loc -->

### Security

The Security pillar focuses on your workload's resiliency to security concerns. A secure workload is resilient to attacks and incorporates the interrelated security principles of confidentiality, integrity, and availability (also known as the CIA Triad) in addition to meeting business goals. A Well-Architected workload must also be built with the Zero Trust approach.

![An illustration that shows the types of security threats and attacks that might affect your data in the cloud.](../media/security.png)

## General design principles

In addition to each of these pillars, there are some consistent design principles that you should consider throughout your architecture.

- **Enable architectural evolution**: No architecture is static. Allow for the evolution of your architecture by taking advantage of new services, tools, and technologies when they're available.

- **Use data to make decisions**: Collect data, analyze it, and use it to make decisions surrounding your architecture. From cost data, to performance, to user load, using data can guide you to make the right choices in your environment.

- **Educate and enable**: Cloud technology evolves quickly. Educate your development, operations, and business teams to help them make the right decisions and build solutions to solve business problems. Document and share configurations, decisions, and best practices within your organization.

- **Automate**: Automation of manual activities reduces operational costs, minimizes error introduced by manual steps, and provides consistency between environments.

## Shared responsibility

Moving to the cloud introduces a model of shared responsibility. In this model, your cloud provider manages certain aspects of your application, leaving you with the remaining responsibility.

In an on-premises environment, you're responsible for everything. As you move to infrastructure as a service (IaaS), then to platform as a service (PaaS) and software as a service (SaaS), your cloud provider takes on more of this responsibility.

This shared responsibility plays a role in your architectural decisions, because these decisions can have implications on cost, security, and your application's technical and operational capabilities. By shifting these responsibilities to your provider, you can focus on bringing value to your business and move away from activities that aren't a core business function.

![An illustration that shows the level of shared responsibilities in each type of cloud-service model.](../media/cloud-responsibility-model.png)

## Design choices

In an ideal architecture, you'd build the most secure, high-performance, highly available, and efficient environment possible. However, as with everything, there are tradeoffs.

To build an environment with the highest level of all these pillars, there's a cost. That cost might be in money, time to deliver, or operational agility. Every organization has different priorities that affect the design choices that are made in each pillar. As you design your architecture, you need to determine which trade-offs are acceptable and which aren't.

When you're building an Azure architecture, there are many considerations to keep in mind. You want your architecture to be secure, scalable, available, and recoverable. To make that possible, you have to make decisions based on cost, organizational priorities, and risk.
