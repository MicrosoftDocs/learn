After completing the project, you might wish to clean up your development environment or return it to its typical state. You might also wish to delete your resource group.

## Clean up development container

You can stop your development container environment to free up resources whether they are on your local machine or on GitHub. Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running Codespaces sourced from the [`azure-samples/cosmosdb-chatgpt`](https://github.com/azure-samples/cosmosdb-chatgpt) GitHub repository.

    :::image type="content" source="../media/codespace-dashboard.png" alt-text="Screenshot of all the running Codespaces including their status and templates.":::

1. Open the context menu for the codespace and then select **Delete**.

    :::image type="content" source="../media/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::

## Clean up resource group

When you no longer need the resources from this project, delete the corresponding resource group.

1. Create a shell variable for `resourceGroupName`` if it doesn't already exist.

    ```azurecli
    resourceGroupName="mslearn-cosmos-openai"
    ```

1. Use [`az group delete`](/cli/azure/group#az-group-delete()) to delete the resource group.

    ```azurecli
    az group delete \
        --name $resourceGroupName  
    ```
