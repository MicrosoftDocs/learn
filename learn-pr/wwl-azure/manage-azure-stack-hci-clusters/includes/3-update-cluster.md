Contoso IT currently dedicates a significant amount of time and effort to maintain their computing environment. This, to a large extent, results from the lack of hardware and software standards, and from limited use of automation. Contoso management is concerned about lengthy maintenance windows required to deploy all necessary firmware, driver, and operating system updates. As part of your evaluation of Azure Stack HCI, you decide to identify the best way to automate these tasks and minimize the maintenance window by using the high availability capabilities of Windows Server Failover Clustering.

## Overview of the Azure Stack HCI updates

Azure Stack HCI consists of multiple Microsoft-validated third-party physical servers running the specialized Microsoft operating system optimized for hyper-converged infrastructure. Effectively, your maintenance approach should take into account third-party firmware and driver updates for the underlying hardware and quality, security, and feature updates for the operating system released by Microsoft.

> [!NOTE]
> Microsoft supports each version of Azure Stack HCI operating system for two years by providing annual feature updates that customers must deploy within a year following their release.

For Azure Stack HCI integrated systems, hardware partners and solution providers typically offer Windows Admin Center extensions that simplify the installation of firmware and driver updates. You can fully automate deployment of operating system updates by using Cluster-Aware Updating (CAU).

> [!NOTE]
> To streamline deployment of updates to VMs running on Azure Stack HCI, consider using Azure Update Management.

:::image type="content" source="../media/cluster-validation.png" alt-text="The screenshot depicts the cluster validation option available from the Cluster Manager interface in Windows Admin Center." border="false":::

## Overview of CAU

CAU practically eliminates administrative overhead associated with the deployment of software updates to nodes of Windows Server Failover Clustering-based clusters, including those running Azure Stack HCI. At the same time, CAU deploys updates and restarts cluster nodes without any negative impact on the availability of clustered workloads.

To accomplish this, CAU performs the following sequence of steps on each cluster node:

1. Placing the local node into maintenance mode
1. Moving any clustered roles hosted on the local node to another one
1. Installing updates
1. Performing a restart if necessary
1. Terminating the maintenance mode on the local node
1. Moving clustered roles back to the local node

> [!NOTE]
> CAU is Storage Spaces Direct-aware, which means that it validates data resynchronization on each node before it proceeds to patch another one. In addition, CAU automatically evaluates the need for a restart for each installed update.

CAU can operate in one of the following two modes:

- **Self-updating**. In this mode, CAU is fully automated and implemented as a clustered role. Scheduling of updates relies on Updating Run Profiles, which you can configure by using Windows Admin Center, Failover Clustering tools, or Windows PowerShell. 
- **Remote-updating**. In this mode, you use Failover Clustering tools or Windows PowerShell to initiate an update process from any Windows computer with a direct access to the cluster.

## Update Azure Stack HCI cluster by using Windows Admin Center

Windows Admin Center provides the simplest method of implementing CAU for an Azure Stack HCI cluster. As soon as you connect to the cluster, Windows Admin Center evaluates whether any of the cluster nodes are missing operating system updates, and if so, prompts you to confirm whether you want to configure CAU in self-updating mode. Following your confirmation, Windows Admin Center automatically installs the CAU cluster role and configures the firewall rules required for node-to-node communication.

> [!NOTE]
> To implement CAU by using Windows Admin Center, you also need to accept the prompt to enable Credential Security Service Provider (CredSSP) and provide administrative credentials that will be used to connect to cluster nodes. Because CredSSP is considered less secure than Kerberos, which is used for authentication in other Azure Stack HCI scenarios, you should consider disabling CredSSP after you complete the CAU-based deployment.

:::image type="content" source="../media/cau-configuration-1.png" alt-text="The screenshot depicts the initial prompt for configuration of CAU in the Windows Admin Center interface." border="false":::

After the CAU configuration is complete, you will be able to initiate a deployment of missing updates at any time. The amount of time required to complete the deployment depends primarily on the number of updates to be deployed and can be just a few minutes or several hours. If Windows Admin Center includes third-party hardware extensions, you might be prompted to proceed with driver and firmware updates.

> [!NOTE]
> Following each update deployment, you should consider running cluster validation. You can perform validation from the Cluster Manager interface of Windows Admin Center.

> [!NOTE]
> Successful cluster validation is a prerequisite for Microsoft support.

> [!NOTE]
> You might have to deploy updates within a time window shorter than the one typically associated with the CAU-based implementation. This might be required because of a zero-day vulnerability that affects your cluster or the time limits imposed by a designated maintenance window. In such situations, you can perform an offline update of all cluster nodes at the same time. Before you do so, take all virtual disks offline, stop the cluster, and disable the Cluster service on each node. After the update process is complete, reverse the previous steps by enabling the Cluster service on each node, starting the cluster, and bringing all virtual disks online.

---
## Check your knowledge

## Multiple Choice
To evaluate the functionality of Azure Stack HCI for Contoso, you decide to test the implementation of CAU by using Windows Admin Center. What do you have to do before you can proceed with the implementation?
( ) Create the CAU clustered role. {{Incorrect. Windows Admin Center creates the CAU clustered role automatically. There is no need to create it first.}}
(x) Enable CredSSP. {{Correct. To implement CAU by using Windows Admin Center, you have to enable CredSSP and provide administrative credentials that will be used to connect to cluster nodes.}}
( ) Take the cluster virtual disks offline. {{Incorrect. This is required if you want to perform an offline update of all cluster nodes at the same time, rather than CAU-based deployment.}}