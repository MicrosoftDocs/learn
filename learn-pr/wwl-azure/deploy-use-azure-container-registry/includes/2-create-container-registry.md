Use this Try-This exercise to gain some hands-on experience with Azure Container Registry.

Azure Container Registry is a private registry service for building, storing, and managing container images and related artifacts. In this module, you create an Azure container registry instance with the Azure portal.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn). The repository role assignment step also requires **Owner**, **Role Based Access Control Administrator**, or equivalent `Microsoft.Authorization/roleAssignments/write` permission. If you don't have that permission, ask an administrator to assign the needed Azure Container Registry repository roles.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Select **Create a resource** > **Infrastructure services** > **Container Registry** > **Create**.
3.  In the **Basics** tab, select the **Subscription** where you want to create the container registry.
4.  For **Resource group**, create a new resource group, such as `myResourceGroup`.
5.  Enter a **Registry name**, such as `newregistryapl` if it's available. ACR registry names must be globally unique and 5-50 lowercase alphanumeric characters. Don't use uppercase letters or dash characters (`-`). If the sample name is taken, append a short random lowercase alphanumeric suffix. The registry resource name is used as the base of the login server DNS name.
6.  Select a **Location**, such as **West US 2**.
7.  For **Pricing plan**, select **Standard**.
8.  For **Domain name label scope**, select **Tenant Reuse**, or choose another option if your organization requires it.

    > [!IMPORTANT]
    > The domain name label scope is permanent after the registry is created and can't be changed later.

    For every DNL-enabled option except **Unsecure**, including **Tenant Reuse**, the registry login server includes a generated hash suffix, such as `newregistryapl-<hash>.azurecr.io`. The registry resource name remains `newregistryapl`.

9.  For **Role assignment permissions mode**, select **RBAC Registry + ABAC Repository Permissions**.

10.  Leave **Admin user** disabled (the default). This module uses Microsoft Entra/RBAC repository permissions instead of admin credentials. Accept default values for the remaining settings. Then select **Review + create**. After reviewing the settings, select **Create**.
11.  When the **Deployment succeeded** message appears, select **Go to resource** to open the registry overview.

12.  Make a note of the registry resource name and the exact value of the **Login server**. Use the registry resource name to sign in with the Azure CLI. Use the exact portal **Login server** value for Docker tag, push, and run commands in later steps.

13.  Because you selected **RBAC Registry + ABAC Repository Permissions**, the learner identity needs data-plane repository permissions for later Docker and portal repository steps. In the registry menu, select **Access control (IAM)** > **Add** > **Add role assignment**, then assign the learner identity these roles on the registry:

     - **Container Registry Repository Writer**
     - **Container Registry Repository Catalog Lister**

     Assigning roles requires **Owner**, **Role Based Access Control Administrator**, or equivalent `Microsoft.Authorization/roleAssignments/write` permission on the registry. If you don't have that permission, ask an administrator to complete this step.

     **Container Registry Repository Writer** without ABAC conditions grants registry-wide read/write/update repository access in this lab registry. **Container Registry Repository Catalog Lister** grants list access to all repositories and can't be ABAC-scoped. If the registry isn't dedicated to this lab, scope **Container Registry Repository Writer** with ABAC conditions for only the `hello-world` repository, or ask an administrator to do so.

     Azure role assignment changes can take up to 10 minutes to take effect. If a later `az acr login`, `docker push`, or portal repository listing returns `401` or `403`, wait a few minutes and retry. If needed, sign out and sign in again or refresh your tokens.
