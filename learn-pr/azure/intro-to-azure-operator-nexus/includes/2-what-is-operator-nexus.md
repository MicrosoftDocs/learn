Azure Operator Nexus is a cutting-edge hybrid cloud platform designed for telecommunication operators, providing carrier-grade next-generation services. Operator Nexus extends Azure management and services to the operator's premises, ensuring seamless integration and optimal performance.

The following video introduces Azure Operator Nexus:

> [!VIDEO 40a5ddc4-b2b9-4d7a-bb6f-d8eb9df81562]

## Why use Operator Nexus?

Azure provides a robust platform for developers to build modern applications. However, cloud-based applications may face challenges such as latency, intermittent connectivity, and regulatory compliance. Operator Nexus allows you to operate secure carrier-grade network functions at scale:

- **Reduced operational complexity and costs:** Operators can manage their Operator Nexus infrastructure and tenants from Azure, streamlining deployment and enabling faster time-to-market for innovative value-added services.

- **Integrated platform for compute, network, and storage:** Operator Nexus provides an end-to-end (E2E) platform from infrastructure to tenant for applications, eliminating the need for separate provisioning of compute, network, and storage. For example, networks associated with the compute infrastructure can be automatically provisioned across the compute and network infrastructure as part of a single workflow.

- **Expanding Network Function (NF) ecosystem:** Operator Nexus supports a wide variety of Microsoft's own NFs and partner NFs via the Operator Nexus Ready program. These NFs are tested for deployment and lifecycle management on Operator Nexus before they're made available in Azure Marketplace.

- **Access to key Azure services:** Since Operator Nexus is connected to Azure, operators can seamlessly access most Azure services through the same connection as the on-premises network. Operators can monitor logs and metrics via Azure Monitor, and analyze telemetry data using Log Analytics or Azure AI/Machine Learning framework.

- **Unified governance and compliance:** Operator Nexus extends Azure management and services to the operator's premises. Operators can unify data governance and enforce security and compliance policies using [Azure Role-based Access Control](https://learn.microsoft.com/azure/role-based-access-control/overview) and [Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview).

Operator Nexus utilizes a subset of IaaS and PaaS services available in the Azure public cloud to manage the lifecycle of infrastructure deployed in a Telco operator's datacenter and workloads hosted on the infrastructure. This Microsoft-curated infrastructure is referred to as the Operator Nexus on-premises infrastructure. By using Azure services, Operator Nexus effectively creates an on-premises private cloud.

## Operator Nexus architecture

The Operator Nexus on-premises infrastructure is made up of workload racks, also known as compute racks. These racks contain 8, 12, or 16 off-the-shelf COTS servers from trusted hardware partners. For a complete configuration of the on-premises infrastructure, refer to the Operator Nexus on-premises infrastructure documentation.

Once the workload racks are delivered to the Telco operator datacenter and IF&E activities (racking and stacking) are completed, Microsoft or a certified Systems Integrator work with the Telco operator to deploy and ensure the Operator Nexus solution is functioning properly. The Telco operator can prepare their datacenter by ensuring all required power and cooling, border connectivity, ExpressRoute, and other necessary datacenter integration requirements are in place.

Operator Nexus is a Kubernetes-based platform that utilizes CNCF compliant Azure Kubernetes and other CNCF services, such as Kubevirt and Multus. Building on these technologies allows Telco operators to benefit from the latest advances in cloud-based containerization and microservices. Kubevirt, a Kubernetes-managed virtualization engine, enables both CNFs and VNFs to be hosted on the same bare metal servers.

Operator Nexus is managed using the same tools that users already use for managing Azure subscriptions. Operators can choose any supported Azure region for each on-premises Operator Nexus instance. The use of Azure tools enables the design, development, deployment, and management of services and applications in hybrid scenarios in a consistent manner, regardless of their location. This consistency minimizes administrative, development, and operational overheads.

The diagram illustrates the component architecture of Operator Nexus.

:::image type="content" source="../media/operator-nexus-architecture.png" alt-text="Screenshot of Operator Nexus system comprising on-premises infrastructure and workload racks that include off-the-shelf COTS servers." border="false":::

## Key design principles

To meet Operators' high-performance network workload needs, the Operator Nexus platform adheres to several key design principles:

- **High Availability:** The platform ensures there's no single point of workload failure.

- **High Capacity and Scalability:** The platform provides uniform Data Plane and Control Plane scale, allowing for scaling of forwarding tables, network segments, and Layer 2 segment extension. It includes virtual device mobility, forwarding path optimization, and virtualized networks. The platform also supports multi-tenant on shared physical infrastructure.

- **Cost and Power Efficiency:** The platform uses off-the-shelf hardware with several power profiles to ensure applicability to all data center power requirements.

- **Simplicity:** The platform uses a Leaf Spine Architecture with EVPN/VXLAN, predictable traffic flow, and high-bandwidth, low-latency, nonblocking server-to-server connectivity.

- **Modularity:** The platform uses the same hardware and rack design for all BOM options. Integrators may preconfigure a rack before shipment to the operator’s location.

- **Flexibility:** The platform allows operators to choose various instance sizes and uplink bandwidth speeds.

- **Non-disruptive Expansion:** The platform allows the introduction of net-new racks without impacting existing racks or recabling, etc.

- **Longevity:** The platform supports a lifespan of five years, during which performance improvements can be made to the virtualized network functions with no change required to the physical deployment.

## What Operator Nexus isn't

While it's important to understand what Operator Nexus is, it's also helpful to realize what it isn't:

- A customizable infrastructure: Operator Nexus relies on preconfigured systems that are in a constant known state. There is no support for custom hardware.

- A solution that eliminates the need for infrastructure and platform software updates: Telco operators must update the Operator Nexus management bundle and run-time bundle regularly.

- A solution that eliminates the responsibility for the underlying infrastructure: In Azure public cloud, Microsoft hosts and manages the Azure cloud physical and virtualization infrastructure. With Operator Nexus, the Telco operator hosts the infrastructure and is responsible for ensuring its resiliency and availability.
