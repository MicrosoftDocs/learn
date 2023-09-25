## Change group license assignment

1.  Browse to the Azure Active Directory page of the [Azure portal](https://portal.azure.com/).
2.  In the left navigation, under **Manage**, select **Groups**.
3.  Select one of the available groups. For example, Marketing.
4.  In the left navigation, under **Manage**, select **Licenses**.
5.  Review the current assignments and then, on the menu, select **+ Assignments**.
    
    :::image type="content" source="../media/change-group-license-4fac5a1d-48876c4a.png" alt-text="Screenshot of the group license page in Azure A D. The plus Assignments option is selected with the current licenses for Office 365 and Windows 10 being added to the group.":::
    
6.  On the Update license assignments page, select another license, clear the selection of an existing license, add or remove license options, or any combination.
7.  When complete, select **Save**.
8.  On the group’s Licenses page, review the change.

## Identify and resolve license assignment problems for a group in Azure Active Directory

Group-based licensing in Azure Active Directory (Azure AD) introduces the concept of users in a licensing error state. In this section, we explain the reasons why users might end up in this state.

When you assign licenses directly to individual users, without using group-based licensing, the assignment operation might fail. For example, when you execute the PowerShell cmdlet `Set-MsolUserLicense` on a user object, the cmdlet can fail for many reasons that are related to business logic. For example, there might be an insufficient number of licenses or a conflict between two service plans that can't be assigned at the same time. The problem is immediately reported back to you.

When you're using group-based licensing the same errors can occur, but they happen in the background while the Azure AD service is assigning licenses. For this reason, the errors can't be communicated to you immediately. Instead, they're recorded on the user object and then reported via the administrative portal. The original intent to license the user is never lost, but it's recorded in an error state for future investigation and resolution.

## Find license assignment errors

### To find users in an error state in a group

1.  Open the group to its overview page and select **Licenses**. A notification appears if there are any users in an error state.
    
    :::image type="content" source="../media/group-error-notification-919e1667-eb52e2c8.png" alt-text="Screenshot of the Group and error notifications message.  There is a yellow message bar at the top of screen announcing that two users in the group have license assignment errors.  There is an arrow to select to get more information.":::
    
2.  Select the notification to open a list of all affected users. You can select each user individually to see more details.
    
    :::image type="content" source="../media/list-of-users-with-errors-381fee9b-d7cf49ad.png" alt-text="Screenshot of the list of users in group licensing error state. This dialog was opened by selecting the more information arrow from the previous dialog. Conflicting service plan is listed as the most likely cause of the error.":::
    
3.  To find all groups that contain at least one error, on the **Azure Active Directory** page menu select **Licenses**, and then select **Overview**. An information box is displayed when groups require your attention.
    
    :::image type="content" source="../media/group-errors-widget-3f3842a5-3ed2baf8.png" alt-text="Screenshot of the Azure A D licenses Overview page.  This dialog shows information about license and if any group licenses are in error state.  The dialog shows one group license in error, and that can be selected.":::
    
4.  Select the box to see a list of all groups with errors. You can select each group for more details.
    
    :::image type="content" source="../media/list-of-groups-with-errors-416fb081-439f81a6.png" alt-text="Screenshot of the group license assignment error page that is displayed after selecting the error in the previous dialog. There is one error listed for Office 365 E1.":::
    

The following sections give descriptions of each potential problem and the way to resolve it.

## Not enough licenses

**Problem**: There aren't enough available licenses for one of the products that's specified in the group. You need to either purchase more licenses for the product or free up unused licenses from other users or groups.

To see how many licenses are available, go to **Azure Active Directory**, then **Licenses**, then **All products**.

To see which users and groups are consuming licenses, select a product. Under **Licensed users**, you see a list of all users who have had licenses assigned directly or via one or more groups. Under **Licensed groups**, you see all groups with product licenses assigned.

**PowerShell**: PowerShell cmdlets report this error as *CountViolation*.

## Service plans that conflict

**Problem**: One of the products that's specified in the group contains a service plan that conflicts with another service plan that's already assigned to the user via a different product. Some service plans are configured in a way that they can't be assigned to the same user as another, related service plan.

Consider the following example. A user has a license for Office 365 Enterprise *E1* assigned directly, with all the plans enabled. The user has been added to a group that has the Office 365 Enterprise *E3* product assigned to it. The E3 product contains service plans that can't overlap with the plans that are included in E1, so the group license assignment fails with the **Conflicting service plans** error. In this example, the conflicting service plans are:

 -  SharePoint Online (Plan 2) conflicts with SharePoint Online (Plan 1).
 -  Exchange Online (Plan 2) conflicts with Exchange Online (Plan 1).

To solve this conflict, you need to disable two of the plans. You can disable the E1 license that's directly assigned to the user. Or, you need to modify the entire group license assignment and disable the plans in the E3 license. Alternatively, you might decide to remove the E1 license from the user if it's redundant in the context of the E3 license.

The decision about how to resolve conflicting product licenses always belongs to the administrator. Azure AD doesn't automatically resolve license conflicts.

**PowerShell**: PowerShell cmdlets report this error as *MutuallyExclusiveViolation*.

## Other products depend on this license

**Problem**: One of the products that's specified in the group contains a service plan that must be enabled for another service plan, in another product, to function. This error occurs when Azure AD attempts to remove the underlying service plan. For example, this can happen when you remove the user from the group.

To solve this problem, you need to make sure that the required plan is still assigned to users through some other method or that the dependent services are disabled for those users. After doing that, you can properly remove the group license from those users.

**PowerShell**: PowerShell cmdlets report this error as *DependencyViolation*.

## Usage location isn't allowed

**Problem**: Some Microsoft services aren't available in all locations because of local laws and regulations. Before you can assign a license to a user, you must specify the **Usage location** property for the user. You can specify the location under the **User**, then **Profile**, then **Edit** the section in the Azure portal.

When Azure AD attempts to assign a group license to a user whose usage location isn't supported, it fails and records an error on the user.

To solve this problem, remove users from unsupported locations from the licensed group. Alternatively, if the current usage location values don't represent the actual user location, you can modify them so that the licenses are correctly assigned next time (if the new location is supported).

**PowerShell**: PowerShell cmdlets report this error as *ProhibitedInUsageLocationViolation*.

> [!NOTE]
> When Azure AD assigns group licenses, any users without a specified usage location inherit the location of the directory. We recommend that administrators set the correct usage location values on users before using group-based licensing to comply with local laws and regulations.

## Duplicate proxy addresses

If you use Exchange Online, some users in your organization might be incorrectly configured with the same proxy address value. When group-based licensing tries to assign a license to such a user, it fails and shows “Proxy address is already being used.”

After you resolve any proxy address problems for the affected users, make sure to force license processing on the group to ensure that the licenses can now be applied.

## Azure AD Mail and ProxyAddresses attribute change

**Problem**: While updating license assignment on a user or a group, you might see that the Azure AD Mail and ProxyAddresses attribute of some users are changed.

Updating license assignment on a user causes the proxy address calculation to be triggered, which can change user attributes.

## LicenseAssignmentAttributeConcurrencyException in audit logs

**Problem**: User has LicenseAssignmentAttributeConcurrencyException for license assignment in audit logs. When group-based licensing tries to process concurrent license assignment of the same license to a user, this exception is recorded on the user. This typically happens when a user is a member of more than one group with same assigned license. Azure AD will retry processing the user license and will resolve the issue. There is no action required from the customer to fix this issue.

## More than one product license assigned to a group

You can assign more than one product license to a group. For example, you can assign Office 365 Enterprise E3 and Enterprise Mobility + Security to a group to easily enable all included services for users.

Azure AD attempts to assign all licenses that are specified in the group to each user. If Azure AD can't assign one of the products because of business logic problems, it won't assign the other licenses in the group either. An example is if there aren't enough licenses for all, or if there are conflicts with other services that are enabled on the user.

You can see the users who failed to get assigned and check which products are affected by this problem.

## When a licensed group is deleted

You must remove all licenses assigned to a group before you can delete the group. However, removing licenses from all the users in the group may take time. There can be failures if user has a dependent license assigned. If a user has a license that is dependent on a license which is being removed due to group deletion, the license assignment to the user is converted from inherited to direct.

For example, consider a group that has Office 365 E3/E5 assigned with a Skype for Business service plan enabled. Also imagine that a few members of the group have Audio Conferencing licenses assigned directly. When the group is deleted, group-based licensing will try to remove Office 365 E3/E5 from all users. Because Audio Conferencing is dependent on Skype for Business, for any users with Audio Conferencing assigned, group-based licensing converts the Office 365 E3/E5 licenses to direct license assignment.

## Manage licenses for products with prerequisites

Some Microsoft Online products you might own are *add-ons*. Add-ons require a prerequisite service plan to be enabled for a user or a group before they can be assigned a license. With group-based licensing, the system requires that both the prerequisite and add-on service plans be present in the same group to ensure that any users who are added to the group can receive the fully working product. Let's consider the following example:

Microsoft Workplace Analytics is an add-on product. It contains a single service plan with the same name. We can only assign this service plan to a user, or group, when one of the following prerequisites is also assigned:

 -  Exchange Online (Plan 1)
 -  Exchange Online (Plan 2)

If we try to assign this product on its own to a group, the portal returns a notification message. If we select the item details, it shows the following error message:

License operation failed. Make sure that the group has necessary services before adding or removing a dependent service. **The service Microsoft Workplace Analytics requires Exchange Online (Plan 2) to be enabled as well**.

To assign this add-on license to a group, we must ensure that the group also contains the prerequisite service plan. For example, we might update an existing group that already contains the full Office 365 E3 product, and then add the add-on product to it.

It is also possible to create a standalone group that contains only the minimum required products to make the add-on work. It can then be used to license only selected users for the add-on product. Based on the previous example, you would assign the following products to the same group:

 -  Office 365 Enterprise E3 with only the Exchange Online (Plan 2) service plan enabled
 -  Microsoft Workplace Analytics

From now on, any users added to this group consume one license of the E3 product and one license of the Workplace Analytics product. At the same time, those users can be members of another group that gives them the full E3 product, and they still consume only one license for that product.

> [!TIP]
> You can create multiple groups for each prerequisite service plan. For example, if you use both Office 365 Enterprise E1 and Office 365 Enterprise E3 for your users, you can create two groups to license Microsoft Workplace Analytics: one that uses E1 as a prerequisite and the other that uses E3. This lets you distribute the add-on to E1 and E3 users without consuming additional licenses.

## Force the group license process to resolve errors

Depending on what steps you've taken to resolve the errors, it might be necessary to manually trigger the processing of a group to update the user state.

For example, if you free up some licenses by removing direct license assignments from users, you need to trigger the processing of groups that previously failed to fully license all user members. To reprocess a group, go to the group pane, open **Licenses**, and then select the **Reprocess** button on the toolbar.

## Force the user license process to resolve errors

Depending on what steps you've taken to resolve the errors, it might be necessary to manually trigger the processing of a user to update the user's state.

For example, after you resolve duplicate proxy address problem for an affected user, you need to trigger the processing of the user. To reprocess a user, go to the user pane, open **Licenses**, and then select the **Reprocess** button on the toolbar.

## How to migrate users with individual licenses to group licenses

You may have existing licenses deployed to users in the organizations via direct assignment; that is, using PowerShell scripts or other tools to assign individual user licenses. Before you begin using group-based licensing to manage licenses in your organization, you can use this migration plan to seamlessly replace existing solutions with group-based licensing.

Keep in mind that you should avoid a situation in which migrating to group-based licensing will result in users temporarily losing their currently assigned licenses. Any process that may result in removal of licenses should be avoided to remove the risk of users losing access to services and their data.

### Recommended migration process

1.  You have existing automation (for example, PowerShell) managing license assignment and removal for users. Leave it running as is.
2.  Create a new licensing group (or decide which existing groups to use) and make sure that all required users are added as members.
3.  Assign the required licenses to those groups; your goal should be to reflect the same licensing state your existing automation (for example, PowerShell) is applying to those users.
4.  Verify that licenses have been applied to all users in those groups. This application can be done by checking the processing state on each group and by checking Audit Logs.
    
    
     -  You can perform a random check of a few individual users by looking at their license details. You will see that they have the same licenses assigned “directly” and “inherited” from groups.
     -  You can run a PowerShell script to [verify how licenses are assigned to users](/azure/active-directory/enterprise-users/licensing-group-advanced).
     -  When the same product license is assigned to the user both directly and through a group, only one license is consumed by the user. Hence no additional licenses are required to perform migration.
5.  Verify that no license assignments failed by checking each group for users in error state.

Consider removing the original direct assignments. We recommend that you do it gradually, and monitor the outcome on a subset of users first. If you leave the original direct assignments on users, when the users leave their licensed groups they retain the directly assigned licenses, which might not be what you want.

### An example

An organization has 1,000 users. All users require Office 365 Enterprise E3 licenses. Currently the organization has a PowerShell script running on premises, adding and removing licenses from users as they come and go. However, the organization wants to replace the script with group-based licensing so licenses can be managed automatically by Azure AD.

Here is what the migration process could look like:

1.  Using the Azure portal, assign the Office 365 E3 license to the **All users** group in Azure AD.
2.  Confirm that license assignment has completed for all users. Go to the overview page for the group, select **Licenses**, and check the processing status at the top of the **Licenses** page.
    
    
     -  Look for “Latest license changes have been applied to all users" to confirm processing has completed.
     -  Look for a notification on top about any users for whom licenses may have not been successfully assigned. Did we run out of licenses for some users? Do some users have conflicting license plans that prevent them from inheriting group licenses?
3.  You need to check a few users to verify that they have both the direct and group licenses applied. Go to the profile page for a user, select Licenses, and examine the state of licenses.
    
    
     -  This is the expected user state during migration:
        
        :::image type="content" source="../media/expected-user-state-45157e0a-fff2becf.png" alt-text="Screenshot of the Licenses page in Azure A D.  The Office 365 E3 license is highlighted.  In the assignment paths column the license has direct assignments to some users, and that it has inherited users from a group named AniGroup). This is the expected user state during migration.":::
        
4.  After confirming that both direct and group licenses are equivalent, you can start removing direct licenses from users. You can test this by removing them for individual users in the portal and then run automation scripts to have them removed in bulk. Here is an example of the same user with the direct licenses removed through the portal. Notice that the license state remains unchanged, but we no longer see direct assignments.
    
    :::image type="content" source="../media/direct-licenses-removed-d550929e-618390d3.png" alt-text="Screenshot of the Licenses page in Azure A D after the migration is completed.  Office 365 E3 license is highlighted. We have confirmation that direct licenses are removed.":::
    

## Change license assignments for a user or group in Azure Active Directory

This section describes how to move users and groups between service license plans in Azure Active Directory (Azure AD). The goal Azure AD's approach is to ensure that there's no loss of service or data during the license change. Users should switch between services seamlessly. The license plan assignment steps in this section describe changing a user or group on Office 365 E1 to Office 365 E3, but the steps apply to all license plans. When you update license assignments for a user or group, the license assignment removals and new assignments are made simultaneously so that users do not lose access to their services during license changes or see license conflicts between plans.

Before you update the license assignments, verify certain assumptions are true for all of the users or groups to be updated. If the assumptions aren't true for all of the users in a group, the migration might fail for some. As a result, some of the users might lose access to services or data. Ensure that:

 -  Users have the current license plan that's assigned to a group and inherited by the user and not assigned directly.
 -  You have enough available licenses for the license plan you're assigning. If you don't have enough licenses, some users might not be assigned the new license plan. You can check the number of available licenses.
 -  Always confirm users don't have assigned service licenses that can conflict with the desired license or prevent removal of the current license. For example, a license from a service such as Workplace Analytics or Project Online that has a dependency on other services.
 -  If you manage groups on-premises and sync them into Azure AD via Azure AD Connect, then you add or remove users by using your on-premises system. It can take some time for the changes to sync with Azure AD to be picked up by group licensing.
 -  If you're using Azure AD dynamic group memberships, you add or remove users by changing their attributes, but the update process for license assignments remains the same.
