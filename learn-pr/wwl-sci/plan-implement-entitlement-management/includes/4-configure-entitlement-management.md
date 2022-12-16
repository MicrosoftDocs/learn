There are several ways that you can configure entitlement management for your organization. However, if you're just getting started, it's helpful to understand the common scenarios for administrators, catalog owners, access package managers, approvers, and requestors.

 -  Delegate
    
    
     -  Administrator: Delegate management of resources.
     -  Catalog creator: Delegate management of resources.
     -  Catalog owner: Delegate management of resources.
     -  Catalog owner: Delegate management of access packages via assigning the access package manager role.
 -  Govern access for users in your organization
    
    
     -  Access package manager: Allow employees in your organization to request access to resources.
     -  Requestor: Request access to resources.
     -  Approver: Approve requests to resources.
     -  Requestor: View the resources you already have access to.
 -  Govern access for users outside your organization
    
    
     -  Administrator: Collaborate with an external partner organization.
     -  Access package manager: Collaborate with an external partner organization.
     -  Requestor: Request access to resources as an external user.
     -  Approver: Approve requests to resources.
     -  Requestor: View the resources your already have access to.
 -  Day-to-day management
    
    
     -  Access package manager: Update the resources for a project.
     -  Access package manager: Update the duration for a project.
     -  Access package manager: Update how access is approved for a project.
     -  Access package manager: Update the people for a project.
     -  Access package manager: Directly assign specific users to an access package.
 -  Assignments and reports
    
    
     -  Administrator: View who has assignments to an access package.
     -  Administrator: View resources assigned to users.

## Programmatic administration

You can also manage access packages, catalogs, policies, requests, and assignments using Microsoft Graph. A user in an appropriate role with an application that has the delegated `EntitlementManagement.ReadWrite.All` permission can call the [entitlement management API](/graph/tutorial-access-package-api).
