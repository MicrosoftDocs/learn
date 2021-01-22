Contoso has several different platforms and runtime scenarios for its various applications. As the Windows server administrator, you need to assess what scenarios are available with Site Recovery, and which of those scenarios are potentially applicable to Contoso workloads and environments.

## Usage Scenarios for Site Recovery

The following table details which types of machines or servers that Site Recovery can replicate, and to which locations.

|Replicate|Replicate from|Replicate to|
|------|------|-----------|
|Physical Windows Server or Linux servers|Physical server|Physical server in secondary datacenter|
|Physical Windows Server or Linux servers|Physical server|Azure|
|Hyper-V VM|Hyper-V host|Azure|
|Hyper-V VM|Hyper-V host in a Microsoft System Center Virtual Machine Manager (VMM) cloud|Azure|
|Hyper-V VM|Hyper-V host in a VMM cloud|VMM cloud in a secondary site|
|Azure VMs|Azure region|Azure region|
|AzureStack VMs|AzureStack|Azure|
|VMWare VM|VMWare server|Azure|
|VMWare VM|VMWare server|Secondary VMWare site|
|Amazon Web Services (AWS) Windows VMs|AWS|Azure|

## Deployment scenarios

Each usage scenario has its own use requirements. Two possible scenarios for implementing Site Recovery are:

- On-premises Hyper-V Replication to Azure (without VMM)
- On-premises Hyper-V Replication to a secondary on-premises Hyper-V site (with VMM)

### On-premises Hyper-V Replication to Azure (without VMM)

The following graphic illustrates the replication of virtual machines from an on-premises site to Azure Site Recovery service in the cloud. The on-premises site has a Hyper-V server host with the Site Recovery Provider and Microsoft Azure Recovery Services Agent installed. There is replication traffic over HTTPS port 443 to Site Recovery, which in turn has Azure Storage present for storing replicated VMs.

:::image type="content" source="../media/m27-site-recovery-hyper-v-to-azure.png" alt-text="An on-premises Hyper-V server host environment replicating VMs to the Azure Site Recovery service." border="false":::

#### Task 1: Complete Deployment planning

- Download and run **Deployment Planner**.
  - The Site Recovery *Deployment Planner* is a command-line tool for both Hyper-V to Azure and VMware to Azure disaster recovery scenarios.
  - Remotely profile your Hyper-V VMs present on multiple Hyper-V hosts using this tool (with no production impact) to understand the bandwidth, storage and other requirements for successful replication and test failover or failover.
  - Use Deployment Planner to get:
    - A compatibility assessment
    - Network bandwidth need versus RPO assessment
    - Azure infrastructure requirements
    - On-premises infrastructure requirements
    - Initial replication batching guidance
    - Estimated DR cost to Azure

#### Task 2: Create Azure resources

1. Sign in to your Azure subscription and verify that your Azure account has replication permissions.
1. Create a **Recovery Services vault** to store metadata and configuration information for VMs and other replication components.

    > [!NOTE] 
    > The **Recovery Services vault** contains metadata, but no actual customer data.
1. Create a storage account in Azure.
    - Images of replicated machines are stored in Azure Storage.
    - Azure VMs are created from the storage when you fail over from on-premises to Azure.
    - The storage account must be in the same region as the **Recovery Services vault**.
1. Set up an Azure network.
    - The network must be in the same region as the **Recovery Services vault**.
    - When Azure VMs are created from storage after failover, they're joined to this network.

#### Task 3: Configure Hyper-V hosts

1. Review requirements and prerequisites to ensure you're running supported environments in Hyper-V.
1. Make sure that Hyper-V hosts have internet access and can access the required Azure service URLs, as listed in the following table.

    |Name|URL|Purpose|
    |---|---|---|
    |Azure Active Directory|`login.microsoftonline.com`|Used for access control and identity management.|
    |Backup|`*.backup.windowsazure.com`|Used for replication data transfer and coordination.|
    |Replication|`*.hypervrecoverymanager.windowsazure.com`|Used for replication management operations and coordination.|
    |Storage|`*.blob.core.windows.net`|Used for access to the storage account that stores replicated data.|
    |Time synchronization|`time.windows.com`|Used to check time synchronization between the system time and global time in all deployments.|
    |Service Bus|`*.servicebus.windows.net`|Allows the VM to write Site Recovery monitoring and diagnostics data.|

