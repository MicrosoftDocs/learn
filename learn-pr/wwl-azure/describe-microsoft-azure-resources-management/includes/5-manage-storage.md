Storage, much like compute, can be a complex area of Azure with many options for management and control. However, at a basic level, storage comes down to a handful of key factors for successful management.

Remember that each storage account needs a globally unique name. 

##Overview
The overview blade of the storage account provides the opportunity to manage key aspects of the storage account, as well as access to components within the storage account.

For example, from the **Overview** you can identify and update the resource group and subscription for the storage account. You can also check the location or subscription ID.

:::image type="content" source="../media/storage-blade-overview.png" alt-text="Screenshot of the storage account overview blade.":::

You can manage tags for the storage account, access your different **Data storage** services, manage **Security + networking** and check and configure **Settings**, among other features and functions.

##Data storage
Within the **Data storage** submenu, you can manage your containers, files shares, queues, and tables. Initially, containers and file shares may be the most common areas you’ll access or use within an Azure storage account.

###Containers
Within the containers blade, you can create a new container, change the access level of a container, or select the container to open the container and explore additional, container specific options.

Once selected to a container, you can add or delete files, make individual or bulk file updates (such as to the access tier), manage shared access tokens, set or update access policy, and check the properties and metadata associated with the container.

>[!NOTE]
>Shared access is a way to grant tokenized, time-bound access to resources within Azure in a secure manner. Shared access tokens apply to many areas within Azure, not just containers.

:::image type="content" source="../media/shared-access-token.png" alt-text="Screenshot of the storage container page showing shared access token configuration.":::

###File shares
Selecting one of the file shares from within the **Data storage\File shares** page gives you access to manage the settings for the file share.

By scrolling down to the properties section, you can manage things such as the data retention period (soft delete) and the access tier (cool, hot, and so on).

:::image type="content" source="../media/file-share-properties.png" alt-text="Screenshot of the file share properties page with access tier and soft delete highlighted.":::

You can also configure operational settings such as snapshots and backups for your file tiers.

##Security + networking
The **Security + networking** area gives access to manage storage account networking, access keys, the shared access signatures, and encryption, among other things. The access keys menu item and the shared access signatures menu item are important areas to be familiar with to help ensure a more secure and robust storage account.

###Access keys
Access keys provides an easy location too manage your storage account access keys. Two access keys are provided, giving you the opportunity to rotate keys on an alternating basis, ensuring one key is always consistent. You can also **show** the access key and the associated connection string.

:::image type="content" source="../media/rotate-access-key.png" alt-text="Screenshot of the access keys page with rotate access key highlighted.":::

Rotating the access key is as simple as selecting **Rotate key**.

>[!WARNING]
>When you rotate an access key, the rotated key will be immediately replaced and any signatures or access relying on the old key will be invalid.

###Shared access signature
The **Shared access signature** page provides a more comprehensive and detailed place to manage shared access for your storage account. You can set the type of service, allowed resource types, permissions, and other settings. It provides a fine-grained control over your storage account access while enabling access to entities without a Microsoft Entra ID role for authentication.

:::image type="content" source="../media/shared-access-signature.png" alt-text="Screenshot of the shared access signature page.":::

Shared access signatures are more comprehensive, configurable, and detailed than shared access tokens.

##Settings
The **Settings** area allows you to manage additional components of your Azure storage account. In settings, you can change **configuration** settings around anonymous blob access, storage keys, or even the service tier (hot, cool, or cold).

:::image type="content" source="../media/storage-settings.png" alt-text="Screenshot of the configuration page of the settings sub-menu.":::

You can also check your service endpoints and manage resource locks.