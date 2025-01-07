Deployment via the Azure portal:

The Azure portal offers an intuitive interface for performing most common administrative tasks manually.

Azure Center for SAP services (ACSS) makes SAP a top-level workload on Azure. Azure Center for SAP solutions is an end-to-end solution that enables you to deploy and manage SAP systems as a unified workload. ACSS supports manual Azure portal, tasks for deployment of new Azure-based SAP systems.

## Deployment via Microsoft Azure PowerShell cmdlets

PowerShell is a powerful and extensible framework that has been widely adopted by customers that deploy larger numbers of systems in Azure. It's a common choice of administrators with Windows background, although with the release of PowerShell 6.0, it became possible to run it also on Linux and macOS.

## Deployment via Microsoft Azure CLI commands

For administrators with Linux background, it might be more convenient to use Azure CLI as an alternative to PowerShell. The Azure CLI integrates closely with Bash shell.

Deployment of the Azure Monitoring Extension for SAP is available via PowerShell or CLI. This is a mandatory step when deploying or administering an SAP NetWeaver system in Azure.

## Deployment via Terraform

Hashicorp Terraform is an open-source tool for provisioning and managing cloud infrastructure. It codifies infrastructure in configuration files that describe the topology of cloud resources, such as virtual machines, storage accounts, and networking interfaces. Terraform's command-line interface (CLI) provides a simple mechanism to deploy and version the configuration files to Azure or any other supported cloud.

Terraform is a popular tool choice for multicloud scenarios, where similar infrastructure is deployed to Azure and other cloud providers or on-premises datacenters. It enables developers to use the same tools and configuration files to manage infrastructure on multiple cloud providers.

The GitHub repository [SAP on Azure Deployment Automation Framework](https://github.com/Azure/sap-automation) contains a set of highly customizable templates that can be used to automatically deploy complex SAP landscapes in the Azure Cloud. 

The templates are split into:

- Terraform modules, which deploy the infrastructure components (such as VMs, network, storage) in Azure and then call the Ansible playbooks.
- Ansible playbooks that run different roles to install and configure SAP HANA and required applications on the already deployed infrastructure.

The supported scenarios include the full deployment of:

- HANA single-node instance.
- HANA high-availability pair, consisting of:

  - Single-node HANA instance, two-tier HSR (primary/secondary).
  - Pacemaker high-availability cluster, fully configured with SBD and SAP/Azure resource agents.
