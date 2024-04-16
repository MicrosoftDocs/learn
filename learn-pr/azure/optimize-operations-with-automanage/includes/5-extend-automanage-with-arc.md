> [!CAUTION]
> This content references CentOS, a Linux distribution that is nearing End Of Life (EOL) status. Please consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

The benefits of Azure Automanage can be extended beyond virtual machines hosted on the Azure cloud through Azure Arc. Azure Arc expands support to server-based resources that run outside of Azure. A Windows Server or Linux server that's running in Contoso's on-premises datacenter can be registered with Azure Arc and use many of the capabilities available on Azure, including Azure Automanage. Contoso can also apply these capabilities to any server that's running Windows Server or Linux hosted by another cloud provider.

Arc-enabled servers onboarded with Automanage enjoy the same benefits and services as your other Automanage machines, allowing you a consistent experience for managing servers at scale. Additionally, Azure Arc provides the following configuration management capabilities:

- Assign Azure Policy guest configurations using the same process you use when assigning policies to your Azure VMs.
- Monitor your connected machines' guest operating system performance.
- Use Azure Monitor for VMs to:
  - Discover application components.
  - Monitor these applications' processes and dependencies.
- Support resource-context log access for log data collected and stored in a Log Analytics workspace.
- Simplify deployment with other Azure services. For example, implement Azure Automation State Configuration and Azure Monitor Log Analytics workspace. You can also use the Custom Script Extension to:
  - Perform post-deployment configuration.
  - Software installation.

## Supported operating systems

Automanage supports the following operating systems for Azure Arc-enabled servers:

- Windows Server 2012 R2, 2016, 2019, 2022
- CentOS 7.3+, 8
- RHEL 7.4+, 8
- Ubuntu 16.04, 18.04, 20.04
- SLES 12 (SP3-SP5 only)
