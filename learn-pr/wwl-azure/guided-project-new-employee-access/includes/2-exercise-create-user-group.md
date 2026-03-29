This guided project consists of the following exercises:

 - **Create user and group**
 - Assign RBAC role at scope
 - Verify least-privilege model

In this exercise, you create a security group, a new user account, and add the user to the group. This sets up the identity foundation that you assign permissions to in the next exercise.

This exercise includes the following tasks:

 - Prepare the environment
 - Create a test storage account
 - Create the security group
 - Create the user account
 - Add the user to the group

**Outcome:** A new user account and security group are ready for access assignment.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment before you begin. You create a resource group and a test resource as a safe sandbox for practicing access control.

> [!WARNING]
> This project creates Azure resources that may incur charges. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that can manage users and role assignments.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**. Name the resource group **rg-gp-access-model**, choose your preferred region, and select **Review + create** then **Create**.

## Task 2: Create a test storage account

Create a storage account inside the resource group. This resource provides a scope for your RBAC role assignments.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the Basics tab, select **rg-gp-access-model** as the resource group.
4.  For **Storage account name**, enter a globally unique name (for example, **stgpaccessmodel** followed by your initials and a number).
5.  For **Region**, use the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then select **Create**.
10. When deployment finishes, select **Go to resource**.

## Task 3: Create the security group

Set up a security group that serves as a container for your new user. Using groups makes permission management scalable—you assign permissions once to a group, then add or remove users as needed.

1.  In the portal search bar, search for **Microsoft Entra ID** and select **Microsoft Entra ID**.
2.  In the left menu under **Manage**, select **Groups**.
3.  Select **New group**.
3.  For **Group type**, select **Security**.
4.  For **Group name**, enter **gp-rg-readers**.
5.  For **Group description**, enter **Readers for the guided project resource group**.
6.  Select **Create**.

> [!NOTE]
> **Validation step:** Verify the **gp-rg-readers** security group now exists in your tenant.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go—you'll review them all in the validation unit at the end of this module.

## Task 4: Create the user account

Create a new identity in Entra ID for the team member. This user account will be added to the security group, inheriting all permissions assigned to that group.

1.  In the portal search bar, search for **Microsoft Entra ID** and select **Microsoft Entra ID**.
2.  In the left menu under **Manage**, select **Users**.
3.  Select **New user** and then select **Create new user**.
4.  For **User principal name**, enter a unique name (for example, **alexgp**). This is the sign-in name the user would use to access Azure (combined with your tenant domain, it becomes something like **alexgp@yourtenant.onmicrosoft.com**). Record this value—you need it for later validation.
5.  For **Display name**, enter **Alex Guided Project**.
6.  Select **Review + create** and then select **Create**.
7.  The Users list may not refresh automatically. Select **Refresh** to confirm the new user appears in the list.

> [!NOTE]
> **Validation step:** Confirm the new user account is created. Record the user principal name (UPN) for later validation.

## Task 5: Add the user to the group

Complete the group membership by adding the new user. This establishes the connection between the user and the group, so the user now inherits all RBAC permissions assigned to the group.

1.  In the Users list, select the checkbox to the left of **Alex Guided Project**.
2.  In the horizontal menu at the top, select **Edit**.
3.  Select **Add to group**.
4.  Search for and select **gp-rg-readers**, then select **Select**.

> [!NOTE]
> **Validation step:** Confirm the user is now a member of **gp-rg-readers**. Any RBAC permissions assigned to this group will apply to all members.

> [!NOTE]
