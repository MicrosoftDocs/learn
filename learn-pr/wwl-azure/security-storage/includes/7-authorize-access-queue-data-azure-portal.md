When you access queue data using the Azure portal, the portal makes requests to Azure Storage under the covers. A request to Azure Storage can be authorized using either your Microsoft Entra account or the storage account access key. The portal indicates which method you are using, and enables you to switch between the two if you have the appropriate permissions.

## Permissions needed to access queue data

Depending on how you want to authorize access to queue data in the Azure portal, you'll need specific permissions. In most cases, these permissions are provided via Azure role-based access control (Azure RBAC).

### Use the account access key

To access queue data with the account access key, you must have an Azure role assigned to you that includes the Azure RBAC action Microsoft.Storage/storageAccounts/listkeys/action. This Azure role may be a built-in or a custom role. Built-in roles that support Microsoft.Storage/storageAccounts/listkeys/action include the following, in order from least to greatest permissions:

 -  The Reader and Data Access role<br>
 -  The Storage Account Contributor role
 -  The Azure Resource Manager Contributor role
 -  The Azure Resource Manager Owner role

When you attempted to access queue data in the Azure portal, the portal first checks whether you have been assigned a role with Microsoft.Storage/storageAccounts/listkeys/action. If you have been assigned a role with this action, then the portal uses the account key for accessing queue data. If you have not been assigned a role with this action, then the portal attempts to access data using your Microsoft Entra account.

### Use your Microsoft Entra account

To access queue data from the Azure portal using your Microsoft Entra account, both of the following statements must be true for you:

 -  You have been assigned either a built-in or custom role that provides access to queue data.<br>
 -  You have been assigned the Azure Resource Manager Reader role, at a minimum, scoped to the level of the storage account or higher. The Reader role grants the most restricted permissions, but another Azure Resource Manager role that grants access to storage account management resources is also acceptable.

The Azure Resource Manager Reader role permits users to view storage account resources, but not modify them. It does not provide read permissions to data in Azure Storage, but only to account management resources. The Reader role is necessary so that users can navigate to queues in the Azure portal.

Custom roles can support different combinations of the same permissions provided by the built-in roles.

## Navigate to queues in the Azure portal

To view queue data in the portal, navigate to the Overview for your storage account, and click on the links for Queues. Alternatively you can navigate to the Queue service section in the menu.

## Determine the current authentication method

When you navigate to a queue, the Azure portal indicates whether you are currently using the account access key or your Microsoft Entra account to authenticate.

## Authenticate with the account access key

If you are authenticating using the account access key, you'll see Access Key specified as the authentication method in the portal.

To switch to using Microsoft Entra account, click the link highlighted in the image. If you have the appropriate permissions via the Azure roles that are assigned to you, you'll be able to proceed. However, if you lack the right permissions, you'll see an error message like the following one:<br>

Notice that no queues appear in the list if your Microsoft Entra ID account lacks permissions to view them. Click on the Switch to access key link to use the access key for authentication again.<br>

## Authenticate with your Microsoft Entra ID account

If you are authenticating using your Microsoft Entra ID account, you'll see Microsoft Entra ID user Account specified as the authentication method in the portal.

Default to Microsoft Entra ID authorization in the Azure portal<br>

When you create a new storage account, you can specify that the Azure portal will default to authorization with Microsoft Entra ID when a user navigates to queue data. You can also configure this setting for an existing storage account. This setting specifies the default authorization method only, so keep in mind that a user can override this setting and choose to authorize data access with the account key.

To specify that the portal will use Microsoft Entra ID authorization by default for data access when you create a storage account, follow these steps:<br>

1. Create a new storage account, following the instructions in Create a storage account.<br>

2. On the Advanced tab, in the Security section, check the box next to Default to Microsoft Entra ID authorization in the Azure portal.

3. Select the Review + create button to run validation and create the account.

To update this setting for an existing storage account, follow these steps:<br>

1. Navigate to the account overview in the Azure portal.<br>

2. Under Settings, select Configuration.<br>

3. Set Default to Microsoft Entra authorization in the Azure portal to Enabled.
