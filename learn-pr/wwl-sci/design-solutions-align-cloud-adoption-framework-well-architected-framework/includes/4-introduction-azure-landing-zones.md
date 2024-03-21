An Azure landing zone is the output of a multi-subscription Azure environment that accounts for scale, security governance, networking, and identity. An Azure landing zone enables application migration, modernization, and innovation at enterprise-scale in Azure. This approach considers all platform resources that are required to support the customer's application portfolio and doesn't differentiate between infrastructure as a service or platform as a service.

A landing zone is an environment for hosting your workloads, pre-provisioned through code.

## Scalable and modular

No single solution fits all technical environments. However, a few Azure landing zone implementation options can help you meet the deployment and operations needs of your growing cloud portfolio.

-   **Scalable:** All Azure landing zones support cloud adoption at scale by providing repeatable environments, with consistent configuration and controls, regardless of the workloads or Azure resources deployed to each landing zone instance.
-   **Modular:** All Azure landing zones provide an extensible approach to building out your environment, based on a common set of design areas. The extensibility of an Azure landing zone enables an organization to easily scale specific elements of the environment, as requirements evolve.

## Platform vs. application landing zones

There are two types of landing zones:

-   **Platform landing zones:** Subscriptions deployed to provide centralized services, often operated by a central team, or a number of central teams split by function (e.g. networking, identity), which will be used by various workloads and applications. Platform landing zones represent key services that often benefit from being consolidated for efficiency and ease of operations. Examples include networking, identity, and management services.
    
-   **Application landing zones:** One or more subscriptions deployed as an environment for an application or workload. Application landing zones are placed in management groups like 'corp' or 'online' beneath the 'landing zones' management group to ensure policy controls are correctly applied. Application landing zones can be subcategorized as follows:
    
    -   **Centrally managed**: A central IT team fully operates the landing zone. The team applies controls and platform tools to both the platform and application landing zones.
    -   **Technology platforms**: With technology platforms such as AKS or AVS, the underlying service is often centrally managed. The applications running on top of the service have delegated responsibilities to application teams. This results in modified controls or access permissions compared to centrally managed landing zones.
    -   **Workload**: A platform administration team delegates the entire landing zone to a workload team to fully manage and support the environment; whilst still being controlled by the policies applied from the Management Groups above that the platform team control. This might include adding additional policies at the subscription scope and using alternative tooling for deploying, securing or monitoring workloads that is fully controlled and operated by the workload team.

Whether you're starting on your first production application on Azure or you're operating a complex portfolio of tech platforms and workloads, the Azure landing zone implementation options can be tailored to your needs. See [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz) for further information.

## Azure landing zone conceptual architecture

For many organizations, the Azure landing zone conceptual architecture below represents the destination in their cloud adoption journey. It's a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business while maintaining best practices for security and governance.

This conceptual architecture represents scale and maturity decisions based on a wealth of lessons learned and feedback from customers who have adopted Azure as part of their digital estate.

While your specific implementation might vary, as a result of specific business decisions or existing investments in tools that need to persist in your cloud environment, this conceptual architecture will help set a direction for the overall approach your organization takes to designing and implementing a landing zone.

Use this architecture as a starting point. Download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.vsdx) and modify it to fit your specific business and technical requirements when planning your landing zone implementation.

[![A conceptual architecture diagram of an Azure landing zone.](/azure/cloud-adoption-framework/ready/enterprise-scale/media/ns-arch-cust-expanded.svg)](/azure/cloud-adoption-framework/ready/enterprise-scale/media/ns-arch-cust-expanded.svg#lightbox)
