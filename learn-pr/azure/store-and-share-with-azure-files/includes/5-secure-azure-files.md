Companies still have choices to secure and control access to file shares, even if you're using a shared key to connect to them.

The finance company has stated that they'd like to implement security best practices. One approach is to lock down access to the file shares to a specific range of IP addresses. They'd also like to understand their options to use Azure Active Directory (AD) Domain Services (DS) authentication.

In this unit, you'll investigate ways to secure access to Azure file shares from on-premises machines. You'll check to ensure that data is encrypted in transit to Azure. With secure access in place, you'll look at how the finance company can use Azure AD to control access to the file shares. As an extra level of protection for the shared files, you'll also explore the snapshot feature.

## Secure access from on-premises

Azure file shares only support mounting them from SMB version 3.0. There are known vulnerabilities with SMB 1.0. Microsoft recommends you either uninstall or disable this version from all the machines you're responsible for.

If you need to remove SMB 1, use this PowerShell command: `Remove-WindowsFeature -Name FS-SMB1`.

When mounting Azure file shares, Windows needs to communicate over port 445. Organizations may block network access over 445 by default. If your organization has this policy, consider requesting to open the port. There's nothing inherently insecure about this specific port, and with SMB 1 disabled, the risks of an SMB-based attack dramatically reduces.

### Configure IP-based firewall rules

To limit access to your on-premises networks, you'll need to know your public-facing IP address. With this information, enable the storage accounts firewall to allow access from selected networks. You can then add your public IP address to the list of allowed addresses, either in the portal or by using a PowerShell command:

```powershell
Add-AzStorageAccountNetworkRule -ResourceGroupName "myresourcegroup" -AccountName "mystorageaccount" -IPAddressOrRange "NNN.NNN.NNN.NNN"
```

Or you could use a CLI command:

```azurelci
az storage account network-rule add --resource-group "myresourcegroup" --account-name "mystorageaccount" --ip-address "NNN.NNN.NNN.NNN"
```

Where `NNN.NNN.NNN.NNN` is your public-facing IP address.

### Require secure transfer for all connections

Using the commands in the previous exercise creates an Azure storage account with secure transfer enabled by default. If your file shares have been created without this feature enabled, it's easy to do that in the portal. 

![Screenshot of the configuration page of storage accounts](../media/5-secure-transfer.png)

Or you can automate it with a PowerShell command:

```powershell
Set-AzStorageAccount -Name "StorageAccountName" -ResourceGroupName "ResourceGroupName" -EnableHttpsTrafficOnly $True
```

Or you could use a CLI command:

```azurecli
az storage account update -g ResourceGroupName -n StorageAccountName --https-only true
```

The secure transfer option only allows requests to the storage account over a secure HTTPS connection. Any requests using HTTP will be rejected. When you're using the Azure Files service, connections without encryption will fail, including when you're using SMB 2.1, SMB 3.0 without encryption, or some flavors of the Linux SMB client.

### Enable and use Azure AD DS authentication

The finance company is running their new reporting application on a VM hosted on Azure. That's why they'd like to set up Azure AS DS authentication to access the file shares. It's something they want to do before moving more of their processing into the cloud.

The benefits of Azure AD DS are that you can manage access with role-based access controls. Files inherit their existing NTFS DACLs.

The first step to setting up Azure AD DS is to enable Azure AD Domain Services for the tenant and have the VM reside in the same VNET. With these things in place, you'll enable Azure AD DS authentication on the storage account. You can then grant access permissions to a share in the storage account. These permissions can be at the user, group, or service principal level.

![A diagram showing the steps in order required to set up Azure AD DS](../media/5-azure-active-directory-over-smb-workflow.png)

Microsoft has created three new roles for permissions levels of access to SMB file shares for users:

- Storage File Data SMB Share Reader
- Storage File Data SMB Share Contributor
- Storage File Data SMB Share Elevated Contributor

### Use share snapshots to protect against accidental deletion

Share snapshots give you an extra level of security and help reduce the risk of data corruption or accidental deletion. You can also use them as a general backup for disaster recovery.

The snapshots are easy to create on the Azure portal, or with the REST API, client libraries, Azure CLI, and PowerShell.

Snapshots are at the root level of a file share, and apply to all the folders and files contained in it. 

![Screenshot showing the Create Snapshot option](../media/5-create-a-snapshot.png)