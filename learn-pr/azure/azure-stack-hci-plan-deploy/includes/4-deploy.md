Microsoft offers Azure Stack HCI through partners as prebuilt and preconfigured integrated systems. This helps define a consistent, structured deployment process that consists of several steps that customers must follow. The following section reviews that process, which is the same as that which you'd follow when implementing Azure Stack HCI in Contoso's proof-of-concept environment.

## Deploy Azure Stack HCI

To implement Azure Stack HCI, you should:

1. Set up the Azure Stack HCI hardware. After you receive an Azure Stack HCI-integrated system purchased from the Azure Stack HCI Catalog through a Microsoft hardware partner, you should set it up in your datacenter. The system should have the Azure Stack HCI operating system preinstalled. You also need to configure network connectivity from your internal network to the cluster.

1. Create the cluster. Assign computer names that match your custom naming conventions to the Azure Stack HCI operating-system instances that are running on Azure Stack HCI nodes and join them to your AD DS domain. While this typically is your existing domain, you can deploy a self-contained AD DS environment using Azure Stack HCI VMs that is dedicated to the Azure Stack HCI environment. If you do this, ensure that you:

- Avoid placing configuration and disk files of the VMs that are hosting domain controllers on clustered storage. Instead, use local, nonclustered disks with one domain controller per node.
- Deploy an additional domain controller on a physical server that isn't part of the Azure Stack HCI cluster.

Next, create a failover cluster using Windows Admin Center or PowerShell. Ensure that the computer on which you run Windows Admin Center is joined to the same Active Directory domain in which you'll create the cluster, or a trusted domain.

:::image type="content" source="../media/4-azure-stack-hci-windows-admin-center-1.png" alt-text="A screenshot of the initial page of the Windows Admin Center Cluster Creation wizard indicating the choice of cluster type with Azure Stack HCI selected and the choice of select server locations with all servers in one site selected." border="false":::

The Create Cluster wizard of the Windows Admin Center guides you through five main deployment steps:

  1. Get Started: Verifies prerequisites for cluster join on each server, including installation of all required operating-system roles and features.
  1. Networking: Assigns and configures network adapters and creates virtual switches for each server.
  1. Clustering: Validates that the cluster is set up correctly.
  1. Storage: Configures Storage Spaces Direct.
  1. SDN: Installs the Network Controller component of SDN.

:::image type="content" source="../media/4-azure-stack-hci-windows-admin-center-2.png" alt-text="A screenshot of the Windows Admin Center Cluster Creation wizard page containing a list of the main installation steps." border="false":::

> [!NOTE]
> To implement an SMB File Share witness, which you'll do in the next step, you can use an USB key attached to a network device accessible from all nodes. Azure Cloud Witness is particularly useful in scenarios where there isn't an additional on-premises infrastructure and when implementing stretched clusters.

1. Set up a cluster witness. This step is mandatory for all clusters. You can use for this purpose an SMB File Share with write-access from all cluster nodes or a blob container in an Azure Storage account, serving as an Azure Cloud Witness.

1. Register with Azure. Azure Stack HCI is an Azure service and you need to register it with Azure within 30 days of installation. At the registration time, Azure Stack HCI integrates automatically with Azure Arc, which provides monitoring, support, and billing. This integration also simplifies provisioning of such Azure hybrid services as Azure Monitor, Azure Backup, and Azure Site Recovery.

1. Validate the cluster. Following the deployment, you run cluster validation tests to identify any potential hardware or configuration issues.

1. Configure storage. Create clustered volumes on a single-site cluster or clustered and replicated volumes in a stretched cluster.

1. Deploy workloads. Create VMs and deploy workloads into them.

1. Integrate with Azure services. Use Windows Admin Center to implement integration between Azure Stack HCI VM-based workloads and Azure.

1. If applicable, perform additional hardware vendor-specific configuration.

1. Implement Software Defined Networking (SDN). SDN implementation is optional and not available for stretched clusters.
