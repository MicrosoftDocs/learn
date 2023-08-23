This section describes various operations you can perform by using Azure Active Directory (Azure AD) Connect Health.

## Enable email notifications

You can configure the Azure AD Connect Health service to send email notifications when alerts indicate that your identity infrastructure is not healthy. This occurs when an alert is generated, and when it is resolved.

:::image type="content" source="../media/email-notifications-discover-697eb478.png" alt-text="Screenshot of Azure A D Connect Health email notification settings. Enter your admin's email.":::


> [!NOTE]
> Email notifications are enabled by default.

### To enable Azure AD Connect Health email notifications

1.  Open the **Alerts** blade for the service for which you want to receive email notification.
2.  From the action bar, click **Notification Settings**.
3.  At the email notification switch, select **ON**.
4.  Select the check box if you want all global administrators to receive email notifications.
5.  If you want to receive email notifications at any other email addresses, specify them in the **Additional Email Recipients** box. To remove an email address from this list, right-click the entry and select **Delete**.
6.  To finalize the changes, click **Save**. Changes take effect only after you save.

> [!NOTE]
> When there are issues processing synchronization requests in our back-end service, this service sends a notification email with the details of the error to the administrative contact email address(es) of your tenant. We heard feedback from customers that in certain cases the volume of these messages is prohibitively large so we are changing the way we send these messages.

Instead of sending a message for every sync error every time it occurs we will send out a daily digest of all errors the back-end service has returned. This enables customers to process these errors in a more efficient manner and reduces the number of duplicate error messages.

## Delete a server or service instance

> [!NOTE]
> Azure AD premium license is required for the deletion steps.

In some instances, you might want to remove a server from being monitored. Here's what you need to know to remove a server from the Azure AD Connect Health service.

When you're deleting a server, be aware of the following:

 -  This action stops collecting any further data from that server. This server is removed from the monitoring service. After this action, you are not able to view new alerts, monitoring, or usage analytics data for this server.
 -  This action does not uninstall the Health Agent from your server. If you have not uninstalled the Health Agent before performing this step, you might see errors related to the Health Agent on the server.
 -  This action does not delete the data already collected from this server. That data is deleted in accordance with the Azure data retention policy.
 -  After performing this action, if you want to start monitoring the same server again, you must uninstall and reinstall the Health Agent on this server.

### Delete a server from the Azure AD Connect Health service

> [!NOTE]
> Azure AD premium license is required for the deletion steps.

Azure AD Connect Health for Active Directory Federation Services (AD FS) and Azure AD Connect (Sync):

1.  Open the **Server** blade from the **Server List** blade by selecting the server name to be removed.
2.  On the **Server** blade, from the action bar, click **Delete**.
    
    :::image type="content" source="../media/delete-server-2-1e9e75dc.png" alt-text="Screenshot of Azure A D Connect Health delete server.  Only keep servers that are active.":::
    
3.  Confirm by typing the server name in the confirmation box.
4.  Click **Delete**.

Azure AD Connect Health for Azure Active Directory Domain Services:

1.  Open the **Domain Controllers** dashboard.
2.  Select the domain controller to be removed.
3.  From the action bar, click **Delete Selected**.
4.  Confirm the action to delete the server.
5.  Click **Delete**.

### Delete a service instance from Azure AD Connect Health service

In some instances, you might want to remove a service instance. Here's what you need to know to remove a service instance from the Azure AD Connect Health service.

When you're deleting a service instance, be aware of the following:

 -  This action removes the current service instance from the monitoring service.
 -  This action does not uninstall or remove the Health Agent from any of the servers that were monitored as part of this service instance. If you have not uninstalled the Health Agent before performing this step, you might see errors related to the Health Agent on the servers.
 -  All data from this service instance is deleted in accordance with the Azure data retention policy.
 -  After performing this action, if you want to start monitoring the service, uninstall and reinstall the Health Agent on all the servers. After performing this action, if you want to start monitoring the same server again, uninstall, reinstall, and register the Health Agent on that server.

### To delete a service instance from the Azure AD Connect Health service

1.  Open the **Service** blade from the **Service List** blade by selecting the service identifier (farm name) that you want to remove.
2.  On the **Service** blade, from the action bar, click **Delete**.
    
    :::image type="content" source="../media/delete-server-9ebbd5de.png" alt-text="Screenshot of Azure A D Connect Health delete service.  Remove unwanted services.":::
    
