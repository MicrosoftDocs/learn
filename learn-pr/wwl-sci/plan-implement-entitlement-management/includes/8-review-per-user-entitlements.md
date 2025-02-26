In Microsoft Entra entitlement management, you can see who has been assigned to access packages, their policy, and status. If an access package has an appropriate policy, you can also directly assign user to an access package. This article describes how to view, add, and remove assignments for access packages.

## Governance

Following the rules of **zero trust** you review your entitlement packages regularly. There are tools built into the system to support this review.

## View who has an assignment

**Required role**

 -  Global administrator
 -  Identity Governance administrator
 -  User administrator
 -  Catalog owner
 -  Access package manager
 -  Access package assignment manager

Follow these steps to review assignments:

1.  In the Microsoft Entra admin center, select **ID Governance** and then select **Entitlement management**.
2.  In the left menu, select **Access packages** and then open the access package.
3.  select Assignments to see a list of active assignments.
    
    :::image type="content" source="../media/per-user-entitlement-review-d96223b3.png" alt-text="Screenshot of the list of user in the access package, and their usage status of the entitlement.":::
    
4.  select a specific assignment to see additional details.
5.  To see a list of assignments that did not have all resource roles properly provisioned, select the filter status and select **Delivering**.
    
    
     -  You can see additional details on delivery errors by locating the user's corresponding request on the Requests page.
6.  To see expired assignments, select the filter status and select **Expired**.
7.  To download a **CSV file** of the filtered list, select **Download**.

## Review the assignments with PowerShell

You can perform a query in PowerShell to get the per-user list of assignments. This can help with scripting and automation of the management tasks.

PowerShell

```
Connect-MgGraph -Scopes "EntitlementManagement.Read.All"
Select-MgProfile -Name "beta"
$accesspackage = Get-MgEntitlementManagementAccessPackage -DisplayNameEq "Marketing Campaign"
$assignments = Get-MgEntitlementManagementAccessPackageAssignment -AccessPackageId $accesspackage.Id -ExpandProperty target -All -ErrorAction Stop
$assignments | ft Id,AssignmentState,TargetId,{$_.Target.DisplayName}



```

## Remove an assignment

If you find an assignment that is out of date, take action. You can remove an assignment that a user or an administrator had previously requested.

1.  In the Microsoft Entra admin center, select **ID Governance** and then select **Entitlement management**.
2.  In the left menu, select **Access packages** and then open the access package.
3.  In the left menu, select **Assignments**.
4.  select the check box next to the user whose assignment you want to remove from the access package.
5.  select the **Remove** button near the top of the left pane.
