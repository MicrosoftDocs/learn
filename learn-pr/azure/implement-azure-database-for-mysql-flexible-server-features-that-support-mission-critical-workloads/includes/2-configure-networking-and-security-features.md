Key networking and security features in Azure Database for MySQL – Flexible Server include access control, connectivity, support for Microsoft Entra ID, a centralized platform for managing identities, roles, and permissions. MySQL flexible servers also encrypt all data in transit by default and provide the ability to encrypt data at rest with Azure- or customer-managed keys. 

## Networking

### Configure network access

When creating a MySQL flexible server, you can select either private access through an Azure Virtual Network, or public access for allow-listed IP addresses with an optional private endpoint. After completing the **Basics** section, select **Next: Networking**, and then select either **Public access and Private endpoint** or **Private access**: 

![Screenshot of the network connectivity choice between public and private access.](../media/networking-connectivity-public-private.png)

If you select **Public access and Private endpoint**, you can choose whether to expose the database to the internet. If **Allow public access** is unselected, the database will not be accessible using a public IP address; only by private endpoints. To keep public internet access, select **Allow public access**, then, under the **Firewall rules** section, add IP addresses or ranges to the allowlist. To add all Azure services on the Azure network to the allowlist, select **Allow public access from any Azure service within Azure to this server**. 

![Screenshot of the network connectivity selection for public access, and a list of firewall rules.](../media/networking-connectivity-public-access-firewalls.png)

In addition to or instead of public access, you can configure a private endpoint. Because Wingtip Toys plans to operate a VPN between their on-premises network and Azure, we’ll skip the private endpoint. See the reference documentation for more information on setting up a private link. 

To only allow connections from the Virtual Network, select **Private access**, and then, select the appropriate **Subscription**, **Virtual network**, and **Subnet**. If you don’t select a virtual network and subnet, a new network and subnet will be created. 

![Screenshot of the settings for the virtual network, including subscription, virtual network, and subnet.](../media/networking-virtual-network-subnet.png)

Finally, you need to set up **Private DNS integration** to connect with a fully qualified domain name instead of an IP address, which might change. Select an existing DNS zone, or let Azure create a new one for you. 

![Screenshot of private DNS integration configuration.](../media/networking-private-dns-integration.png)

### Configure encryption in transit

By default, MySQL flexible servers only accept encrypted connections using TLS (Transport Layer Security) version 1.2. If you are developing new applications which support TLS 1.3, it’s recommended to support or even enforce the newer version. To do so, perform the following steps: 

1. In the Azure portal, select the MySQL flexible server you want to connect to with TLS 1.3. 
2. In the **Server parameters** section, enter **tls_version** in the search bar in either the **Top** or **All** filters. 
3. In the **VALUE** dropdown, select TLSv1.2 and/or **TLSv1.3**, and then select **Save**. 
   ![server-parameters-tls-version](../media/server-parameters-tls-version.png)

You can also allow unencrypted connections by setting the value of the `require_secure_transport` parameter to off, though this is not recommended unless strictly necessary. 

## Microsoft Defender for Cloud

Microsoft Defender for Cloud is a cost-effective way to detect and alert upon anomalous or suspicious database activity. To enable it, perform these steps: 

1. In the Azure portal, select the MySQL flexible server you want to protect with Defender. 

2. In the **Microsoft Defender for Cloud** section, select **Enable**. 

   ![Screnshot of selection to enable Microsof Defender for Cloud.](../media/enable-microsoft-defender.png)

To learn more about Defender, including how to configure alerts, see the reference documentation. 

## Enable and connect using Microsoft Entra ID authentication 

