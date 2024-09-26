When you create a storage account, Azure generates two 512-bit storage account access keys for that account. These keys can be used to authorize access to data in your storage account via Shared Key authorization, or via SAS tokens that are signed with the shared key.

Microsoft recommends that you use Azure Key Vault to manage your access keys, and that you regularly rotate and regenerate your keys. Using Azure Key Vault makes it easy to rotate your keys without interruption to your applications. You can also manually rotate your keys.

## Protect your access keys

Storage account access keys provide full access to the configuration of a storage account, as well as the data. Always be careful to protect your access keys. Use Azure Key Vault to manage and rotate your keys securely. Access to the shared key grants a user full access to a storage account’s configuration and its data. Access to shared keys should be carefully limited and monitored. Use shared access signature (SAS) tokens with limited scope of access in scenarios where Microsoft Entra ID based authorization can't be used. Avoid hard-coding access keys or saving them anywhere in plain text that is accessible to others. Rotate your keys if you believe they might have been compromised.

Microsoft recommends using Microsoft Entra ID to authorize requests against blob, queue, and table data if possible, rather than using the account keys (Shared Key authorization). Authorization with Microsoft Entra ID provides superior security and ease of use over Shared Key authorization. For Server Message Block (SMB) Azure file shares, Microsoft recommends using on-premises Active Directory Domain Services (AD DS) integration or Microsoft Entra Kerberos authentication.

To prevent users from accessing data in your storage account with Shared Key, you can disallow Shared Key authorization for the storage account. Granular access to data with least privileges necessary is recommended as a security best practice. Microsoft Entra ID based authorization should be used for scenarios that support OAuth. Kerberos or SMTP should be used for Azure Files over SMB. For Azure Files over REST, SAS tokens can be used. Shared key access should be disabled if not required to prevent its inadvertent use.

To protect an Azure Storage account with Microsoft Entra Conditional Access policies, you must disallow Shared Key authorization for the storage account.

If you have disabled shared key access and you are seeing Shared Key authorization reported in the diagnostic logs, this indicates that trusted access is being used to access storage.

## View account access keys

You can view and copy your account access keys with the Azure portal, PowerShell, or Azure CLI. The Azure portal also provides a connection string for your storage account that you can copy.

To view and copy your storage account access keys or connection string from the Azure portal:

