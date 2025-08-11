Before using eDiscovery to search for content, certain roles and access must be assigned to ensure users can view cases, create searches, and export results. These prerequisites help maintain a secure and auditable investigation process.

## Required roles

**Global** and **Compliance Administrators** can't access eDiscovery cases or search user content unless they're explicitly assigned to the **eDiscovery Manager** or **eDiscovery Administrator** role group. This permission model ensures that access to sensitive data is intentional and auditable.

To access eDiscovery, users need to be assigned one of the following roles:

- **eDiscovery Manager**: Allows users to create and manage eDiscovery cases, run content searches, and export results.
- **eDiscovery Administrator**: Includes all eDiscovery Manager permissions, plus the ability to manage role assignments and settings across all cases.

These roles can be assigned in the Microsoft Purview portal under **Permissions > Roles**.

## Assign users to eDiscovery roles

Administrators can assign users to eDiscovery roles by doing the following:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), select **Settings** > **Roles and Scopes** > **Role groups**.
1. Search for and select the appropriate eDiscovery role group.
1. Add users or groups to the role group.

Once assigned, users might need to sign out and sign back in to see the eDiscovery interface.

## Confirm access to eDiscovery

To verify that the role assignment was successful:

1. Open the Microsoft Purview portal.
1. In the left-hand navigation, select **eDiscovery**.
1. The **Cases** page should load. If not, confirm the user has been assigned the appropriate role and that the Microsoft 365 license includes eDiscovery access.

With the right roles and access in place, users can begin creating cases and searching for content across Microsoft 365 workloads.
