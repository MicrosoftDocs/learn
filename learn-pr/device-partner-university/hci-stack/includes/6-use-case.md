Imagine you’re working for a mid-sized manufacturing company aiming to modernize its infrastructure. The goal is to centralize operations, run virtualized workloads close to the factory floor, ensure high availability, and maintain control over sensitive data—all while integrating with cloud services when needed.

Your organization wants to:

- Improve operational efficiency
- Run legacy and modern workloads side-by-side
- Enable hybrid cloud capabilities
- Ensure security and compliance
- Operate reliably in areas with limited internet connectivity

![A photograph of two people using a tablet in a workshop surrounded by tools and equipment.](../media/factory.png)

## Why Azure Local is a good fit

Azure Local is purpose-built for hybrid environments, offering the flexibility of Azure with the control of on-premises infrastructure. Here's how it supports this manufacturing scenario:

- **On-premises virtualization**: Run Windows and Linux VMs directly on local hardware using Hyper-V. This is ideal for hosting legacy applications or real-time monitoring tools without needing full cloud migration.

- **Disconnected operations**: Manufacturing plants in remote areas often face unreliable internet. Azure Local excels in disconnected environments, allowing workloads to run locally while syncing with Azure when connectivity is available.

- **Security and compliance**: Integrate with Azure Arc to enforce cloud policies and use Defender for endpoint protection—even on local servers.

- **Centralized management**: IT admins can manage clusters using Windows Admin Center or the Azure Portal. This simplifies updates, monitoring, and configuration across multiple sites.

- **Application flexibility**: Supports a mix of workloads—from legacy Windows Server apps to containerized microservices using Azure Kubernetes Service on-premises. This allows gradual modernization without disrupting operations.

- **Predictive maintenance & analytics**: Connect to Azure Monitor and Azure Site Recovery for insights, backup, and disaster recovery. You get cloud-grade intelligence while keeping compute local.

- **Cost-efficient licensing**: Pay monthly via Azure subscription rather than upfront hardware costs. This aligns with operational budgets and scales with demand.

## Why Azure Local might not be a good fit

While Azure Local is powerful, it’s not a one-size-fits-all solution. Consider these limitations:

- **Hardware investment**: Requires certified hardware and might involve upfront infrastructure upgrades. Smaller facilities with minimal IT budgets might find this challenging.

- **Cloud dependency for full features**: Some Azure integrations require periodic cloud connectivity. Some isolated environments might not benefit from these features.

- **Complexity for small teams**: Managing clusters, integrating Azure Arc, and configuring hybrid services might be complex for teams without dedicated IT staff.

- **Not real-time focused**: While Azure Local supports many workloads, it’s not designed for hard real-time systems. Manufacturing processes requiring deterministic timing might need specialized solutions.