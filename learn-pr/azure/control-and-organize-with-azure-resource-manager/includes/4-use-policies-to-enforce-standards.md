You're organizing your resources better in resource groups, and you've applied tags to your resources to use them in billing reports and in your monitoring solution. Resource grouping and tagging have made a difference in the existing resources, but how do you ensure that new resources follow the rules? Let's take a look at how policies can help you enforce standards in your Azure environment.

## What is Azure Policy?

Azure Policy is a service you can use to create, assign, and manage policies. These policies apply and enforce rules that your resources need to follow. These policies can enforce these rules when resources are created, and you can evaluate them against existing resources to give visibility into compliance.

Policies can enforce rules such as only allowing specific types of resources to be created or only allowing resources in specific Azure regions. You can enforce naming conventions across your Azure environment. You can also enforce that specific tags are applied to resources. Let's take a look at how policies work.

## Create a policy

You'd like to ensure that all resources have the **Department** tag associated with them and block creation if the tag doesn't exist. You'll need to create a new policy definition and assign it to a scope; in this case, the scope is our **msftlearn-core-infrastructure-rg** resource group. You can create and assign policies through the Azure portal, Azure PowerShell, or Azure CLI. This exercise takes you through creating a policy in the portal.

### Create the policy definition

1. Navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) in a web browser if you haven't already. In the search box in the top navigation bar, search for **Policy** and select the **Policy** service.

1. Select the **Definitions** pane from the **Authoring** section in the left menu.

1. You should see a list of built-in policies that you can use. In this case, you're going to create your own custom policy. Select **+ Policy definition** in the top menu.

1. This button brings up the **New policy definition** dialog. To set the **Definition location**, select the blue **Launch scope selector (...)**. Select the subscription in which the policy is stored, which should be the same subscription as our resource group. Select the **Select** button.

1. Back on the **New policy definition** dialog, enter _Enforce tag on resource_ in the **Name** field.

1. For the **Description**, enter _This policy enforces the existence of a tag on a resource_.

1. For **Category**, select **Use existing**, then select the **General** category.

1. For the **Policy rule**, delete all text in the box and paste in the following JSON:

    ```json
    {
      "mode": "Indexed",
      "policyRule": {
        "if": {
          "field": "[concat('tags[', parameters('tagName'), ']')]",
          "exists": "false"
        },
        "then": {
          "effect": "deny"
        }
      },
      "parameters": {
        "tagName": {
          "type": "String",
          "metadata": {
            "displayName": "Tag Name",
            "description": "Name of the tag, such as 'environment'"
          }
        }
      }
    }
    ```

    Your policy definition should look like the following example. Select **Save** to save your policy definition.

    :::image type="content" source="../media/4-add-policy-definition.png" alt-text="Screenshot of Azure portal showing the new policy definition dialog.":::

### Create a policy assignment

You've created the policy, but you haven't actually put it into effect yet. To enable the policy, you need to create an assignment. In this case, you'll assign it to the scope of your **msftlearn-core-infrastructure-rg** resource group so that it applies to anything inside the resource group.

1. In the policy pane, select **Assignments** from the **Authoring** section on the left.

1. Select **Assign policy** at the top.

1. In the **Assign policy** pane, you'll assign your policy to your resource group. For **Scope**, select the blue **Launch scope selector (...)**. Select your subscription and the **msftlearn-core-infrastructure-rg** resource group, then select the **Select** button.

1. For **Policy definition**, select the blue **Launch policy definition picker (...)**. In the **Type** drop-down, select **Custom**, select the **Enforce tag on resource** policy you created, then select the **Add** button.

1. Select the **Parameters** tab at the top of the screen.

1. On the **Parameters** pane, enter _Department_ for the **Tag name**.

1. Select **Review + create**, then select **Create** to create the assignment.

### Test out the policy

Now that you've assigned the policy to your resource group, any attempts to create a resource without the **Department** tag will fail.

> [!IMPORTANT]
> Please note that the policy assignment might take up to 30 minutes to take effect. Because of this delay, in the following steps the policy validation might succeed, but the deployment will still fail. If this happens, allow for additional time and retry your deployment.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. Search for **Storage account** and select **Storage account**. In the results, select **Create**.

1. Select your subscription, then select the **msftlearn-core-infrastructure-rg** resource group.

1. For **Storage account name**, give it any name of your choice, but note that it does have to be a globally unique name.

1. Leave the rest of the options at their default, then select **Review**.

    Your resource-creation validation will fail because you don't have a **Department** tag applied to the resource. If the policy has not caused a validation failure, you might need to wait a few more minutes for it to be enabled.

    :::image type="content" source="../media/4-policy-error-message.png" alt-text="Screenshot of Azure portal showing a policy validation failure on a new storage account without a tag.":::

    Fix the violation so you can successfully deploy the storage account.

1. Select **Tags** at the top of the **Create storage account** pane.

1. Add a `Department`:`Finance` tag to the list.

    :::image type="content" source="../media/4-add-storage-tag.png" alt-text="Screenshot of Azure portal showing a new Department tag to add during creation.":::

1. Now click **Review**. Validation will now pass, and if you select **Create**, your storage account will be created.

## Use policies to enforce standards

You've seen how you can use policies to ensure that your resources have the tags that organize your resources. There are other ways we can use policies to our benefit.

You could use a policy to restrict to which Azure regions you can deploy resources. For organizations that are heavily regulated or have legal or regulatory restrictions on where data can reside, policies help to ensure that resources aren't provisioned in geographic areas that go against these requirements.

You could use a policy to restrict which types of virtual machine sizes can be deployed. You might want to allow large VM sizes in your production subscriptions, but maybe you'd like to ensure that you keep costs minimized in your dev subscriptions. By denying the large VM sizes through policy in your dev subscriptions, you can ensure they don't get deployed in these environments.

You could also use a policy to enforce naming conventions. If your organization has standardized on specific naming conventions, using policy to enforce the conventions helps us to keep a consistent naming standard across your Azure resources.