Before you begin, you need an appropriately configured user-managed identity (UMI). The identity needs the [Directory Readers](https://review.learn.microsoft.com/azure/active-directory/roles/permissions-reference#directory-readers) role, or these individual permissions: [User.Read.All](https://review.learn.microsoft.com/graph/permissions-reference#user-permissions), [GroupMember.Read.All](https://review.learn.microsoft.com/graph/permissions-reference#group-permissions), and [Application.Read.ALL](https://review.learn.microsoft.com/graph/permissions-reference#application-resource-permissions). For more information about how to add these permissions, see this [tutorial](https://review.learn.microsoft.com/azure/mysql/flexible-server/how-to-azure-ad#grant-permissions-to-user-assigned-managed-identity).

To enable Microsoft Entra ID authentication for an Azure Database for MySQL flexible server, perform the following steps: 

1. In the Azure portal, select the MySQL flexible server that you want to connect to using Microsoft Entra ID. 

2. In the **Security** section, select **Authentication**. 

   ![Screenshot of the Azure Entra ID configuration.](../media/azure-entra-id-configuration.png)

3. Under the heading **Assign access to**, select either: **Microsoft Entra authentication only** (disables native MySQL user/password login) or **MySQL and Microsoft Entra authentication** (allows native MySQL *and* Microsoft Entra logins). 

4. Under the heading **Select Identity**, select the UMI mentioned earlier in this unit. 

5. Select a Microsoft Entra user or group to be the **Microsoft Entra Admin**. If you select a group, all members of the group are admins. Note that you can only have one admin user or group, and selecting another replaces the previous admin. 

With Microsoft Entra ID enabled, you can now connect to the MySQL flexible server using Microsoft Entra ID authentication by performing the following steps. 

1. Authenticate a shell with Azure. If you use Azure Cloud Shell, your identity is already configured in the session, so there’s no need to log in. If you’re using an unauthenticated terminal, run the following commands:  
   ```shell
   az login 
   az account set --subscription <subscription_id> 
   ```

2. In an authenticated shell, run the following command to retrieve an access token: 

   az account get-access-token --resource-type oss-rdbms 

3. Copy the access token presented and use it as the password to log in. To pass the access token to the mysql client directly, on Linux, run the following command: 

   ```shell
   mysql -h mydb.mysql.database.azure.com \ 
    --user user@tenant.onmicrosoft.com \ 
    --enable-cleartext-plugin \ 
    --password=`az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken`
   ```

   If you are using PowerShell, run the following command: 
   
   ```shell
   mysql -h mydb.mysql.database.azure.com \ 
    --user user@tenant.onmicrosoft.com \ 
    --enable-cleartext-plugin \ 
    --password=$(az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken) 
   ```

   When using other clients like MySQL Workbench, just paste the access token into the password field. 


## Encrypt data at rest with customer-managed keys

You can configure encryption at rest by using Azure portal or using the Azure CLI. However, before you can enable encryption with customer-managed keys, you need to verify that the following prerequisites are in place: 

- **User-managed identity (UMI)**. You need a UMI for the database to access the key vault. 

- **Permissions**. Set up either [role-based access](https://review.learn.microsoft.com/azure/role-based-access-control/overview) (IAM) or a [vault access policy](https://review.learn.microsoft.com/azure/key-vault/general/assign-access-policy), and grant the following permissions to the UMI: Get, List, Wrap key, and Unwrap key. 

- **Enable** [**soft-delete**](https://review.learn.microsoft.com/azure/key-vault/general/soft-delete-overview" /l "soft-delete-behavior). Accidentally losing access to an encryption key could result in permanent data loss. Enable soft deletion as a layer of protection. Note that when you use the Azure portal to create a new key vault, soft-deletion is enabled by default. 

  If you know the vault’s name but not ID, you can look it up by running: 

  ```shell
  az keyvault show --name $KEY_VAULT_NAME 
  ```

  To enable soft deletion on an existing vault, run: 

  ```shell 
  az resource update --id $KEY_VAULT_ID --set properties.enableSoftDelete=true
  ```

- **Enable purge protection**. A soft deleted key can still be incorrectly purged before the end of the retention period because of user or code error. Using purge protection sets a retention period for deleted objects before they are permanently removed. 

Now you can use the Azure portal or the Aure CLI to configure the customer-managed key to encrypt data at rest. 

If you are using the Azure portal: 

1. Navigate to your flexible server instance, and then under **Security**, select **Data encryption**.

   ![Screenshot of settings page to select a customer managed key.](../media/3-mysql-data-encryption.png)

2. Under **Data encryption**, select **+ Select**. In the **Select user assigned managed identity** dialog box, select the user assigned managed identity identified in the prerequisites, select the identity, and then select **Add**.

   ![Screenshot of the dialog box to select a user assigned managed identity.](../media/4-mysql-assigned-managed-identity-demo-umi.png)

3. Then, either select **enter a key identifier** and enter the id, or, in the **Select** **key** dialog box, select the key by specifying the identifier or by selecting a key vault and key. 

4. Select **Save**. 

If you are using the Azure CLI, run the following command: 

```shell
az mysql flexible-server update --resource-group $RESOURCE_GROUP --name $TEST_SERVER --key $KEY_IDENTIFIER --identity $IDENTITY 
```
