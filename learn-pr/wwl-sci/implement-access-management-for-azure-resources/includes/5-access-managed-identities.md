
Managed identities for Azure resources are a feature of Azure Active Directory. Each Azure service that supports managed-identities are subject to their own timeline. Make sure you review the availability status of managed identities for your resource and known issues before you begin. After you've configured an Azure resource with a managed identity, you can give the managed identity access to another resource.

### Add access to other resources

After you've enabled managed identity on an Azure resource, such as an Azure App Service application or Azure virtual machine, you may need to grant access to more resource. Let's say you want add access to a storage account to your managed identity.

1.  Sign in to the Azure portal using an account associated with the Azure subscription under which you've configured the managed identity.
2.  Navigate to the desired resource on which you want to modify access control. In this example, we're giving an Azure virtual machine access to a storage account, so we navigate to the storage account.
3.  Select Access control (IAM).
4.  Select Add &gt; Add role assignment to open the Add role assignment page.
    
    :::image type="content" source="../media/managed-identity-role-assignment-60e02730.png" alt-text="Screenshot of the Azure portal in the storage account page, adding a new role to a managed identity.":::
    
5.  Pick the Owner, Contributor, or Reader based on the least privilege rules for your applications needs.
6.  Select the managed identity you want assigned.
    
    :::image type="content" source="../media/managed-identity-select-8adf45e1.png" alt-text="Screenshot of the Azure portal in the storage account page, choose the managed identity to grant role and access to.":::
    
7.  Complete the assignment with the **Review + assign** option.
