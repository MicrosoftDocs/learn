This guided project consists of the following exercises:

 - **Apply cost-tracking tags**
 - Create budget and alerts
 - Assign and test Azure Policy

In this exercise, you create a resource group and storage account, then apply organizational tags to both. Tags are the foundation of cost governance—they let you categorize resources by team, environment, or project so you can track spending accurately.

This exercise includes the following tasks:

 - Prepare the environment
 - Create a test storage account
 - Tag the resource group
 - Tag the storage account

**Outcome:** Tagged pilot resources ready for cost reporting and filtering.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment before you begin. You create a resource group and a test resource as a pilot scope for governance controls.

> [!WARNING]
> This project creates Azure resources that may incur charges. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create budgets and policy assignments.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**.
4.  For **Name**, enter **rg-gp-cost-guardrails**.
5.  For **Region**, choose your preferred region.
6.  Select **Review + create** and then select **Create**.
7.  Note the email address you want to use for budget alert notifications.

## Task 2: Create a test storage account

Create a storage account inside the resource group. This gives you a resource to tag and a scope for policy testing.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the **Basics** tab, select **rg-gp-cost-guardrails** as the resource group.
4.  For **Storage account name**, enter a globally unique name (for example, **stgpcostguard** followed by your initials and a number).
5.  For **Region**, use the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then select **Create**.
10. When deployment finishes, select **Go to resource**.

## Task 3: Tag the resource group

Apply organizational tags to your resource group. Tags are key-value pairs that help you categorize resources, track costs, and enforce policies at scale.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-cost-guardrails** from the list.
3.  In the left menu, select **Tags**.
4.  Add the tag **environment** with the value **pilot**.
5.  Add the tag **owner** with the value **it-team**.
6.  Select **Apply**.

> [!NOTE]
> **Validation step:** Confirm the resource group displays both tags (**environment: pilot** and **owner: it-team**).

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go—you'll review them all in the validation unit at the end of this module.

## Task 4: Tag the storage account

Apply the same tags to your test resource. Resource-level tags ensure consistent tagging across all assets, enabling accurate cost allocation and governance reporting.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select the storage account you created (for example, **stgpcostguard**).
3.  In the left menu, select **Tags**.
4.  Add the tag **environment** with the value **pilot**.
5.  Add the tag **owner** with the value **it-team**.
6.  Select **Apply**.

> [!NOTE]
> **Validation step:** Confirm the storage account also displays both tags, matching the resource group.

> [!NOTE]