3.  Confirm by typing the service name in the confirmation box (for example: sts.contoso.com).
4.  Click **Delete**.

## Manage access with Azure Role Based Access Control

[Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/role-assignments-portal) for Azure AD Connect Health provides access to users and groups other than global administrators. Azure RBAC assigns roles to the intended users and groups, and provides a mechanism to limit the global administrators within your directory.

### Roles

Azure AD Connect Health supports the following built-in roles:

| **Role**    | **Permissions**                                                                                                                                                                                                                                                                                                                        |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Owner       | Owners can *manage access* (for example, assign a role to a user or group), *view all information* (for example, view alerts) from the portal, and *change settings* (for example, email notifications) within Azure AD Connect Health. By default, Azure AD global administrators are assigned this role, and this cannot be changed. |
| Contributor | Contributors can *view all information* (for example, view alerts) from the portal, and *change settings* (for example, email notifications) within Azure AD Connect Health.                                                                                                                                                           |
| Reader      | Readers can *view all information* (for example, view alerts) from the portal within Azure AD Connect Health.                                                                                                                                                                                                                          |

All other roles (such as User Access Administrators or DevTest Labs Users) have no impact to access within Azure AD Connect Health, even if the roles are available in the portal experience.

### Access scope

Azure AD Connect Health supports managing access at two levels:

 -  **All service instances**: This is the recommended path in most cases. It controls access for all service instances (for example, an AD FS farm) across all role types that are being monitored by Azure AD Connect Health.
 -  **Service instance**: In some cases, you might need to segregate access based on role types or by a service instance. In this case, you can manage access at the service instance level.

Permission is granted if an end user has access either at the directory or service instance level.

### Allow users or groups access to Azure AD Connect Health

The following steps show how to allow access.

**Step 1: Select the appropriate access scope**

To allow a user access at the *all service instances* level within Azure AD Connect Health, open the main blade in Azure AD Connect Health.

**Step 2: Add users and groups, and assign roles**

1.  From the **Configure** section, click **Users**.
    
    :::image type="content" source="../media/start-role-based-access-control-7a8afaa9.png" alt-text="Screenshot of Azure A D Connect Health resource sidebar.  Add the users you need.":::
    
2.  Select **Add**.
3.  In the **Select a role** pane, select a role (for example, **Owner**).
    
    :::image type="content" source="../media/role-based-access-control-add-73b3e096.png" alt-text="Screenshot of Azure A D Connect Health and Azure R B A C configure menu.":::
    
4.  Type the name or identifier of the targeted user or group. You can select one or more users or groups at the same time. Click **Select**.
    
    :::image type="content" source="../media/role-based-access-control-select-users-cdbd95a8.png" alt-text="Screenshot of Azure A D Connect Health and Azure R B A C and new users highlighted.":::
    
5.  Select **OK**.
6.  After the role assignment is complete, the users and groups appear in the list.

Now the listed users and groups have access, according to their assigned roles.

> [!NOTE]
> Global administrators always have full access to all the operations, but global administrator accounts are not present in the preceding list.

 -  The Invite Users feature is not supported within Azure AD Connect Health.

**Step 3: Share the blade location with users or groups**

