After completing the project, you might wish to clean up your development environment or return it to its typical state.

## Delete GitHub Codespace

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free core hours entitlement you get for your account.

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running codespace in the list of GitHub Codespaces.

1. Open the context menu for the codespace and then select **Delete**.

## Delete Azure resources

In this module, you created resources using your Azure subscription. Clean up these resources so that you aren't still charged for them. You can delete resources individually or delete the resource group to delete the entire set of resources.

1. Sign in to the Azure CLI.

    ```azurecli
    az login
    ```

1. Delete the entire resource group used in this exercise.

    ```azurecli
    az group delete \
        --name "learn-cosmos-db-dotnet-app" \
        --yes
    ```

1. Wait for the deletion process to finish.
