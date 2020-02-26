Azure Marketplace provides access and information on solutions and services available from Microsoft and our partners. Users can discover, try, or buy cloud software solutions built on or for Azure. The catalog provides Azure building blocks, such as Virtual Machines (VMs), APIs, Azure apps, Solution Templates and managed applications, SaaS apps, containers, and consulting services.

After you deployed a VM in Azure, you follow the same guidelines and tools to install the SAP software and/or DBMS inside your VM as you would do in an on-premises environment. The installation can be performed manually or in an automated manner, by using configuration management tools, such as PowerShell DSC, Custom Script, Ansible, Puppet, or Chef (most of which are available in the form of Azure VM Extensions).

## Custom images

This approach involves deploying VMs based on customer-specific images, which can be used in cases where Azure Marketplace images might not fit your needs. The process of preparing custom images is operating system specific. For details, refer to: 

* Windows: [https://docs.microsoft.com/azure/virtual-machines/windows/upload-generalized-managed](https://docs.microsoft.com/azure/virtual-machines/windows/upload-generalized-managed) 

* Linux: 

    * **SUSE**: [https://docs.microsoft.com/azure/virtual-machines/linux/suse-create-upload-vhd](https://docs.microsoft.com/azure/virtual-machines/linux/suse-create-upload-vhd)

    * **Red Hat**: [https://docs.microsoft.com/azure/virtual-machines/linux/redhat-create-upload-vhd](https://docs.microsoft.com/azure/virtual-machines/linux/redhat-create-upload-vhd) 

    * **Oracle Linux**: [https://docs.microsoft.com/azure/virtual-machines/linux/oracle-create-upload-vhd](https://docs.microsoft.com/azure/virtual-machines/linux/oracle-create-upload-vhd) 

If you have already installed SAP content in your on-premises VM (especially for 2-Tier systems), you can adapt the SAP system settings after the deployment of the Azure VM through the instance rename procedure supported by the SAP Software Provisioning Manager (SAP Note 1619720).

> [!NOTE]
> In this case, you also have the option of installing and configuring SAP workloads manually or in an automated manner, using the same configuration management tools listed earlier. 

## Deployment using the Azure portal

The Azure portal offers intuitive interface for performing most common administrative tasks. Its primary advantage is simplicity, although its usage precludes (to a large extent) the use of automation. 

## Deployment using Microsoft Azure PowerShell cmdlets

PowerShell is a powerful and extensible framework that has been widely adopted by customers deploying larger numbers of systems in Azure. It is a common choice for administrators with Windows background, although with release of PowerShell 6.0, it became possible to run it also on Linux and iOS.

## Deployment using Microsoft Azure CLI commands

For administrators with Linux background, it might be more convenient to use Azure CLI as an alternative to PowerShell. The Azure CLI integrates closely with Bash shell.

Deployment of the Azure Monitoring Extension for SAP is available using PowerShell or CLI and is a mandatory step when deploying or administering an SAP NetWeaver system in Azure.

## Deployment using Azure Resource Management templates

You can automate deployment of SAP solutions by creating your own Azure Resource Manager templates, or by leveraging a large collection of azure-quickstart-templates in a GitHub repository at [https://github.com/Azure/azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates) . The templates include:

* **SAP NetWeaver 2-tier compatible template using a Marketplace image:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 2-tier configuration. It deploys one server on either Standard or Premium Storage.

* **SAP NetWeaver 2-tier compatible template using a custom-managed disk:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using a specialized that is, not generalized OS disk. This is a template for a 2-tier configuration. It deploys one server on Premium Storage. This template uses Managed Disks.

* **SAP NetWeaver 2-tier compatible template using a Managed Disk image:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using a private Managed Disk image. This is a template for a 2-tier configuration. It deploys one server on either Standard or Premium Storage.

* **SAP NetWeaver 3-tier compatible converged template using a Marketplace image:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 3-tier configuration. It deploys 1 (no HA) or 2 (HA) DB/ASCS/SCS servers and several virtual machines that can host dialog instances. For an HA deployment, the DB/ASCS/SCS and DI servers are placed in Availability Sets and a Load Balancer is added to the DB/ASCS/SCS server to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks. 

* **SAP NetWeaver 3-tier compatible template using a Marketplace image:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 3-tier configuration. It deploys 1 (no HA) or 2 (HA) ASCS/SCS servers, 1 (no HA) or 2 (HA) database servers and several virtual machines that can host dialog instances. For an HA deployment, the ASCS/SCS and DB servers are placed in Availability Sets and a Standard Load Balancer is added to the ASCS/SCS and DB server to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks.

* **SAP NetWeaver 3-tier multi SID AS (managed disks):** This template is one of three templates for a 3-tier Multi SID SAP deployment. It takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 3-tier Multi SID configuration. It deploys multiple application servers for one SAP system. The application servers are placed in an Availability Set. This template uses Managed Disks.

* **SAP NetWeaver 3-tier multi SID DB (managed disks):** This template is one of three templates for a 3-tier Multi SID SAP deployment. It takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 3-tier Multi SID configuration. It deploys 1 (no HA) or 2 (HA) database servers for one SAP system. For an HA deployment, the database servers are placed in an Availability Set and a Load Balancer is added to the database servers to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks.

* **SAP NetWeaver 3-tier multi SID (A)SCS (managed disks):** This template is one of three templates for a 3-tier Multi SID SAP deployment. It takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using the latest patched version of the selected operating system. This is a template for a 3-tier Multi SID configuration. It deploys 1 (no HA) or 2 (HA) ASCS/SCS servers on which multiple ASCS/SCS instances for multiple SAP systems can be deployed. For an HA deployment, the ASCS/SCS servers are placed in an Availability Set and a Load Balancer is added to the ASCS/SCS servers to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks.

* **SAP NetWeaver 3-tier converged (managed image):** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using a private OS image. This is a template for a 3-tier configuration. It deploys 1 (no HA) or 2 (HA) DB/ASCS/SCS servers and several virtual machines that can host dialog instances. For an HA deployment, the DB/ASCS/SCS and DI servers are placed in Availability Sets and a Load Balancer is added to the DB/ASCS/SCS server to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks. 

* **SAP NetWeaver 3-tier compatible template using a custom image:** This template takes a minimum number of parameters and deploys a VM that is customized for use with SAP NetWeaver, using a private OS image. This is a template for a 3-tier configuration. It deploys 1 (no HA) or 2 (HA) ASCS/SCS servers, 1 (no HA) or 2 (HA) database servers and several virtual machines that can host dialog instances. For an HA deployment, the ASCS/SCS and DB servers are placed in Availability Sets and a Load Balancer is added to the ASCS/SCS and DB server to allow HA configurations in the operating system (For example, Windows Failover Cluster). This template uses Managed Disks.

* **SAP NetWeaver file server using a Marketplace image:** This template takes a minimum number of parameters and deploys an NFS on SLES, GlusterFS on RHEL or Windows Server 2016 Storage Spaces Direct Scale out File Server that is customized for use with SAP NetWeaver, using the latest version of the selected operating system. It deploys 2 (3 for GlusterFS) virtual machines in an Availability Sets and a Load Balancer is added to allow HA configurations in the operating system (For example, Windows Failover Cluster) if necessary.

* **SAP LaMa template for SAP NetWeaver application server:** This template deploys a virtual machine and installs the required applications to use this virtual machine for SAP LaMa (Landscape Management). The template also creates the required disk layout. 

* **SAP LaMa template for SAP NetWeaver ASCS:** This template deploys a virtual machine and installs the required applications to use this virtual machine for SAP LaMa. The template also creates the required disk layout. For more information about managing Azure virtual machines with SAP LaMa, see SAP LaMa connector for Azure

* **SAP LaMa template for SAP NetWeaver database server:** This template deploys a virtual machine and installs the required applications to use this virtual machine for SAP LaMa. The template also creates the required disk layout. 

## Deployment using Terraform

Hashicorp Terraform is an open-source tool for provisioning and managing cloud infrastructure. It codifies infrastructure in configuration files that describe the topology of cloud resources, such as virtual machines, storage accounts, and networking interfaces. Terraform's command-line interface (CLI) provides a simple mechanism to both deploy and version the configuration files to Azure or any other supported cloud.

Terraform is a popular tool choice for multi-cloud scenarios, where similar infrastructure is deployed to Azure and additional cloud providers or on-premises datacenters. It enables developers to use the same tools and configuration files to manage infrastructure on multiple cloud providers.

The GitHub repository entitled Automated SAP Deployments in Azure Cloud contain a set of highly customizable templates that can be used to automatically deploy complex SAP landscapes in the Azure Cloud. The templates are split into:

* Terraform modules, which deploy the infrastructure components (such as VMs, network, storage) in Azure and then call the:

* Ansible playbooks, which run different roles to install and configure SAP HANA and required applications on the already deployed infrastructure.

The supported scenarios include the full deployment of:

* HANA single-node instance.

* HANA high-availability pair, consisting of:

    * single-node HANA instance, two-tier HSR (primary and secondary).

    * Pacemaker high-availability cluster, fully configured with SBD and SAP/Azure resource agents.
