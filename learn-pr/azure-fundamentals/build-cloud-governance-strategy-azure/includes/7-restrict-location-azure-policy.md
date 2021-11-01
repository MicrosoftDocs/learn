In this exercise, you create a policy in Azure Policy that restricts the deployment of Azure resources to a specific location. You verify the policy by attempting to create a storage account in a location that violates the policy.

Tailwind Traders wants to limit the location where resources can be deployed to the **East US** region. It has two reasons:

 -  **Improved cost tracking** To track costs, Tailwind Traders uses different subscriptions to track deployments to each of its regional locations. The policy will ensure that all resources are deployed to the **East US** region.
 -  **Adhere to data residency and security compliance** Tailwind Traders must adhere to a compliance rule that states where customer data can be stored. Here, customer data must be stored in the **East US** region.

Recall that you can assign a policy to a management group, a single subscription, or a resource group. Here, you assign the policy to a resource group so that policy doesn't affect any other resources in your Azure subscription.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the resource group

Here you create a resource group that's named **my-test-rg**. This is the resource group to which you'll apply your location policy.

For learning purposes, you use the same resource group name that you used in the previous exercise. You can use the same name because you deleted the previous resource group.

1.  Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in.
2.  Select **Create a resource**.
3.  Enter **resource group** in the search box, and press Enter.
4.  If you're taken to a search results pane, select **Resource group** from the results.
5.  Select **Create**. Then, enter the following values for each setting.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Subscription**
      :::column-end:::
      :::column:::
        *(Your Azure subscription)*
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Subscription > Resource group**
      :::column-end:::
      :::column:::
        **my-test-rg**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Region**
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    
6.  Select **Review + create**, and then select **Create**.

## Explore predefined policies

Before you configure your location policy, let's take a brief look at some predefined policies. As an example, you'll look at policies that relate to Azure Compute services.

1.  From the Azure portal, at the top of the page, select **Home** to return to the start page.
2.  At the top of the page, enter **policy** in the search bar. Then, select **Policy** from the list of results to access Azure Policy.
3.  Under **Authoring**, select **Definitions**.
4.  From the **Category** dropdown list, select only **Compute**. Notice that the **Allowed virtual machine SKUs** definition enables you to specify a set of virtual machine SKUs that your organization can deploy.:::image type="content" source="../media/10-policy-category-compute-bdbeeecb.png" alt-text="A screenshot of the Azure portal showing policy definitions under the Compute category. The Allowed virtual machine SKUs definition is highlighted.":::
    

As an optional step, explore any other policies or categories that interest you.

## Configure the location policy

Here you configure the allowed location policy by using Azure Policy. Then you assign that policy to your resource group. To do so:

1.  From the **Policy** pane, under **Authoring**, select **Assignments**.<br>:::image type="content" source="../media/10-policy-assignments-d5c235d1.png" alt-text="A screenshot of the Azure portal showing the Assignments menu item.":::
    <br>An assignment is a policy that has been assigned to take place within a specific scope. For example, a definition could be assigned to the subscription scope.
2.  Select **Assign Policy**.<br>:::image type="content" source="../media/10-assign-policy-7eadfe48.png" alt-text="A screenshot of the Azure portal showing the Assign policy menu item.":::
    <br>You're taken to the **Assign policy** pane.
3.  Under **Scope**, select the ellipsis.<br>From the dialog box that appears, set:
    
    1.  **Subscription** field to your Azure subscription.
    2.  **Resource Group** field to **my-test-rg**.
    3.  Select **Select**.
4.  Under **Policy definition**, select the ellipsis.
    
    1.  In the search bar, enter *location*.
    2.  Select the **Allowed locations** definition.
    3.  Select **Select**.
    
    :::image type="content" source="../media/9-available-definitions-pane-55665e57.png" alt-text="A screenshot of the Azure portal showing the search bar. In the results pane, the Allowed locations policy definition is highlighted.":::
    <br>This policy definition specifies the location into which all resources must be deployed. If a different location is chosen, deployment will fail.
5.  Select **Next** to move to the **Parameters** tab.
6.  From the **Allowed locations** dropdown list, select **East US**.
7.  Select **Review + create**, and then select **Create**.<br>You see that the **Allowed locations** policy assignment is now listed on the **Policy \| Assignments** pane. It enforces the policy on the **my-test-rg** resource group.<br>:::image type="content" source="../media/10-policy-assignment-result-b0442a7a.png" alt-text="A screenshot of the Azure portal showing the Allowed locations policy assignment listed in the Policy Assignments pane.":::
    

## Verify the location policy

Here you attempt to add a storage account to your resource group at a location that violates your location policy.

1.  From the Azure portal, at the top of the page, select **Home** to return to the start page.
2.  Select **Create a resource**.
3.  Enter **storage account** in the search box, and press Enter.
4.  If you're taken to a search results pane, select **Storage account** from the results.
5.  Select **Create**. Then, enter the following values for each setting.
    
    > [!NOTE]
    > Replace **NNN** with a series of numbers. Numbers help to ensure that your storage account name is unique.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Subscription**
      :::column-end:::
      :::column:::
        *(Your Azure subscription)*
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Subscription > Resource group**
      :::column-end:::
      :::column:::
        **my-test-rg**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Storage account name**
      :::column-end:::
      :::column:::
        **mysaNNN**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Location**
      :::column-end:::
      :::column:::
        **(Asia Pacific) Japan East**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Performance**
      :::column-end:::
      :::column:::
        **Standard**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Account kind**
      :::column-end:::
      :::column:::
        **StorageV2 (general purpose v2)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Redundancy**
      :::column-end:::
      :::column:::
        **Locally redundant storage (LRS)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Access tier (default)**
      :::column-end:::
      :::column:::
        **Hot**
      :::column-end:::
    :::row-end:::
    
    
    If you previously selected **Japan East** in your location policy, select a different region from the list.
6.  Select **Review + create**, and then select **Create**.<br>You see a message that states that the deployment failed because of the policy violation. You also see the deployment details.<br>Here's an example that shows the deployment details for a storage account named **mysa1234**.<br>:::image type="content" source="../media/10-create-sa-error-policy-violation-82586ae6.png" alt-text="A screenshot of the Azure portal showing the deployment details message. The details include the resource name, its type, and a status of Forbidden.":::
    

## Delete the policy assignment

You no longer need your policy assignment. Here you remove it from your subscription.

1.  From the Azure portal, select **Home** &gt; **Policy**.
2.  Under **Authoring**, select **Assignments**.
3.  On the **Allowed locations** row, select the ellipsis. Then, select **Delete assignment**. When prompted, select **Yes**. :::image type="content" source="../media/10-policy-delete-assignment-ebe24442.png" alt-text="A screenshot of the Azure portal showing the Delete assignment menu item.":::
    <br>You see that the **Allowed locations** policy assignment no longer exists.

As an optional step, you can try to create the storage account a second time to verify that the policy is no longer in effect.

## Delete the resource group

You no longer need your resource group. Here you remove it from your subscription.

1.  From the Azure portal, select **Home** &gt; **Resource groups** &gt; **my-test-rg** to go to your resource group.
2.  Select **Overview**, and then select **Delete resource group**.
3.  At the prompt, enter **my-test-rg**, and then select **OK**. The deletion operation might take a few moments to complete.
4.  After the operation completes, select **Home** &gt; **Resource groups**. You see that the **my-test-rg** resource group no longer exists in your account.

Great work! You've successfully applied a policy by using Azure Policy to restrict deployments of Azure resources to specific locations. You can now apply the policies that you need at the management group, subscription, or resource group level.
