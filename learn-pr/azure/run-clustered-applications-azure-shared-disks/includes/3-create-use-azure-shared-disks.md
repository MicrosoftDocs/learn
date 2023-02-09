Your organization plans to implement failover clustering of Windows virtual machines (VMs) by using Azure shared disks. You now need to evaluate how to create Azure shared disks and examine the steps for using shared disks on existing Windows and Linux VMs.

## Create Azure shared disks

You can create Azure shared disks by using various tools. 

**Use the Azure portal**

1. Sign in to the Azure portal, and then search for and select **Disks**.
1. Select **+ Create** to create a managed disk and then, on the **Basic** tab, provide the following information:

    |Setting | Description |
    | --- | --- |
    | Subscription | Select your subscription. |
    | Resource Group | Choose an existing resource group or create a new one. |
    | Disk Name | Provide a descriptive name for the disk. |
    | Region | Select the region where you want to deploy the Azure shared disk. |
    | Availability Zone | Optionally, select an availability zone. |
    | Source type | Select an existing disk-creation source or select **None**. |
    | Size | Choose the supported size for the shared disk, such as 1024 gibibytes (GiB), P30. |
    | | |

1. On the **Encryption** tab, encrypt the disk with a platform-managed key, or provide your own disk-encryption set that's stored in an Azure key vault.
1. On the **Networking** tab, provide a connectivity method for your Azure shared disk.
1. On the **Advanced** tab, select the **Yes** checkbox for **Enable shared disk**, and then choose the number of **Max shares**.
1. On the **Tags** tab, provide resource categorization by using name/value parameters. These parameters help you track costs associated with similar resources that have the same applied tag.
1. On the **Review + create** tab, verify your entries, and then select **Create**.

You can also create shared disks by using Azure PowerShell, the Azure CLI, or Azure Resource Manager templates (ARM templates).

**Use PowerShell**

```azurepowershell
$dataDiskConfig = New-AzDiskConfig -Location "WestCentralUS" -DiskSizeGB 1024 -AccountType Premium\_LRS -CreateOption Empty -MaxSharesCount 2

New-AzDisk -ResourceGroupName "myResourceGroup" -DiskName "mySharedDisk" -Disk $dataDiskConfig
```

**Use the Azure CLI**

```azurecli
az disk create -g myResourceGroup -n mySharedDisk --size-gb 1024 -l westcentralus --sku Premium_LRS --max-shares 2
```

**Use ARM templates**

```json
{ 
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "dataDiskName": {
      "type": "string",
      "defaultValue": "mySharedDisk"
    },
    "dataDiskSizeGB": {
      "type": "int",
      "defaultValue": 1024
    },
    "maxShares": {
      "type": "int",
      "defaultValue": 2
    }
  },
  "resources": [
    {
      "type": "Microsoft.Compute/disks",
      "name": "[parameters('dataDiskName')]",
      "location": "[resourceGroup().location]",
      "apiVersion": "2019-07-01",
      "sku": {
        "name": "Premium_LRS"
      },
      "properties": {
        "creationData": {
          "createOption": "Empty"
        },
        "diskSizeGB": "[parameters('dataDiskSizeGB')]",
        "maxShares": "[parameters('maxShares')]"
      }
    }
  ] 
}
```

## Use Azure shared disks with VMs

Now that you know how to create an Azure shared disk, attach the disk to VMs for testing the shared capabilities. Use the following PowerShell and Azure CLI commands to attach the Azure shared disk on both VMs.

**Use PowerShell**

```azurepowershell
$resourceGroup = "<your resource group name>"
$location = "<region of your shared disk>"
$ppgName = "<your proximity placement groups name>"
$vm = Get-AzVM -ResourceGroupName "<your resource group name>" -Name "<your VM node name>"
$dataDisk = Get-AzDisk -ResourceGroupName $resourceGroup -DiskName "<your shared disk name>"
$vm = Add-AzVMDataDisk -VM $vm -Name "<your shared disk name>" -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun "<available LUN - check disk setting of the VM>"
Update-AzVm -VM $vm -ResourceGroupName $resourceGroup
```

**Use the Azure CLI**

```azurecli
diskId=$(az disk show -g "<your resource group name>" -n "<your shared disk name>" --query 'id' -o tsv)
az vm disk attach -g "<your resource group name>" --vm-name "<your VM node name>" --name $diskId
```

## Create a failover cluster with Azure shared disk

Now that you know how to connect VMs to the shared disk, you can create the failover cluster.

To accomplish high availability of workloads, create a failover cluster consisting of multiple Windows Server computers. If a server that's part of a failover cluster fails or becomes unavailable, another server in the same failover cluster takes over the failed server's services. This process is called *failover*, and it results in minimal service disruptions for clients who are accessing the service.

### Failover clustering components

The following table describes the failover cluster components.

| Component | Description |
| --- | --- |
| Nodes | Windows Server VMs that are members of a failover cluster. |
| Clients | Computers that consume highly available services and applications that are running in a failover cluster. |
| Networks | Enables communication between nodes and computers that consume clustered workloads. Uses the same virtual network where the VMs are deployed. If isolating cluster communication is necessary, create more subnets. |
| Clustered Role | A highly available role or service that runs on the cluster node. |
| Resources | Physical or logical elements that the failover cluster manages, such as a shared folder, disk, or IP address. |
| Clustered Storage | An Azure shared disk that enables each cluster node to access highly available shared storage. |
| | |

### Infrastructure requirements

Failover clusters depend on infrastructure services. Windows Server supports multiple-domain clusters and workgroup clusters. The following table describes the network-infrastructure elements necessary for a failover cluster.

| Element | Description |
| --- | --- |
| DNS | The servers in the cluster use Domain Name System (DNS) for name resolution. Use a custom DNS role installed in an Azure VM. |
| Active Directory | A SQL Server failover cluster instance (FCI) requires that both VMs are members of Azure Active Directory Domain Services (Azure AD DS). |
| An administrative account | An account that has administrative privileges on all of the cluster's servers. |
| | |

### Initialize the shared disk on both VMs

Initialize the attached disk on all VMs that share access using the master boot record (MBR) or GUID partition table (GPT) partition style. You should also format the disk by using the NTFS file format.

To begin creating a cluster, you must install the Failover Clustering feature on all VMs that will participate in the cluster. Use the following command to install Windows failover clustering service:

```azurepowershell
Install-WindowsFeature -Name Failover-Clustering –IncludeManagementTools
```

### Failover cluster validation

Cluster validation is a critical component of the failover-clustering lifecycle. You use it before the initial deployment and after a range of configuration changes, such as modifying the quorum settings. It's also helpful when you're troubleshooting performance and stability issues. Use Failover Cluster Manager or Windows PowerShell to run the validation. Both programs run several tests to ensure that you configured cluster components in the supported manner.

Use Failover Cluster Manager or PowerShell to validate prerequisites for cluster creation. The following example runs all cluster tests on computers that are named node1 and node2:

```azurepowershell
Test-Cluster –Node node1, node2
```
