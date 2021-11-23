Companies still have choices to secure and control access to file shares, even if you use a shared key to connect to them.

The finance company has stated that they'd like to implement security best practices. One approach is to lock down access to the file shares to a specific range of IP addresses. They'd also like to understand their options to use Azure Active Directory Domain Services (Azure AD DS) authentication.

In this unit, you'll investigate ways to secure access to Azure file shares from on-premises machines. You'll check to ensure that data is encrypted in transit to Azure. With secure access in place, you'll look at how the finance company can use Azure AD to control access to the file shares. As an extra level of protection for the shared files, you'll also explore the snapshot feature.

## Secure access from on-premises

Azure file shares only support mounting them from Server Message Block (SMB) protocol. Microsoft recommends you use SMB version 3.0. 

> [!WARNING]
> There are known vulnerabilities with SMB 1.0. Microsoft recommends you either uninstall or disable version 1.0 from all the machines you're responsible for. With SMB 1.0 disabled, the risk of an SMB-based attack dramatically reduces. If you need to remove SMB 1.0, use this PowerShell command: `Remove-WindowsFeature -Name FS-SMB1`.

When you mount Azure file shares, Windows needs to communicate over port 445. Organizations can block network access over 445 by default. If your organization has this policy, consider requesting to open the port. There's nothing inherently insecure about this specific port. 

### Configure IP-based firewall rules

To limit access to your on-premises networks, you'll need to configure IP-based firewall rules. Therefore, you need to know your public-facing IP address. With this information, you can enable the storage account's firewall to allow access from selected networks. You can then add your public IP address to the list of allowed addresses, either via the Azure portal, by running a PowerShell command, or by running an Azure CLI command.

    PowerShell command to configure firewall access for a storage account.

    ```powershell
    Add-AzStorageAccountNetworkRule `
        -ResourceGroupName "myresourcegroup" `
        -AccountName "mystorageaccount" `
        -IPAddressOrRange "NNN.NNN.NNN.NNN"
    ```

    Azure CLI command to configure firewall access for a storage account.

    ```azurecli
    az storage account network-rule add \
        --resource-group "myresourcegroup" \
        --account-name "mystorageaccount" \
        --ip-address "NNN.NNN.NNN.NNN"
    ```

where `NNN.NNN.NNN.NNN` is your public-facing IP address.

### Require secure transfer for all connections

Running the commands in the previous section creates an Azure storage account with secure transfer enabled by default. 

If you created file shares without secure transfer enabled, it's easy to enable this feature either in the portal, by running a PowerShell command, or by running an Azure CLI command.

    Azure portal configuration to enable secure transfer for storage accounts. 

    :::image type="content" source="../media/5-secure-transfer.png" alt-text="Screenshot of the configuration page for storage accounts.":::

    PowerShell command to enable secure transfer for a storage account.

    ```powershell
    Set-AzStorageAccount `
        -Name "StorageAccountName" `
        -ResourceGroupName "ResourceGroupName" `
        -EnableHttpsTrafficOnly $True
    ```

    Azure CLI command to enable secure transfer for a storage account.

    ```azurecli
    az storage account update \
        --resource-group ResourceGroupName \
        --name StorageAccountName \
        --https-only true
    ```

The secure transfer option only allows requests to the storage account over a secure HTTPS connection. Any requests that use HTTP will be rejected. When you use Azure Files, connections without encryption will fail, even when you use SMB 2.1, SMB 3.0 without encryption, or some flavors of the Linux SMB client.

### Enable and use Azure AD DS authentication

The finance company is running their new reporting application on a VM hosted on Azure. They'd like to set up Azure Active Directory Domain Services (AD DS) authentication to access the file shares before they move more of their processing into the cloud.

The benefits of Azure AD DS are that you can manage access with role-based access controls. Files inherit their existing NTFS discretionary access control lists (DACLs).

The first step in setting up Azure AD DS is to enable Azure AD DS for the tenant and have the VM reside in the same virtual network. With these things in place, you'll enable Azure AD DS authentication on the storage account. You can then grant access permissions to a share in the storage account. These permissions can be at the user, group, or service principal level.

![Diagram showing the steps required to set up Azure AD DS.](../media/5-azure-active-directory-over-smb-workflow.svg)

Microsoft has three permissions levels of access to SMB file share, each identified by a role:

- Storage File Data SMB Share Reader
- Storage File Data SMB Share Contributor
- Storage File Data SMB Share Elevated Contributor

### Use share snapshots to protect against accidental deletion

Share snapshots give you an extra level of security and help reduce the risk of data corruption or accidental deletion. You can also use share snapshots as a general backup for disaster recovery. Snapshots are at the root level of a file share and apply to all the folders and files contained in it.

Snapshots are easy to create in the Azure portal or with the REST API, client libraries, Azure CLI, or PowerShell.

:::image type="content" source="../media/5-create-snapshot.png" alt-text="Screenshot showing the Snapshot option.":::
