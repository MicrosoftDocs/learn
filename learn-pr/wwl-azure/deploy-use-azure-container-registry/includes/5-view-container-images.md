Use this Try-This exercise to gain some hands-on experience with Azure Container Registry.

To verify the push in the portal, navigate to your registry. In the registry menu, under **Services**, select **Repositories**, open the **hello-world** repository, and verify that the `v1` tag appears under **Tags**.

> [!NOTE]
> When the registry uses **RBAC Registry + ABAC Repository Permissions**, listing repositories in the portal requires the **Container Registry Repository Catalog Lister** role. Viewing tags or repository content requires **Container Registry Repository Reader** or **Container Registry Repository Writer**. This module assigned **Container Registry Repository Writer** earlier.

> [!NOTE]
> After repository roles are assigned, Azure role assignment changes can take up to 10 minutes to take effect. If the portal repository list or tag view fails with a 401 or 403 error shortly after assignment, wait and refresh. If needed, sign out and in again to refresh your portal session.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

1.  From **Container registries**, select the registry you created in the previous unit.

2.  In the registry menu, under **Services**, select **Repositories**.

3.  Select the **hello-world** repository. Under **Tags**, verify that the `v1` tag is listed.

4.  Optionally, verify the repository and tag from the Azure CLI. Use the registry resource name for `<registry-name>`, not the **Login server** value.

    ```azurecli
    az acr repository list -n <registry-name> --output table
    ```

    ```azurecli
    az acr repository show-tags -n <registry-name> --repository hello-world --output table
    ```