1. To allow for the connection to Windows VMs using RDP after failover:
    1. Remove any static persistent routes in the routing table.
    1. Remove the **WinHTTP** proxy.
    1. To allow connectivity to replicated Windows VMs using RDP over the internet, enable RDP on the on-premises VM before failover. Ensure that:
        - **TCP** and **UDP** rules are added for the **Public** profile.
        - **RDP** is allowed in **Windows Defender Firewall** for all profiles.
    1. Allow connectivity to replicated Windows VMs over site-to-site VPN by enabling **RDP** on the on-premises machine:
        - **RDP** should be allowed in the **Windows Defender Firewall** for **Domain** and **Private** networks.
        - Ensure the operating system's **SAN policy** is set to **OnlineAll**.

#### Task 4: Prepare infrastructure

1. In Azure, open your **Recovery Services vault**.
1. Select **+ Enable Site Recovery**.
1. In the **Hyper-V machines to Azure** list, select the **1: Prepare infrastructure** option to launch the **Prepare Infrastructure** wizard.
1. On the **Deployment planning** page, confirm that your deployment planning is complete.
1. On the **Source settings** page, complete the following:
    1. Register your Hyper-V host:
        1. On the **Add server** page, select the **Add Hyper-V server** option.
        1. Download the installer for the **Azure Site Recovery Provider**, and then transfer it to the Hyper-V host.
        1. Download the **vault registration key** to register the host in a Hyper-V site.
        1. Install the **Azure Site Recovery Provider** on the Hyper-V host and then use the **vault registration key** to register the host in the vault.
        1. Use **Azure Site Recovery** to retrieve metadata from the Hyper-V server that's displayed in **Site Recovery Infrastructure** > **Hyper-V Hosts**. This process can take up to 30 minutes.
        1. Select the **Hyper-V server** from which you want to replicate.
1. On the **Target settings** page, select the subscription and the resource group in which the Azure VMs will be created after failover, and then select the **Resource Manager** deployment model.
1. On the **Replication policy** page, set up a replication policy containing items such as copy frequency, recovery point retention, and initial replication start time.

#### Task 5: Enable replication

1. In the **Recovery Services vault** window, select **Site Recovery**.
1. In the options for **Hyper-V machines to Azure**, select **2: Enable replication** to launch the **Enable replication** wizard.
1. Configure the **Enable replication** wizard pages as follows:
    1. On the **Source environment** page, select the Hyper-V site you just added.
    1. On the **Target environment** page:
        1. Verify the target is **Azure**, the **vault subscription**, and the **Resource Manager deployment model**.
        1. Select the **storage** and **network** you created earlier for Azure Site Recovery.
1. On the **Virtual machine selection** page, select the **VM** that you want to replicate.
1. On the **Replication policy** page, select the **replication policy** you created earlier.

    > [!TIP] 
    > You can track progress of the **Enable Protection** action in **Jobs** > **Site Recovery jobs**.

1. After the **Finalize Protection** job finishes, the initial replication is complete, and the VM is ready for failover.

#### Task 6: Run a disaster recovery drill to Azure

1. Create a network for test failover.
    - When performing a test failover, consider the following:
        - Choose a network that's isolated from the production recovery site network. This is specified in the **Azure VM** > **Disaster Recovery** > **Compute and Network** settings for each replica VM.
        - The test network should have the same number of subnets as your production network.
        - Subnets should have the same names and the test network should use the same IP address range.
1. Start a test failover by opening the replica VM in Azure and selecting **Test Failover**. Be sure to:
    1. Confirm which **Recovery point** to use.
    1. Confirm which **Azure virtual network** to use.
1. After failover completes, verify the failover was successful by:
    1. Noting the messages received.
    1. Connecting to **Azure VM** using **RDP/SSH** and ensuring the network is up and running successfully.

> [!NOTE]
> If you're wanting to migrate your VM workloads to Azure and don't specifically require a disaster recovery solution, you can use the **Azure Migrate** service. This service is specifically designed to manage application and workload migration to Azure.
