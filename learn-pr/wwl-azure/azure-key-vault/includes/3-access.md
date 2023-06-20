Access to a key vault is controlled through two interfaces: the **management plane**, and the **data plane**. The management plane is where you manage Key Vault itself. Operations in this plane include creating and deleting key vaults, retrieving Key Vault properties, and updating access policies. The data plane is where you work with the data stored in a key vault. You can add, delete, and modify keys, secrets, and certificates from here.

:::image type="content" source="../media/az500-key-vault-access-edb72125.png" alt-text="Users and apps authenticate and then are authorized to the management or data plane.":::


To access a key vault in either plane, all callers (users or applications) must have proper authentication and authorization. Authentication establishes the identity of the caller. Authorization determines which operations the caller can execute.

Both planes use Azure AD for authentication. For authorization, the management plane uses RBAC, and the data plane can use either **newly added RBAC** or a Key Vault access policy.

## Active Directory authentication

When you create a key vault in an Azure subscription, its automatically associated with the Azure AD tenant of the subscription. All callers in both planes must register in this tenant and authenticate to access the key vault. In both cases, applications can access Key Vault in two ways:

 -  **User plus application access**. The application accesses Key Vault on behalf of a signed-in user. Examples of this type of access include Azure PowerShell and the Azure portal. User access is granted in two ways. They can either access Key Vault from any application, or they must use a specific application (referred to as compound identity).
 -  **Application-only access**. The application runs as a daemon service or background job. The application identity is granted access to the key vault.

For both types of access, the application authenticates with Azure AD. The application uses any supported authentication method based on the application type. The application acquires a token for a resource in the plane to grant access. The resource is an endpoint in the management or data plane, based on the Azure environment. The application uses the token and sends a REST API request to Key Vault. To learn more, review the whole authentication flow.

## Benefits

The model of a single mechanism for authentication to both planes has several benefits:

 -  Organizations can centrally control access to all key vaults in their organization.
 -  If a user leaves, they instantly lose access to all key vaults in the organization.
 -  Organizations can customize authentication by using the options in Azure AD, such as to enable multifactor authentication for added security.
