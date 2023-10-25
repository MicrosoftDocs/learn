| ![Cartoon image of Andy.](../media/andy.png) | Andy is the IT Administrator for the SAP S/4 HANA landscape running in Azure and needs secure access to monitor, manage, and remediate problems from any location. |
| :--- | :--- |

Andy's system access supports two key functions:

1. Managing the Azure infrastructure.
2. Managing the SAP/S4 HANA systems in Azure.

## Mechanisms for accessing the Azure infrastructure

Andy needs to be able to create and manage virtual machines, networking resources, and users. Andy uses the following features and services:

- **The Azure portal**. To access Azure services and tools, Andy points the browser to [https://portal.azure.com](https://portal.azure.com) and authenticates through Microsoft Entra ID and Microsoft Entra multifactor authentication. 
- **Azure PowerShell**. Andy uses a comprehensive collection of PowerShell cmdlets to manage Azure. 
- **Azure Command Line Interface (CLI)**. Andy also uses the Azure CLI, which is similar to PowerShell but runs in a bash-like shell. 
- **Secure Shell Protocol (SSH)** or **Remote Desktop Protocol (RDP)**, depending on the system Andy needs to access.

## Mechanisms for accessing the SAP S/4 HANA infrastructure

Andy needs a secure connection into Azure to connect directly to the operating systems and SAP applications. Andy has set up an Azure Bastion host in the hub Azure virtual network for the SAP solution. Azure Bastion is a fully managed service that provides secure, seamless RDP and SSH access to virtual machines without exposure through public IP addresses. Andy connects directly to the Bastion service, then connects to the Windows Server or Linux virtual machines running the SAP applications and the HANA database running on Linux.

## Monitoring and analytics

Two other tools help Andy secure and analyze the networking portion of the architecture: Azure Network Watcher and Azure Sentinel.

- Azure Network Watcher helps Andy monitor and automatically repair issues within the SAP S/4 HANA landscape in Azure. Network Watcher includes tools to monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. Andy uses Network Watcher to monitor and repair the network health of Infrastructure-as-a-Service (IaaS) products. These IaaS products include Azure Virtual Machines, Azure Virtual Networks, Azure Application Gateways, and Azure load balancing services. 
- Azure Sentinel offers Andy a bird's-eye view across Azure and the company's SAP S/4 HANA landscape to help address increasingly sophisticated attacks and a growing volume of alerts. The service, a scalable, cloud-native, security information event management (SIEM), and security orchestration automated response (SOAR) solution, offers intelligent security analytics and threat intelligence. Azure Sentinel provides Andy a single solution for alert detection, threat visibility, proactive hunting, and threat response, and helps reduce resolution time frames. 

> [!NOTE]
> To install SAP S/4 HANA on Azure, Andy can choose to deploy SAP solutions from three major sources and in various ways, including:
>- Use the SAP Cloud Appliance Library to easily choose and provision an entire SAP S/4 HANA landscape in Azure. The SAP Cloud Appliance Library significantly reduces the time it takes to select and deploy SAP solutions on Azure - in some cases, from weeks to minutes.
>- Use open-source Terraform from HashiCorp or Red Hat Ansible scripts that are pre-written to deploy SAP S/4 HANA into Azure. These scripts are customizable. Andy can modify them to adjust how and where he wants the solution to be deployed. The scripts are available on GitHub.
>- Do it himself with available software from SAP and the Azure Marketplace. This includes provisioning the Linux virtual machines and installing the SAP S/4 software onto the Azure virtual machines, then configuring and deploying storage and networking to arrive at a working system.
