Contoso, a global entity, hosts multiple SQL Server instances with various versions in their on-premises environment. The IT staff wants to explore multicloud strategy, in order to use cloud service providers around the world. Azure Arc-enabled data services provides a single pane of glass and unified tools for management, deployment, and data sovereignty compliance in certain markets.

## What is Azure Arc-enabled data services?

Using Azure Arc-enabled SQL Managed Instance, you can enroll all of your database instances located anywhere to Azure and then manage these databases in a consistent way. Azure Arc-enabled data services:

- Enables you to be on an evergreen SQL instance.
- Provides flexible scaling options. You can easily and quickly add or remove CPU and Memory from instances.
- Takes advantage of cloud billing models.
- Provides a platform as a service (PaaS)-like experience on-premises and across multiple clouds.
- Comes with high availability, monitoring services, automated upgrades, patching, backup and restore services out of the box.

## Understand connected and disconnected modes

Contoso has operational capabilities in countries/regions where data is required to be on-premises due to regulations and low latency needs. Azure Arc-enabled data services can be useful in this situation. Since the data is stored in a specific country/region, regulation compliance and data sovereignty requirements can be met. Underlying latency issues are also resolved by enabling databases locally or in close proximity to operations.

The disconnected mode of deployments doesn't automatically load any data sets back to Azure. For example, billing files, logs, and metrics aren't loaded automatically. Inventory information is only used for billing purposes. With this mode, you can manually export and load the billing file to the Azure portal on a regular basis. Although disconnected mode doesn't automatically load the file, you still get scaling, evergreen SQL, and other benefits from the solution.

In direct connected mode, you get the full benefits of Azure Monitor including alerts, inventory, and management capabilities via the Azure portal. With this mode, deployment data is still processed on-premises and you can optionally upload logs to Azure. The inventory information is only a metadata representation of assets that you have.

## Deploy Arc-enabled data services

The Azure Arc-enabled SQL Managed Instance operates on any supported Kubernetes cluster and hardware. The Kubernetes cluster is connected to Azure Arc, and then Azure Arc-enabled data services is deployed and managed to the cluster via an agent-based solution. The agent that's deployed to the environment is called the data controller. This agent acts as the Kubernetes orchestrator for the solution.

To run the services in direct connected mode, you must:

- Have access to a Kubernetes cluster that is sized appropriately for your workload.
- Use a supported Azure CLI version.
- Add the `arcdata` and associated `k8s` CLI extensions.
