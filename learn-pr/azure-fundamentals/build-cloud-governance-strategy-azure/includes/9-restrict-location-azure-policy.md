In this exercise, you create a policy in Azure Policy that restricts the deployment of Azure resources to a specific location. You verify the policy by attempting to create a storage account in a location that violates the policy.

Tailwind Traders wants to limit the location where resources can be deployed to the **East US** region. It has two reasons:

* **Improved cost tracking**

    To track costs, Tailwind Traders uses different subscriptions to track deployments to each of its regional locations. The policy will ensure that all resources are deployed to the **East US** region.
* **Adhere to data residency and security compliance**

    Tailwind Traders must adhere to a compliance rule that states where customer data can be stored. Here, customer data must be stored in the **East US** region.

Recall that you can assign a policy to a management group, a single subscription, or a resource group. Here, you assign the policy to a resource group so that policy doesn't affect any other resources in your Azure subscription.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the resource group

Here you create a resource group that's named **my-test-rg**. This is the resource group to which you'll apply your location policy.

For learning purposes, you use the same resource group name that you used in the previous exercise. You can use the same name because you deleted the previous resource group.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in.
1. Select **Create a resource**.
1. Enter **resource group** in the search box, and select <kbd>Enter</kbd>.
1. If you're taken to a search results page, select **Resource group** from the results.
1. Select **Create**. Then fill in these fields.

    | Setting | Value |
    | -- | -- |
    | **Subscription** | *(Your Azure subscription)* |
    | **Subscription > Resource group** | **my-test-rg** |
    | **Region** | **(US) East US** |

1. Select **Review + create**, and then select **Create**.

## Explore predefined policies

Before you configure your location policy, let's take a brief look at some predefined policies. As an example, you'll look at policies that relate to Azure Compute services.

1. From the Azure portal, at the top of the page, select **Home** to return to the start page.
1. At the top of the page, enter **policy** in the search bar. Then select **Policy** from the list of results to access Azure Policy.
1. Under **Authoring**, select **Definitions**.
1. From the **Category** drop-down list, select only **Compute**.

    Notice that the **Allowed virtual machine SKUs** definition enables you to specify a set of virtual machine SKUs that your organization can deploy.

    :::image type="content" source="../media/10-policy-category-compute.png" alt-text="A screenshot of the Azure portal showing policy definitions under the Compute category. The Allowed virtual machine SKUs definition is highlighted.":::

As an optional step, explore any other policies or categories that interest you.

## Configure the location policy

Here you configure the allowed location policy by using Azure Policy. Then you assign that policy to your resource group. To do so:

1. From the **Policy** page, under **Authoring**, select **Assignments**.

    :::image type="content" source="../media/10-policy-assignments.png" alt-text="A screenshot of the Azure portal showing the Assignments menu item.":::

    An assignment is a policy that has been assigned to take place within a specific scope. For example, a definition could be assigned to the subscription scope.

1. Select **Assign Policy**.

    :::image type="content" source="../media/10-assign-policy.png" alt-text="A screenshot of the Azure portal showing the Assign policy menu item.":::

    You're taken to the **Assign policy** page.

1. Under **Scope**, select the ellipsis.

    From the dialog box that appears, set:

    1. The **Subscription** field to your Azure subscription.
    1. The **Resource Group** field to **my-test-rg**.
    1. Select the **Select** button.

1. Under **Policy definition**, select the ellipsis.

    1. In the search bar, enter **location**.
    1. Select the **Allowed locations** definition.
    1. Select the **Select** button.

    :::image type="content" source="../media/9-available-definitions-pane.png" alt-text="A screenshot of the Azure portal showing the search bar. In the results pane, the Allowed locations policy definition is highlighted.":::

    This policy definition specifies the location into which all resources must be deployed. If a different location is chosen, deployment will fail.

1. Select **Next** to move to the **Parameters** tab.
1. From the **Allowed locations** drop-down box, select **East US**.
1. Select **Review + create**, and then select **Create**.

    You see that the **Allowed locations** policy assignment is now listed on the **Policy | Assignments** pane. It enforces the policy on the **my-test-rg** resource group.

    :::image type="content" source="../media/10-policy-assignment-result.png" alt-text="A screenshot of the Azure portal showing the Allowed locations policy assignment listed in the Policy | Assignments pane.":::

## Verify the location policy

Here you attempt to add a storage account to your resource group at a location that violates your location policy.

1. From the Azure portal, at the top of the page, select **Home** to return to the start page.
1. Select **Create a resource**.
1. Enter **storage account** in the search box, and select <kbd>Enter</kbd>.
1. If you're taken to a search results page, select **Storage account** from the results.
1. Select **Create**. Then fill in these fields.

    > [!NOTE]
    > Replace **NNN** with a series of numbers. Numbers help to ensure that your storage account name is unique.

    | Setting | Value |
    | --- | --- |
    | **Subscription** | *(Your Azure subscription)* |
    | **Subscription > Resource group** | **my-test-rg** |
    | **Storage account name** | **mysaNNN** |
    | **Location** | **(Asia Pacific) Japan East** |
    | **Performance** | **Standard** |
    | **Account kind** | **StorageV2 (general purpose v2)** |
    | **Replication** | **Locally redundant storage (LRS)** |
    | **Access tier (default)** | **Hot** |

    If you previously selected **Japan East** in your location policy, select a different region from the list.
1. Select **Review + create**, and then select **Create**.

    You see a message that states that the deployment failed because of the policy violation. You also see the deployment details.

    Here's an example that shows the deployment details for a storage account named **mysa1234**.

    :::image type="content" source="../media/10-create-sa-error-policy-violation.png" alt-text="A screenshot of the Azure portal showing the deployment details message. The details include the resource name, its type, and a status of Forbidden.":::

## Delete the policy assignment

You no longer need your policy assignment. Here you remove it from your subscription.

1. From the Azure portal, select **Home** > **Policy**.
1. Under **Authoring**, select **Assignments**.
1. On the **Allowed locations** row, select the ellipsis. Then select **Delete assignment**. When prompted, select **Yes**.

    :::image type="content" source="../media/10-policy-delete-assignment.png" alt-text="A screenshot of the Azure portal showing the Delete assignment menu item.":::

    You see that the **Allowed locations** policy assignment no longer exists.

As an optional step, you can try to create the storage account a second time to verify that the policy is no longer in effect.

## Delete the resource group

You no longer need your resource group. Here you remove it from your subscription.

1. From the Azure portal, select **Home** > **Resource groups** > **my-test-rg** to go to your resource group.
1. Select **Overview**, and then select **Delete resource group**.
1. At the prompt, enter **my-test-rg**, and then select **OK**.

    The deletion operation might take a few moments to complete.
1. After the operation completes, select **Home** > **Resource groups**.

    You see that the **my-test-rg** resource group no longer exists in your account.

Great work! You've successfully applied a policy by using Azure Policy to restrict the deployment of Azure resources to a specific location. You can now apply the policies that you need at the management group, subscription, or resource group level.
