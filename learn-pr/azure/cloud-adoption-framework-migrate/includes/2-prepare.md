Before you plan individual workload migrations, you must ready your organization and cloud resources to support the migration.

:::image type="content" source="../media/migrate-prepare.svg" alt-text="Diagram that shows the steps of the Migrate methodology." border="false":::

Regardless of which Azure landing zone reference implementation you use, you must perform some tasks to prepare your landing zone for a successful migration project.

- **Establish hybrid connectivity**. During an Azure landing zone deployment, you can deploy a Connectivity subscription with a hub virtual network and network gateways. After you deploy your Azure landing zone, [configure hybrid connectivity](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#establish-hybrid-connectivity) from these gateways to connect to your existing datacenter appliances or your ExpressRoute circuit.

- **Prepare identity**. During your Azure landing zone deployment, you should also deploy a supporting architecture for your [identity platform](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#prepare-identity). After you deploy your Azure landing zone, you must deploy the identity resources.

- **Extend Active Directory domain controllers**. To support your replication topology, you might need to [deploy extra domain controllers](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#extend-active-directory-domain-controllers) to Azure inside the identity network area that you deployed.

- **Enable hybrid DNS**. [Configure DNS services](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#enable-hybrid-dns) so you can resolve Domain Name System (DNS) requests for namespaces that are a part of existing environments and ensure that resources in the existing environment can resolve resources in Azure.

- **Custom DNS resolution**. If you use Active Directory for your DNS resolver or if you deploy a partner solution, you must deploy VMs. You can [use these VMs as your DNS servers](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#custom-dns-resolution) if you deploy your domain controllers to your Identity subscription and network spoke. Otherwise, you must deploy and configure the VMs to house these services.

  After you deploy the VMs, you must integrate them into your existing DNS platform so they can perform lookups against your existing namespaces.

- **Configure an Azure Firewall DNS proxy**. You can [configure Azure Firewall as a DNS proxy](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#azure-firewall-dns-proxy) to receive traffic and forward it to an Azure resolver or your DNS servers. Use this configuration to perform lookups from on-premises to Azure.

- **Configure the hub firewall**. An Azure firewall blocks traffic until you add explicit allow rules. Apply standard rules to all enabled workloads and also apply individual rules and rule collections based on workload needs. 

- **Establish routing**. Azure provides [routing](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#routing) between resources that doesn't require you to implement extra configuration. Or you can use [other routing scenarios](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) that need extra configuration.

  Configure [inter-spoke routing](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#inter-spoke-routing) so that traffic to any unknown location goes to the firewall, which inspects the traffic and applies your firewall rules. If you use virtual networks for your hub, you also need to plan how to handle the inspection of [traffic that comes from your gateways](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#routing-from-the-gateway-subnet).

- **Enable subscription vending**. Automate and accelerate the process of [creating new subscriptions](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#enable-subscription-vending).

- **Set policies to enable Microsoft Defender for Cloud**. When you deploy your landing zone, you must set policies to [enable Defender for Cloud](/azure/cloud-adoption-framework/migrate/prepare/ready-azure-landing-zone#prepare-for-microsoft-defender-for-cloud) for your Azure subscriptions. Defender for Cloud provides security posture recommendations in its [secure score](/azure/defender-for-cloud/secure-score-security-controls), which evaluates deployed resources against the Microsoft security baseline.

## Prepare tools and an initial migration backlog

To successfully complete your migration, you need [tools](/azure/cloud-adoption-framework/migrate/prepare/tools-backlog#prepare-migration-tools) to assess, replicate, and track your workloads through iterations, including remediation activities.

To perform discovery and assessment and replication tasks, you can use [Azure Migrate](/azure/migrate/migrate-services-overview). To organize project activities, you can use [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops), Excel, and [Microsoft Project](https://www.microsoft.com/microsoft-365/project/project-management-software). You can also use the [Migration Execution Guide](https://github.com/Azure/migration/) to get guidance about the migration process.

You should also create a [backlog](/azure/cloud-adoption-framework/migrate/prepare/tools-backlog#initial-migration-backlog) that includes:

- Business outcomes and metrics.
- Business priorities.
- Core assumptions.

Ensure that all teams are familiar with the backlog, and [store it in a shared location](/azure/cloud-adoption-framework/migrate/prepare/tools-backlog#capture-the-backlog). Maintain the backlog so that you can use it throughout the migration process. You can also create epics in your project management tool to [track work for multiple datacenters](/azure/cloud-adoption-framework/migrate/prepare/tools-backlog#plan-the-backlog-for-multiple-datacenters).

### Azure Migrate

[Azure Migrate](/azure/migrate/migrate-services-overview) provides a unified migration platform: a single portal to start, run, and track your migration to Azure. In the Azure Migrate hub, you can assess and migrate:

- **Servers, databases, and web apps**: Assess on-premises servers, including web apps and SQL Server instances, and migrate them to Azure.

- **Databases**: Assess on-premises SQL Server instances and databases to migrate them to a SQL Server on an Azure virtual machine or an Azure SQL Managed Instance or to an Azure SQL database.
- **Web applications**: Assess on-premises web applications and migrate them to Azure App Service and Azure Kubernetes Service (AKS).
- **Virtual desktops**: Assess your on-premises virtual desktop infrastructure (VDI) and migrate it to Azure Virtual Desktop.
- **Data**: Use Azure Data Box products to migrate large amounts of data to Azure quickly and economically.

## Align roles and responsibilities

The Cloud Adoption Framework underscores the role of organizational alignment in migration and advocates for cross-departmental collaboration to fulfill key functions.

The following table describes the [cloud strategy function](/azure/cloud-adoption-framework/organize/cloud-strategy) roles and their responsibilities.

| Role | Responsibilities |  
| --- | --- |
| Project Sponsor | Defines the scope of the migration to determine what resources are moved and the benefit of moving each resource. Provides decision-making ownership for migration tooling purchases, for the overall workload architecture, and for release activities. |
| Project Manager | Drives a project plan for the migration scope. Drives testing processes. Organizes status updates to stakeholders. |
| Organizational Change Manager | Helps the project team communicate changes to the organization. Works with different functions to make sure that the right team members are involved and that the correct organizational changes occur to support the migration. |
| Licensing Specialist | Provides licensing insight and financial operations management to ensure that the project is properly licensed and uses existing licensed resources. |
| Workload Business Owner | Provides decision-making ownership for the workload assessment, architecture, and migration processes. Acts as an owner for the business value of the workload in Azure. |

During your migration to Azure, the following roles in the [cloud adoption function](/azure/cloud-adoption-framework/organize/cloud-adoption) perform most of the technical tasks.

| Role | Responsibilities |
| --- | --- |
| Migration Architect | Oversees the technical decision making for the workloads, such as migration wave planning and all migration processes. |
| Migration Engineer | Executes tasks that are identified as part of the project. |

The next table describes supporting roles that you might need for other functions.

| Role | Responsibilities |
| --- | --- |
| Landing Zone Architect | Provides support for migrating workloads to a landing zone. Helps remediate any issues with platform services in the landing zone. For more information, see [Cloud platform functions](/azure/cloud-adoption-framework/organize/cloud-platform). |
| Cloud Operations Manager | Provides support for onboarding migrating workloads to the management platform to ensure that proper management is in place for the workloads when they migrate. For more information, see [Cloud operations functions](/azure/cloud-adoption-framework/organize/cloud-operations). |
| Workload Architect | Provides architectural guidance and decision making for the design of the migrating workload. For each workload, you might need a specific subject matter expert to fulfill multiple instances of this role. For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |
| User Acceptance Tester | Tests individual workloads. You might have multiple instances of this role per workload to provide feedback for user acceptance testing (UAT). For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |

Depending on the size and number of workloads that you migrate, you might need to have multiple team members assigned to each role. If you find that you need to scale out, you should also plan for a Program Manager or a Migration Architecture Lead. Use a [responsibility matrix](/azure/cloud-adoption-framework/migrate/prepare/roles-responsibilities#responsibility-matrix-example) to clarify and organize your roles.