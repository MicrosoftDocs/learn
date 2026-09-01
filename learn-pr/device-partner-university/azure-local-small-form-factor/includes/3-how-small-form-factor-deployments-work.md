Small form factor deployments of Azure Local (preview) use a lightweight architecture that doesn't rely on virtualization. Instead, it runs on bare metal to bring Azure-managed infrastructure to compact hardware while preserving a consistent cloud management model.

This diagram shows a streamlined version of where and how small form factor deployments fit into the scenario environment. It starts with physical systems that feed into small form factor deployments, which in turn coordinate with Azure Cloud.

:::image type="content" border="true" source="../media/system.svg" lightbox="../media/system.svg" alt-text="Illustration of the path of data from physical systems like sensors to Azure Local small form factor (preview) and Azure cloud.":::

The solution is made up of several components that work together to enable both local processing and centralized control.

## Lightweight infrastructure on local hardware

These small form factor deployments are designed to run on compact, edge-ready machines. This enables deployment in environments where space, power, or layout constraints make traditional infrastructure impractical.

In Contoso's factories, this allows systems to be installed near production lines, inspection stations, or control systems rather than a dedicated server room.

## Cloud-based provisioning and management

Deployments are provisioned and managed through Azure. This allows organizations to treat edge infrastructure as part of a broader cloud-managed environment. While these systems can continue processing data locally during connectivity interruptions, Azure connectivity is still required for centralized management, updates, and long-term monitoring.

Contoso's deployments enable:

- Consistent configuration of systems across multiple factories
- Centrally applied updates and policies
- Infrastructure health monitoring from a single location

## Container-based workload support

Small form factor deployments of Azure Local (preview) support running containerized workloads locally using runtime tools such as Docker, open source k3s, and fully managed Azure Kubernetes Service. This provides flexibility and portability for applications.

For example, Contoso can deploy:

- Applications that analyze sensor data
- Services that process camera images
- Workflows that respond to operational events

Because workloads are containerized, they can be deployed consistently across all factories regardless of hardware variations.

## Local processing close to physical systems

Running workloads locally reduces the need to send data to centralized systems for immediate processing. This separation of responsibilities allows real-time operations to continue locally, while Azure remains responsible for centralized visibility and coordination.

For Contoso, this ensures that production-line data can be processed in real time—even if connectivity to the cloud is temporarily unavailable.

## How data flows through the system

To better understand how these components work together, consider the flow of data in Contoso's manufacturing environment:

- Sensors and cameras generate data on the production line
- Data is sent to local workloads running on small form factor hardware
- Applications analyze the data in real time
- If an issue is detected, a local response is triggered immediately
- Long-term data and insights can optionally be sent to the cloud for reporting and analysis

This flow allows Contoso to combine real-time responsiveness with centralized visibility.

## How the components work together

In practice, these small form factor deployments create a unified model that combines local execution with cloud management.

In the Contoso scenario:

- Compact hardware is deployed at each factory
- Local workloads process data from production systems
- Azure supports centralized governance and monitoring
- Systems across all factories follow the same deployment and management model

For example, if a camera detects a defect on a production line:

- The image is analyzed locally
- A defect is identified in real time
- An alert is triggered immediately
- Operators can take corrective action without delay

At the same time, this event can be logged and analyzed centrally to improve long-term quality processes. This flowchart shows how the responsibilities are divided between Azure Local and the cloud to enable both quick reactions and detailed, centralized analytics.

:::image type="content" border="true" source="../media/dataflow.svg" lightbox="../media/dataflow.svg" alt-text="Illustration of dataflow starting at sensors and cameras on a factory floor through cloud-hosted reporting and analytics.":::

This combination allows organizations to extend cloud practices to physical environments—bringing intelligence and automation closer to where work happens.
