This guided project consists of the following exercises:

 - Create user and group
 - **Assign RBAC role at scope**
 - Verify least-privilege model

In this exercise, you assign the Reader role to your security group at the resource group scope. This single assignment gives every member of the group permission to view resources — demonstrating how group-based RBAC simplifies access management.

This exercise includes the following tasks:

 - Assign Reader role to the group

**Outcome:** Group-based Reader access assigned at resource group scope.

## Task 1: Assign Reader role to the group

Grant the Reader role to your security group at the resource group scope. This gives all members of the group permission to view resources but not to create, modify, or delete them — implementing the principle of least privilege.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-access-model** from the list.
3.  In the left menu, select **Access control (IAM)**.
4.  Select **+ Add** and then select **Add role assignment**.
5.  On the **Role** tab, search for **Reader** in the search box.
6.  Select **Reader** from the results and then select **Next**.
7.  On the **Members** tab, for **Assign access to**, confirm **User, group, or service principal** is selected.
8.  Select **+ Select members**.
9.  In the search box, search for **gp-rg-readers** and select it from the results.
10. Select **Select** to confirm the member selection.
11. Select **Review + assign**.
12. On the review page, confirm the role is **Reader**, the scope is **rg-gp-access-model**, and the member is **gp-rg-readers**.
13. Select **Review + assign** again to complete the assignment.

> [!NOTE]
> **Validation step:** Confirm the Reader role is assigned to **gp-rg-readers** at the resource group scope. Select the **Role assignments** tab on the **Access control (IAM)** page to verify.

> [!NOTE]
