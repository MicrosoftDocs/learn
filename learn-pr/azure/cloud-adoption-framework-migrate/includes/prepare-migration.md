## Prepare your landing zone for migration

Before you plan individual workload migrations, you must ready your organization and cloud resources to support the migration. Regardless of which Azure landing zone reference implementation you used, you must perform some tasks to prepare your landing zone for a successful migration project.

- **Establish hybrid connectivity**. During an Azure landing zone deployment, you can deploy a Connectivity subscription with a hub virtual network and network gateways, such as Azure VPN gateways, Azure ExpressRoute gateways, or both. After your Azure landing zone deployment, you must still configure hybrid connectivity from these gateways to connect to your existing datacenter appliances or your ExpressRoute circuit.

- **Prepare identity**. During your Azure landing zone deployment, you should deploy a supporting architecture for your identity platform. And you must deploy the identity resources after the Azure landing zone deployment.

- **Extend Active Directory domain controllers**. You must deploy domain controllers to Azure inside the identity network area that you deployed. 

- **Enable hybrid DNS**. To resolve Domain Name System (DNS) requests for namespaces that are a part of existing environments and ensure that resources in the existing environment can resolve resources in Azure, you need to configure DNS services to support common flows. You can use Azure landing zones to deploy many of the resources you need.

- **Custom DNS resolution**. If you use Active Directory for your DNS resolver or if you deploy a non-Microsoft solution, you must deploy VMs. You can use these VMs as your DNS servers if you deploy your domain controllers to your Identity subscription and network spoke. Otherwise, you must deploy and configure the VMs to house these services.

  After you deploy the VMs, you must integrate them into your existing DNS platform so they can perform lookups against your existing namespaces. For Active Directory DNS servers, this integration is automatic. If your design uses private DNS zones or if you use private endpoints to perform modernization efforts, you must plan accordingly.

- **Configure an Azure Firewall DNS proxy**. You can configure Azure Firewall as a DNS proxy to receive traffic and forward it to an Azure resolver or your DNS servers. Use this configuration to perform lookups from on-premises to Azure. You can also configure the DNS servers for your Azure virtual networks to the custom servers that you use.

- **Configure the hub firewall**. An Azure firewall blocks traffic until you add explicit allow rules. You should apply standard rules to all enabled workloads and also apply individual rules and rule collections based on workload needs. 

- **Establish routing**. Azure provides routing between resources:

  - In the same virtual network.
  - In peered virtual networks.
  - And a virtual network gateway, either in its own virtual network or in a peered virtual network that's configured to use the gateway.

  You don't need any extra configuration for the preceding routing. Or you can use [another routing scenario](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) that needs extra configuration. 

  Configure inter-spoke routing so that traffic to any unknown location goes to the firewall, which inspects the traffic and applies your firewall rules.

- **Enable subscription vending**. Automate and accelerate the process of creating new subscriptions.

- **Set policies to enable Defender for Cloud**. When you deploy your landing zone, you also set policies to enable Defender for Cloud for your Azure subscriptions. Defender for Cloud provides security posture recommendations in its secure score, which evaluates deployed resources against the Microsoft security baseline.

## Prepare tools and the initial migration backlog

To successfully complete your migration, you need specific tools to assess, replicate, and track your workloads through iterations, including remediation activities.

|Tool type|Functionality|Tool|
|---|---|---|
|Discovery and assessment|Performs automated discovery and assessments of your environment. Identifies blockers for migration and identifies dependencies between servers.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Replication|Replicates data state between your on-premises source and a cloud staging environment. Used to hydrate and migrate the resources.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Tracking|Used to organize project activities, such as to group servers into workloads, track remediation activities, and provide the status of a workload migration.|[Azure DevOps](/azure/devops/user-guide/what-is-azure-devops), Excel, and Microsoft Project|
|Migration guide|Helps you identify which migration feature to use for Azure Migrate. The Migration Execution Guide is a project resource that can guide you step by step through the decisions and the implementation of your migration.|[Migration Execution Guide](https://github.com/Azure/migration/)|

You should create a backlog that includes:

- Business outcomes and metrics.

- Business priorities.
- Core assumptions.

Ensure that all teams are familiar with the backlog, and store it in a shared location. Maintain the backlog so that you can use it throughout the migration process. You can also create epics in your project management tool to track work for multiple datacenters.

## Align roles and responsibilities

The Cloud Adoption Framework underscores the role of organizational alignment in migration and advocates for cross-departmental collaboration to fulfill key functions.

The following table describes the [cloud strategy function](/azure/cloud-adoption-framework/organize/cloud-strategy) roles and their responsibilities:

| Role | Responsibilities |  
| --- | --- |
| Project Sponsor | Defines the scope of the migration to determine what resources are moved and the benefit of moving each resource. Provides decision-making ownership for migration tooling purchases, for the overall workload architecture, and for release activities. |
| Project Manager | Drives a project plan for the migration scope. Drives testing processes. Organizes status updates to stakeholders. |
| Organizational Change Manager | Helps the project team communicate changes to the organization. Works with different functions to make sure that the right team members are involved and that the correct organizational changes occur to support the migration. |
| Licensing Specialist | Provides licensing insight and financial operations management to ensure that the project is properly licensed and uses existing licensed resources. |
| Workload Business Owner | Provides decision-making ownership for the workload assessment, architecture, and migration processes. Acts as an owner for the business value of the workload in Azure. |

During your migration to Azure, the following roles in the [cloud adoption function](/azure/cloud-adoption-framework/organize/cloud-adoption) perform most of the technical execution.

| Role | Responsibilities |
| --- | --- |
| Migration Architect | Oversees the technical decision making for the workloads, such as migration wave planning and all migration processes. |
| Migration Engineer | Executes tasks that are identified as part of the project. |

The next table describes supporting roles that you might need for other functions:

| Role | Responsibilities |
| --- | --- |
| Landing Zone Architect | Provides support for migrating workloads to a landing zone. Helps remediate any issues with platform services in the landing zone. For more information, see [Cloud platform functions](/azure/cloud-adoption-framework/organize/cloud-platform). |
| Cloud Operations Manager | Provides support for onboarding migrating workloads to the management platform to ensure that proper management is in place for the workloads when they migrate. For more information, see [Cloud operations functions](/azure/cloud-adoption-framework/organize/cloud-operations). |
| Workload Architect | Provides architectural guidance and decision making for the design of the migrating workload. For each workload, you might need a specific subject matter expert to fulfill multiple instances of this role. For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |
| User Acceptance Tester | Tests individual workloads. You might have multiple instances of this role per workload to provide feedback for user acceptance testing (UAT). For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |

Depending on the size and number of workloads that you migrate, you might need to have multiple team members assigned to each role. If you find that you need to scale out, you should also plan for a Program Manager or a Migration Architecture Lead. Use a [responsibility matrix](/azure/cloud-adoption-framework/migrate/prepare/roles-responsibilities#responsibility-matrix-example) to clarify and organize your roles.