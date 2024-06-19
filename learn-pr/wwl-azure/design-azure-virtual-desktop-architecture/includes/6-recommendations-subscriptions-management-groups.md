Some Azure Virtual Desktop procedures, such as installing Office on a master VHD image, assume you have elevated access on the VM, whether it's provisioned in Azure or Hyper-V Manager.

As a Global Administrator in Microsoft Entra ID, you might not have access to all subscriptions and management groups in your directory. Below are methods to elevate access to all subscriptions and management groups.

:::image type="content" source="../media/global-admin-role-a10717c1.png" alt-text="Diagram that shows Global Administrator role in Microsoft Entra ID.":::


## Why would you need to elevate your access?

Global Administrators should consider the following scenarios for elevating access.

 -  Regain access to an Azure subscription or management group when a user has lost access.
 -  Grant another user or yourself access to an Azure subscription or management group.
 -  See all Azure subscriptions or management groups in an organization.
 -  Allow an automation app (such as an invoicing or auditing app) to access all Azure subscriptions or management groups.

## How does elevated access work?

Microsoft Entra ID and Azure resources are secured independently from one another.

Microsoft Entra role assignments do not grant access to Azure resources, and Azure role assignments do not grant access to Microsoft Entra ID. However, if you are a Global Administrator in Microsoft Entra ID, you can assign yourself access to all Azure subscriptions and management groups in your directory. Use this capability if you don't have access to Azure subscription resources. For example, for virtual machines or storage accounts, and you want to use your Global Administrator privilege to gain access to those resources.

When you elevate your access, you will be assigned the User Access Administrator role in Azure at root scope (/). This allows you to view all resources and assign access in any subscription or management group in the directory. User Access Administrator role assignments can be removed using Azure PowerShell, Azure CLI, or the REST API.

You should remove this elevated access once you have made the changes you need to make at root scope.

:::image type="content" source="../media/elevated-access-recommendation-image1-c59d173e.png" alt-text="Elevate access.":::


## Elevate access for a Global Administrator

Follow these steps to elevate access for a Global Administrator using the Azure portal.

1.  Sign in to the Azure portal or the Microsoft Entra admin center as a Global Administrator.
2.  Open **Microsoft Entra ID**.
3.  Under **Manage**, select **Properties**.

:::image type="content" source="../media/elevated-access-recommendation-image2-d645c7e4.png" alt-text="Select Properties for Microsoft Entra properties.":::


4.  Under **Access management for Azure resources**, set the toggle to **Yes**.

:::image type="content" source="../media/elevated-access-recommendation-image3-1f9dd851.png" alt-text="Access management for Azure resources.":::


When you set the toggle to **Yes**, you are assigned the User Access Administrator role in Azure role-based access control (RBAC) at root scope (/). This grants you permission to assign roles in all Azure subscriptions and management groups associated with this Microsoft Entra directory. This toggle is only available to users who are assigned the Global Administrator role in Microsoft Entra ID.

When you set the toggle to **No**, the User Access Administrator role in Azure role-based access control (RBAC) is removed from your user account. You can no longer assign roles in all Azure subscriptions and management groups that are associated with this Microsoft Entra directory. You can view and manage only the Azure subscriptions and management groups to which you have been granted access.

5.  Click **Save** to save your setting.

This setting is not a global property and applies only to the currently signed in user. You can't elevate access for all members of the Global Administrator role.

6.  Sign out and sign back in to refresh your access.

You should now have access to all subscriptions and management groups in your directory. When you view the Access control (IAM) pane, you'll notice that you have been assigned the User Access Administrator role at root scope.

:::image type="content" source="../media/elevated-access-recommendation-image4-3309fa02.png" alt-text="Subscription role assignments with root scope.":::


7.  Make the changes you need to make at elevated access.

## Remove elevated access

To remove the User Access Administrator role assignment at root scope (/), follow these steps.

1.  Sign in as the same user that was used to elevate access.
2.  In the navigation list, click **Microsoft Entra ID** and then click **Properties**.
3.  Set the **Access management for Azure resources** toggle back to **No**. Since this is a per-user setting, you must be signed in as the same user as was used to elevate access.

If you try to remove the User Access Administrator role assignment on the Access control (IAM) pane, you'll see the following message. To remove the role assignment, you must set the toggle back to **No** or use Azure PowerShell, Azure CLI, or the REST API.

:::image type="content" source="../media/elevated-access-recommendation-image5-e717d5cb.png" alt-text="Remove role assignments with root scope.":::


4.  Sign out as Global Administrator.
