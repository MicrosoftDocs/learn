
You can grant access to Azure Key Vault using either role-based access control (RBAC) or using Key Vault access policies. Either method works to protect your secrets, certificates, and keys. Access policies give you a little more granular control, but can be harder to manage. Choose the best option based on your security posture needs.

### Assign a Key Vault access policy

A Key Vault access policy determines whether a user, application, or group, can perform operations on Key Vault secrets, keys, and certificates. You can assign access policies using the Azure portal, the Azure CLI, or Azure PowerShell. Key vault supports up to 1024 access policy entries, with each entry granting a distinct set of permissions to a particular security principal. Because of this limitation, we recommend assigning access policies to groups of users, where possible, rather than individual users. Using groups makes it much easier to manage permissions for multiple people in your organization.

:::image type="content" source="../media/key-vault-access-policy-56f5c1df.png" alt-text="Screenshot of the Roles and administrators screen in Azure AD. List of roles that can be applied.":::


1.  Open **Key Vault** in the Azure portal.
2.  Select your key vault or create a new one.
3.  From the menu select **Access policies**, then select **+ Add Access Policy**.
4.  Use the dialog to assign the specific permission you want service principal to have.
    
    ```
    [!Note]
    Service principal represents the user, group, or application you're assigning the policy to.
    
    ```
5.  Select **Add** to save and apply the access policy.

You can complete this activity using a saved template, PowerShell, CLI, and the Azure portal.

### Assign a Key Vault access using Role-based access control (RBAC)

Azure RBAC allows users to manage Key, Secrets, and Certificates permissions. It provides one place to manage all permissions across all key vaults. The Azure RBAC model allows you to set permissions on different scope levels: management group, subscription, resource group, or individual resources. Azure RBAC for key vault also enables you to have separate permissions on individual keys, secrets, and certificates. Our recommendation is to use a vault per application per environment (Development, Pre-Production, and Production).

There are two actions required to use roles to access data within your Key Vault.

1.  Enable role-based access control in your key vault.
    
    :::image type="content" source="../media/key-vault-role-based-access-fa8cd616.png" alt-text="Screenshot of the key vault access policies screen, with the allow role-based access control selected.":::
    
2.  Open key vault **Identity and Access (IAM)** from the menu. Then assign the role as you've done in other scenarios; like managed identity.
    
    :::image type="content" source="../media/key-vault-assign-role-589cce50.png" alt-text="Screenshot of the key vault management screen with the Identity and Access (IAM) screen open.  Ready to assign a role.":::
    

| **Built-in role**                        | **Description**                                                                                                                                                                 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Key Vault Administrator                  | Perform all data plane operations on a key vault and all objects in it, including certificates, keys, and secrets. Can't manage key vault resources or manage role assignments. |
| Key Vault Certificates Officer           | Perform any action on the certificates of a key vault, except manage permissions.                                                                                               |
| Key Vault Crypto Officer                 | Perform any action on the keys of a key vault, except manage permissions.                                                                                                       |
| Key Vault Crypto Service Encryption User | Read metadata of keys and perform wrap/unwrap operations.                                                                                                                       |
| Key Vault Crypto User                    | Perform cryptographic operations using keys.                                                                                                                                    |
| Key Vault Reader                         | Read metadata of key vaults and its certificates, keys, and secrets. Can't read sensitive values such as secret contents or key material.                                       |
| Key Vault Secrets Officer                | Perform any action on the secrets of a key vault, except manage permissions.                                                                                                    |
| Key Vault Secrets User                   | Read secret contents.                                                                                                                                                           |
