Azure Stack HCI provides a deep integration with Azure and leverages Azure Arc to deliver new capabilities to Azure Stack HCI administrators. This also facilitates implementing many Azure hybrid services, including Azure Monitor, Azure Backup, and Azure Site Recovery. These services could help Contoso streamline its operations and minimize administrative overhead.

## What are the key benefits of Azure Arc?

With Azure Stack HCI clusters, the Azure Arc agent is included as part of the cluster nodes' operating system, so you don't need to install it. You activate it by registering your Azure Stack HCI cluster with Azure Arc, which automatically enables Azure-based monitoring, support, and billing.

Additionally, Azure Arc enables you to leverage Azure Resource Manager functionality to manage and maintain Azure Stack HCI clusters, including to:

- Classify all organizational resources by using Azure management groups, subscriptions, resource groups, and tags.
- Devise a single, comprehensive inventory of organizational assets across multiclouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- Provide a consolidated display of Azure and Azure Arc-enabled resources by using the Azure portal, Azure CLI, Azure PowerShell, and Azure REST API.

There are also workload-specific benefits applicable to VMs and Azure Kubernetes Services (AKS) running on Azure Stack HCI, but they're also available for servers and Kubernetes clusters that run on any platform.

## How does Azure Stack HCI benefit from integration with Azure hybrid services?

Azure Stack HCI integrates with several Azure services, including Azure Monitor, Azure Backup, and Azure Site Recovery, thereby leveraging these services' critical functionality.

To implement this integration, you need to install one or more agents onto on-premises physical or virtual servers. Azure Monitor, Azure Update Management, and Microsoft Defender for Cloud require installation of the Log Analytics agent. The Log Analytics agent manages a collection of Windows Event Logs, Windows performance counters, file-based logs that you explicitly specify, and metrics and logs associated with Azure Monitor or Azure Automation monitoring and management solutions that you decide to enable. In certain scenarios, you might have to install the Dependency agent, which identifies dependencies of processes hosted on managed servers and collects corresponding network-related metrics. Data that the Log Analytics and the Dependency agents collect is automatically uploaded to the Log Analytics workspace that you designate. A workspace is the administrative and security boundary of the Log Analytics environment, and it defines the scope of data collection, analysis, and presentation.

Azure Backup and Azure Site Recovery rely on Microsoft Azure Recovery Services (MARS) agent that manages communication and data replication with Azure Recovery Services Vault providing cloud-based protection. Azure File Sync agent provides similar functionality for Azure File Sync.

> [!NOTE]
> Windows Admin Center simplifies installation of the Log Analytics agent on Azure Stack HCI clusters.

### Integrating Azure Stack HCI with Azure Monitor

Microsoft Azure Monitor is a core component of the Microsoft strategy to extend comprehensive cloud-based monitoring functionality beyond Azure to on-premises datacenters. Customers using Azure Stack HCI can benefit from this functionality for tracking, auditing, or troubleshooting past events, maintaining existing workloads, and forecasting and planning capacity for future deployments.

Azure Monitor provides three main capabilities:

- **Metric-based monitoring**: Metrics are numerical values that represent the health status of monitored systems.
- **Querying and analyzing logs**: Logs include activity, diagnostics, and system-generated data.
- **Alerting and remediation**: Alerts notify you of anomalous conditions, allowing you to configure automatically triggered corrective actions.

Additionally, Azure Monitor allows you to archive collected data for long-term analysis or compliance purposes in Azure Storage or route it to Azure Stream Analytics or non-Microsoft services by using Event Hub. You can use alerts to trigger notifications via SMS or email, trigger a remediation action implemented by an Azure logic app, Azure functions, or Azure Automation Runbook. You also can raise an incident and work item response by leveraging integration between Azure Monitor and your internal Information Technology Service Management (ITSM) platform. If there are Azure Stack HCI clusters, Azure Monitor includes Health Service data, which improves the day-to-day monitoring and operational experience for clusters running Azure Stack HCI.

### Integrating Azure Stack HCI with Azure Backup

Azure Backup implements backup of cloud-based and on-premises workloads, including short-term and long-term backup storage. For on-premises scenarios, its functionality often minimizes or even eliminates the need for maintaining physical backup media. In the context of Azure Stack HCI, Azure Backup offers the following backup options:

- Local file, folder, and system state backups performed by using Azure Backup on a Windows Server and stored in Azure by taking advantage of locally installed Recovery Services Agent.
- Long-term storage of backups of Windows servers performed by using Microsoft Azure Backup Server with Recovery Services Agent installed on the Microsoft Azure Backup Server.
- Long-term storage of backups of Windows servers performed by using System Center Data Protection Manager (DPM) with Recovery Services Agent installed on the DPM server.

You can take advantage of the Azure Backup integration with Azure Stack HCI to offload SQL Server backups to cloud-based long-term storage hosted by Azure Recovery Services Vault, eliminating the need for alternative backups. Azure Backup Server and System Center DPM fully support SQL Server protection.

### Integrating Azure Stack HCI with Azure Site Recovery

Azure Site Recovery is a cloud-based disaster recovery service that protects on-premises and cloud workloads by relying on replication and orchestration. Replication synchronizes the content of operating systems and data disks between physical or virtual machines that reside in a primary site that's hosting a production environment and VMs in a secondary disaster-recovery site. Orchestration enables orderly failover and failback between these two locations.

In an Azure Stack HCI deployment, Azure Site Recovery provides support for the following disaster recovery scenarios:

- Disaster recovery of Hyper-V VMs not managed by System Center Virtual Machine Manager (SCVMM) from an Azure Stack HCI cluster to Azure with Site Recovery-based replication
- Disaster recovery of Hyper-V VMs managed by SCVMM from an Azure Stack HCI cluster to Azure with Site Recovery-based replication
- Disaster recovery of Hyper-V VMs managed by SCVMM between two Azure Stack HCI clusters by using Hyper-V Replica-based replication
