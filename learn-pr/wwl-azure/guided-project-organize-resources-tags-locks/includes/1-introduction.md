This guided project focuses on organizing and protecting Azure resources using tags and locks.

Tags are key-value pairs that you attach to resources and resource groups. They help you categorize resources for cost reporting, ownership tracking, and governance. Locks add a layer of protection that prevents accidental modification or deletion, even for users with full permissions.

## Scenario

Your development team is setting up a shared Azure environment and needs to keep resources organized and protected from accidental changes. You apply tags to track which department owns each resource, and then apply locks to prevent critical resources from being modified or deleted by mistake.

- Exercise 1 - Create resources and apply organizational tags.
- Exercise 2 - Apply resource locks to prevent accidental changes.
- Exercise 3 - Test lock enforcement and confirm the full lock lifecycle.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing how tags and locks are applied to a resource group and storage accounts for organization and protection." border="false":::

By the end of this project, you can organize resources with tags, filter resources by tag value, and protect resources using both delete and read-only locks.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Apply and use resource tags**
+ Tag resource groups and individual resources with key-value pairs.
+ Apply different tag values to distinguish departments or environments.
+ Filter resources by tag in the portal.

**Configure resource locks**
+ Apply a delete lock to prevent resource removal.
+ Apply a read-only lock to prevent modifications.
+ Understand how locks at different scopes interact.

**Test and manage lock enforcement**
+ Verify that locked operations are blocked with appropriate error messages.
+ Remove locks and confirm that normal operations are restored.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
