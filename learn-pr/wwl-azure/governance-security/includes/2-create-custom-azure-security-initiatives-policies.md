Understanding how to create and manage policies in Azure is important for staying compliant with your corporate standards and service-level agreements. In this example, you learn to use Azure Policy to do some of the more common tasks related to creating, assigning, and managing policies across your organization, such as:

 -  Assign a policy to enforce a condition for resources you create in the future<br>
 -  Create and assign an initiative definition to track compliance for multiple resources
 -  Resolve a non-compliant or denied resource
 -  Implement a new policy across an organization

## Prerequisites

If you don't have an Azure subscription, create a free account before you begin.

## Assign a policy

The first step in enforcing compliance with Azure Policy is to assign a policy definition. A policy definition defines under what condition a policy is enforced and what effect to take. In this example, assign the built-in policy definition called *Inherit a tag from the resource group if missing* to add the specified tag with its value from the parent resource group to new or updated resources missing the tag.

1. Go to the Azure portal to assign policies. Search for and select **Policy**.

:::image type="content" source="../media/search-policy-936ccf64.png" alt-text="Screenshot showing how to use the Azure portal to assign a policy.":::


2. Select **Assignments** on the left side of the Azure Policy page. An assignment is a policy that has been assigned to take place within a specific scope.

:::image type="content" source="../media/select-assignments-a9eeb5b8.png" alt-text="Screenshot showing the Azure policy authoring assignments page.":::


3. Select **Assign Policy** from the top of the **Policy - Assignments** page.

:::image type="content" source="../media/select-assign-policy-73264c35.png" alt-text="Screenshot showing how to assign the policy in the authoring assignments page.":::


4. On the **Assign Policy** page and **Basics** tab, select the **Scope** by selecting the ellipsis and selecting either a management group or subscription. Optionally, select a resource group. A scope determines what resources or grouping of resources the policy assignment gets enforced on. Then click **Select** at the bottom of the **Scope** page. This example uses the **Contoso** subscription. Your subscription will differ.

5. Resources can be excluded based on the **Scope**. **Exclusions** start at one level lower than the level of the **Scope**. **Exclusions** are optional, so leave it blank for now.<br>

6. Select the **Policy definition** ellipsis to open the list of available definitions. You can filter the policy definition **Type** to Built-in to view all and read their descriptions.

7. Select **Inherit a tag from the resource group if missing**. If you can't find it right away, type **inherit a tag** into the search box and then press ENTER or select out of the search box. Click **Select** at the bottom of the **AvailableDefinitions** page once you have found and selected the policy definition.

:::image type="content" source="../media/select-available-definition-c146b13f.png" alt-text="Screenshot showing how to view available Azure policy definition types.":::


8. The **Assignment name** is automatically populated with the policy name you selected, but you can change it. For this example, leave *Inherit a tag from the resource group if missing*. You can also add an optional **Description**. The description provides details about this policy assignment.

9. Leave **Policy enforcement** as *Enabled*. When *Disabled*, this setting allows testing the outcome of the policy without triggering the effect. For more information, see enforcement mode.

10. **Assigned by** is automatically filled based on who is logged in. This field is optional, so custom values can be entered.<br>

11. Select the **Parameters** tab at the top of the wizard.<br>

12. For **Tag Name**, enter *Environment*.<br>

13. Select the **Remediation** tab at the top of the wizard.<br>

14. Leave **Create a remediation task** unchecked. This box allows you to create a task to alter existing resources in addition to new or updated resources.<br>

15. **Create a Managed Identity** is automatically checked since this policy definition uses the modify effect. **Permissions** is set to *Contributor* automatically based on the policy definition. For more information, see managed identities and how remediation access control works.<br>

16. Select the **Non-compliance messages** tab at the top of the wizard.<br>

17. Set the **Non-compliance message** to *This resource doesn't have the required tag*. This custom message is displayed when a resource is denied or for non-compliant resources during regular evaluation.<br>

18. Select the **Review + create** tab at the top of the wizard.<br>

19. Review your selections, then select **Create** at the bottom of the page.
