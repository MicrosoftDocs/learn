We've taken a look at several features you can use to put organization and control around your Azure resources.

We talked about how resource groups worked, and some ways you can use them to organize your resources.

We looked at how tags allow you to add custom contextual information to your resources, for use in areas such as billing and filtering.

We saw how we could use policies to enforce standards across our Azure resources.

We used resource locks to prevent accidental deletion of critical resources.

By using these tools throughout your Azure environment, you'll have greater organization across your Azure resources.

## Clean up

Let's clean up the resources that we created. You'll need to delete the resource group you created, as well as the policy assignment and policy definition.

1. Navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) in a web browser if you haven't already. In the search box in the top navigation bar, search for **msftlearn-core-infrastructure-rg** and click on the resource group.

1. In the **Overview** pane, click **Delete resource group**. Enter the `msftlearn-core-infrastructure-rg` resource group name to confirm, and click **Delete**.

1. In the search box, search for **Policy** and select the **Policy** service.

    > [!NOTE]
    > Since you deleted the assigned resources with the containing resource group, there won't be any assignments left in this policy. Normally, if you assign a policy to a resource, you could delete the assignment without deleting the underlying resource here. To do this, you would select **Assignments**, then select the **...** for your assignment and select **Delete assignment**.

1. Select **Definitions**, then select the **...** for your definition and select **Delete definition**.
