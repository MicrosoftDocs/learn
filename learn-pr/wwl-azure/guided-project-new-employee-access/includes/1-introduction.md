This guided project focuses on setting up identity and access for a new employee using Microsoft Entra ID and Azure role-based access control (RBAC).

Microsoft Entra ID is the identity service that manages users and groups in Azure. RBAC lets you assign specific permissions at a specific scope, so users get exactly the access they need and nothing more. Together, they implement the principle of least privilege.

## Scenario

A new support analyst is joining your team and needs read-only access to a development resource group. You create the user account, add them to a security group, assign the Reader role at the resource group scope, and then sign in as the new user to verify that least-privilege access works as expected.

- Exercise 1 - Create a user account and security group in Entra ID.
- Exercise 2 - Assign the Reader role to the group at resource group scope.
- Exercise 3 - Verify that read access is granted and write access is denied.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing the identity and access flow from Entra ID user and group through RBAC role assignment to resource group scope." border="false":::

By the end of this project, you have hands-on experience creating identities, assigning group-based RBAC, and validating access controls.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Manage identities in Entra ID**
+ Create a security group.
+ Create a user account.
+ Add a user to a group.

**Assign Azure RBAC roles**
+ Assign a built-in role to a group at resource group scope.
+ Understand scope inheritance and the Reader role.

**Validate access and audit changes**
+ Use Check access to preview effective permissions.
+ Review role assignment events in the Activity Log.
+ Enable and generate a Temporary Access Pass (TAP).
+ Sign in as the new user and test permissions firsthand.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