1.  After you assign permissions, a user can access Azure AD Connect Health by going [here](https://aka.ms/aadconnecthealth).
2.  On the blade, the user can pin the blade, or different parts of it, to the dashboard. Simply click the **Pin to dashboard** icon.
    
    :::image type="content" source="../media/role-based-access-control-pin-blade-171b7351.png" alt-text="Screenshot of Azure A D Connect Health and Azure R B A C pin blade, with pin icon highlighted.":::
    

### Remove users or groups

You can remove a user or a group added to Azure AD Connect Health and Azure RBAC. Simply right-click the user or group, and select **Remove**.

:::image type="content" source="../media/role-based-access-control-remove-460239f8.png" alt-text="Screenshot of Azure A D Connect Health and Azure R B A C with Remove highlighted.":::


## Diagnose and remediate duplicated attribute sync errors<br>

## Overview

Taking one step farther to highlight sync errors, Azure Active Directory (Azure AD) Connect Health introduces self-service remediation. It troubleshoots duplicated attribute sync errors and fixes objects that are orphaned from Azure AD. The diagnosis feature has these benefits:

 -  It provides a diagnostic procedure that narrows down duplicated attribute sync errors. And it gives specific fixes.
 -  It applies a fix for dedicated scenarios from Azure AD to resolve the error in a single step.
 -  No upgrade or configuration is required to enable this feature.

## Problems

### A common scenario

When **QuarantinedAttributeValueMustBeUnique** and **AttributeValueMustBeUnique** sync errors happen, it's common to see a **UserPrincipalName** or **Proxy Addresses** conflict in Azure AD. You might solve the sync errors by updating the conflicting source object from the on-premises side. The sync error will be resolved after the next sync. For example, this image indicates that two users have a conflict of their **UserPrincipalName**. Both are **Joe.J@contoso.com**. The conflicting objects are quarantined in Azure AD.

:::image type="content" source="../media/identity-fix-common-case-526debc8.png" alt-text="Diagram of the Diagnose sync error common scenarios.  Most likely place to see errors.":::


### Orphaned object scenario

Occasionally, you might find that an existing user loses the **Source Anchor**. The deletion of the source object happened in on-premises Active Directory. But the change of deletion signal never got synchronized to Azure AD. This loss happens for reasons like sync engine issues or domain migration. When the same object gets restored or recreated, logically, an existing user should be the user to sync from the **Source Anchor**.

When an existing user is a cloud-only object, you can also see the conflicting user synchronized to Azure AD. The user can't be matched in sync to the existing object. There's no direct way to remap the **Source Anchor**.

As an example, the existing object in Azure AD preserves the license of Joe. A newly synchronized object with a different **Source Anchor** occurs in a duplicated attribute state in Azure AD. Changes for Joe in on-premises Active Directory won't be applied to Joe’s original user (existing object) in Azure AD.

:::image type="content" source="../media/identity-fix-orphaned-case-9d4eccc4.png" alt-text="Screenshot of the Diagnose sync error orphaned object scenario.  Track down objects that are orphaned.":::


## Diagnostic and troubleshooting steps in Connect Health

The diagnose feature supports user objects with the following duplicated attributes:

| **Attribute name**          | **Synchronization error types**                                     |
| --------------------------- | ------------------------------------------------------------------- |
| UserPrincipalName           | QuarantinedAttributeValueMustBeUnique or AttributeValueMustBeUnique |
| ProxyAddresses              | QuarantinedAttributeValueMustBeUnique or AttributeValueMustBeUnique |
| SipProxyAddress             | AttributeValueMustBeUnique                                          |
| OnPremiseSecurityIdentifier | AttributeValueMustBeUnique                                          |

> [!IMPORTANT]
> To access this feature, Global Admin permission, or Contributor permission from Azure RBAC, is required.

Follow the steps from the Azure portal to narrow down the sync error details and provide more specific solutions:

:::image type="content" source="../media/identity-fix-steps-93d07aa5.png" alt-text="Digram of the Sync error diagnosis steps.  Use these steps to reach a resolution.":::


From the Azure portal, take a few steps to identify specific fixable scenarios:

1.  Check the **Diagnose status** column. The status shows if there's a possible way to fix a sync error directly from Azure Active Directory. In other words, a troubleshooting flow exists that can narrow down the error case and potentially fix it.
    
    | **Status**          | **What does it mean?**                                                                                                                                                                                                                                                                                         |
    | ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Not Started         | You haven't visited this diagnosis process. Depending on the diagnostic result, there's a potential way to fix the sync error directly from the portal.                                                                                                                                                        |
    | Manual Fix Required | The error doesn't fit the criteria of available fixes from the portal. Either conflicting object types aren't users, or you already went through the diagnostic steps, and no fix resolution was available from the portal. In the latter case, a fix from the on-premises side is still one of the solutions. |
    | Pending Sync        | A fix was applied. The portal is waiting for the next sync cycle to clear the error.                                                                                                                                                                                                                           |
2.  Select the **Diagnose** button under the error details. You'll answer a few questions and identify the sync error details. Answers to the questions help identify an orphaned object case.
3.  If a **Close** button appears at the end of the diagnostics, there's no quick fix available from the portal based on your answers. Refer to the solution shown in the last step. Fixes from on-premises are still the solutions. Select the **Close** button. The status of the current sync error switches to **Manual fix required**. The status stays during the current sync cycle.
4.  After an orphaned object case is identified, you can fix the duplicated attributes sync errors directly from the portal. To trigger the process, select the **Apply Fix** button. The status of the current sync error updates to **Pending sync**.
5.  After the next sync cycle, the error should be removed from the list.
