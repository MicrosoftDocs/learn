This guided project consists of the following exercises:

 - **Create resources and apply tags**
 - Apply resource locks
 - Test lock enforcement

In this exercise, you create a resource group with two storage accounts and apply organizational tags to each one. You then use tag-based filtering to see how tags help you find and organize resources across a growing environment.

This exercise includes the following tasks:

 - Prepare the environment
 - Create a test storage account
 - Tag the resource group
 - Tag the storage account
 - Create a second storage account with different tags
 - Filter resources by tag

**Outcome:** A resource group and storage account with consistent organizational tags applied.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment before you begin. You create a resource group and a test resource to practice tagging and locking.

> [!WARNING]
> This project creates Azure resources that may incur charges. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create and manage resources.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**. Name the resource group **rg-gp-tags-locks**, choose your preferred region, and select **Review + create** then **Create**.

## Task 2: Create a test storage account

Create a low-cost storage account inside the resource group. This gives you a resource to tag and lock in the following exercises.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the Basics tab, select **rg-gp-tags-locks** as the resource group.
4.  For **Storage account name**, enter a globally unique name (for example, **stgptagslock** followed by your initials and a number).
5.  For **Region**, use the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then select **Create**.
10. When deployment finishes, select **Go to resource**.

## Task 3: Tag the resource group

Apply organizational tags to the resource group. Tags are key-value pairs that help you categorize resources, track costs by department or project, and enforce governance policies.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, select **Tags**.
3.  Add the tag **department** with the value **development**.
4.  Add the tag **environment** with the value **test**.
5.  Select **Apply**.
6.  Confirm both tags appear in the tags list.

> [!NOTE]
> **Validation step:** Verify the resource group displays both tags (**department: development** and **environment: test**) before proceeding.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go — you'll review them all in the validation unit at the end of this module.

## Task 4: Tag the storage account

Apply the same tags to the storage account. Tagging resources individually ensures accurate cost reporting even when multiple teams share a resource group.

1.  Open the storage account you created.
2.  In the left menu, select **Tags**.
3.  Add the tag **department** with the value **development**.
4.  Add the tag **environment** with the value **test**.
5.  Select **Apply**.

> [!NOTE]
> **Validation step:** Confirm the storage account now shows both tags matching the resource group tags.

## Task 5: Create a second storage account with different tags

Create another resource and assign different tag values. Having resources with different tags demonstrates how tags enable filtering and cost allocation across teams.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the Basics tab, select **rg-gp-tags-locks** as the resource group.
4.  For **Storage account name**, enter a globally unique name (for example, **stgptagsops** followed by your initials and a number).
5.  For **Region**, use the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then select **Create**.
10. When deployment finishes, select **Go to resource**.
11. In the left menu, select **Tags**.
12. Add the tag **department** with the value **operations**.
13. Add the tag **environment** with the value **test**.
14. Select **Apply**.

> [!NOTE]
> **Validation step:** Verify the second storage account exists with **department: operations** and **environment: test** tags.

## Task 6: Filter resources by tag

Use tags to filter the resource list and see only the resources that belong to a specific department. This demonstrates the practical value of consistent tagging for managing resources at scale.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the resource list, select **Add filter**.
4.  In the **Filter** dropdown, scroll down to **Tags** and select the **department** tag.
5.  In the **Operator** dropdown, select **Equals**.
6.  Select the checkbox next to **development** and select **Apply**.
7.  Confirm that only the **stgptagslock** storage account appears in the filtered list.
8.  Select the **X** on the right side of the filter to clear it, then repeat the steps above but select the checkbox next to **operations** instead.
9.  Confirm only the **stgptagsops** storage account appears.
10. Select the **X** on the right side of the filter to clear it and show all resources again.

> [!NOTE]
> **Validation step:** Confirm filtering by **department** tag shows only the correct storage account for each department value.

> [!NOTE]