1.  In the [Azure portal](https://portal.azure.com/), go to your storage account.
2.  Under **Security + networking**, select **Access keys**. Your account access keys appear, as well as the complete connection string for each key.<br>
3.  Select Show keys to show your access keys and connection strings and to enable buttons to copy the values.<br>
4.  Under **key1**, find the **Key** value. Select the **Copy** button to copy the account key.<br>
5.  Alternately, you can copy the entire connection string. Under key1, find the **Connection string** value. Select the **Copy** button to copy the connection string.
    
    :::image type="content" source="../media/portal-connection-c2097b8f.png" alt-text="Screenshot showing an example of the portal connection string.":::
    

You can use either of the two keys to access Azure Storage, but in general it's a good practice to use the first key, and reserve the use of the second key for when you are rotating keys.

To view or read an account's access keys, the user must either be a Service Administrator, or must be assigned an Azure role that includes **Microsoft.Storage/storageAccounts/listkeys/action**. Some Azure built-in roles that include this action are the **Owner**, **Contributor**, and **Storage Account Key Operator Service** Roles.

## Use Azure Key Vault to manage your access keys

Microsoft recommends using Azure Key Vault to manage and rotate your access keys. Your application can securely access your keys in Key Vault, so that you can avoid storing them with your application code.

## Manually rotate access keys

Microsoft recommends that you rotate your access keys periodically to help keep your storage account secure. If possible, use Azure Key Vault to manage your access keys. If you are not using Key Vault, you will need to rotate your keys manually.

Two access keys are assigned so that you can rotate your keys. Having two keys ensures that your application maintains access to Azure Storage throughout the process.

Regenerating your access keys can affect any applications or Azure services that are dependent on the storage account key. Any clients that use the account key to access the storage account must be updated to use the new key, including media services, cloud, desktop and mobile applications, and graphical user interface applications for Azure Storage, such as **Azure Storage Explorer.**

Additionally, rotating or regenerating access keys revokes shared access signatures (SAS) that are generated based on that key. After access key rotation, you must regenerate account and service SAS tokens to avoid disruptions to applications. Note that **user delegation** SAS tokens are secured with Microsoft Entra credentials and aren't affected by key rotation.

If you plan to manually rotate access keys, Microsoft recommends that you set a key expiration policy.

After you create the key expiration policy, you can use Azure Policy to monitor whether a storage account's keys have been rotated within the recommended interval.

To rotate your storage account access keys in the [Azure portal](https://portal.azure.com/):

1.  Update the connection strings in your application code to reference the secondary access key for the storage account.
2.  Navigate to your storage account in the Azure portal.
3.  Under **Security + networking**, select **Access keys**.
4.  To regenerate the primary access key for your storage account, select the **Regenerate** button next to the primary access key.
5.  Update the connection strings in your code to reference the new primary access key.
6.  Regenerate the secondary access key in the same manner.

> [!CAUTION]
> Microsoft recommends using only one of the keys in all of your applications at the same time. If you use Key 1 in some places and Key 2 in others, you will not be able to rotate your keys without some application losing access.

To rotate an account's access keys, the user must either be a Service Administrator, or must be assigned an Azure role that includes the **Microsoft.Storage/storageAccounts/regeneratekey/action**. Some Azure built-in roles that include this action are the **Owner**, **Contributor**, and **Storage Account Key Operator Service Roles**.

## Create a key expiration policy<br>

A key expiration policy enables you to set a reminder for the rotation of the account access keys. The reminder is displayed if the specified interval has elapsed and the keys have not yet been rotated. After you create a key expiration policy, you can monitor your storage accounts for compliance to ensure that the account access keys are rotated regularly.

To create a key expiration policy in the Azure portal:

1.  In the [Azure portal](https://portal.azure.com/), go to your storage account.
2.  Under **Security + networking**, select **Access keys**. Your account access keys appear, as well as the complete connection string for each key.
3.  Select the **Set rotation reminder** button. If the **Set rotation reminder** button is grayed out, you will need to rotate each of your keys. Follow the steps described in Manually rotate access keys to rotate the keys.
4.  In Set a reminder to rotate access keys, select the **Enable key rotation reminders** checkbox and set a frequency for the reminder.
5.  Select **Save** .
    
    :::image type="content" source="../media/portal-key-expiration-policy-page-e116b00c.png" alt-text="Screenshot showing how to set a reminder to rotate keys.":::
    

## Check for key expiration policy violations

You can monitor your storage accounts with Azure Policy to ensure that account access keys have been rotated within the recommended period. Azure Storage provides a built-in policy for ensuring that storage account access keys are not expired.

### Assign the built-in policy for a resource scope

Follow these steps to assign the built-in policy to the appropriate scope in the Azure portal:

1.  In the [Azure portal](https://portal.azure.com/), search for Policy to display the Azure Policy dashboard.
2.  In the **Authoring** section, select **Assignments**.
3.  Choose **Assign policy**.
4.  On the **Basics** tab of the **Assign policy** page, in the **Scope** section, specify the scope for the policy assignment. Select the More button to choose the subscription and optional resource group.
5.  For the **Policy definition** field, select the **More** button, and enter *storage account keys* in the **Search** field. Select the policy definition named **Storage account keys should not be expired**.
    
    :::image type="content" source="../media/policy-definition-select-portal-page-40266255.png" alt-text="Screenshot showing a policy definition example of how to ensure storage account keys are not expired.":::
    
6.  Select **Review + create** to assign the policy definition to the specified scope.
    
    :::image type="content" source="../media/policy-assignment-create-page-53cecf86.png" alt-text="Screenshot showing how to assign the built-in policy for a resource scope.":::
    

## Monitor compliance with the key expiration policy

To monitor your storage accounts for compliance with the key expiration policy, follow these steps:

1.  On the Azure Policy dashboard, locate the built-in policy definition for the scope that you specified in the policy assignment. You can search for *Storage account keys, should not be expired* in the **Search** box to filter for the built-in policy.<br>
2.  Select the policy name with the desired scope.<br>
3.  On the **Policy assignment** page for the built-in policy, select **View compliance**. Any storage accounts in the specified subscription and resource group that do not meet the policy requirements appear in the compliance report. To bring a storage account into compliance, rotate the account access keys.
    
    :::image type="content" source="../media/policy-compliance-report-page-238d8b1b.png" alt-text="Screenshot showing the policy compliance report portal.":::
    
