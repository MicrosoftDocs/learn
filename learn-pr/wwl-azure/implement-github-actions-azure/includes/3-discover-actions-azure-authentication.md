In order for GitHub Actions for Azure to access resources secured by a Microsoft Entra tenant, that access requires representation by a security principal. This requirement is true for both users (user principal) and applications (service principal). 

The security principal defines the access policy and permissions for the user/application in the Microsoft Entra tenant. This enables core features such as authentication of the user/application during sign-in, and authorization during resource access.

There are three types of service principal:

*   **Application** - This type of service principal is the local representation, or application instance, of a global application object in a single tenant or directory. When you register an application, a service principal is created automatically. You can also create service principal objects in a tenant using Azure PowerShell, Azure CLI, Microsoft Graph, and other tools.

*   **Managed identity** - Managed identities provide an identity for applications to use when connecting to resources that support Microsoft Entra authentication. When a managed identity is enabled, a service principal representing that managed identity is created in your tenant. Service principals representing managed identities can be granted access and permissions, but can't be updated or modified directly.

*   **Legacy** - This type of service principal represents a legacy app, which is an app created before app registrations were introduced or an app created through legacy experiences. A legacy service principal can have credentials, service principal names, and other properties that an authorized user can edit. But, it doesn't have an associated app registration. The service principal can only be used in the tenant where it was created.

The security principal also needs to be given appropriate access to resources in Azure by assigning the necessary roles. This unit covers the following ways of signing into Azure from a GitHub workflow:

* Sign-in with OpenID Connect (certificate-based).
* Sign-in with a service principal and a secret. **Note:** This method isn't recommended because the secret can be more easily compromised compared to certificate-based authentication.

You can create a service principal using the Azure portal, Azure CLI, or the Azure PowerShell.

## Sign-in with OpenID Connect

The following examples show you how to create a service principal and configure it for OpenID Connect using the Azure portal. The examples include configuring the scoped role, adding the secrets to GitHub, and using the secrets in the Azure Login action.

### Create a service principal

1. In the Azure portal search for **Microsoft Entra ID**, and navigate to the service.

1. In the left navigation pane, select **App registrations** in the **Manage** group. 

1. Select **+ New registration** in the main panel and enter a name, and then select **Register**.

    > [!NOTE]
    > The **Application (client) ID** and **Directory (tenant) ID** values in the Essentials section of the page are needed for the secrets added to GitHub. You will also need your **Subscription ID**.

1. In the left navigation pane select **Certificates & secrets** in the **Manage** group, and then in the main window select **Federated credentials**. 

1. Select **Add a credential** and then select **GitHub Actions deploying Azure resources** in the selection drop-down.

1. A form appears requesting information about your GitHub account. The following table shows the fields if you choose to restrict actions to a specific branch in your repository. **Note:** These fields are case sensitive. 

    | Field | Action |
    |--|--|
    | Organization | Enter your user or organization name. |
    | Repository | Enter the name of the repository. |
    | Entity type | Select **Branch**. |
    | GitHub branch name | Enter **main**, or the name of the branch that represents your deployment. |

1. In the Credential details section, give your credential a name and then select **Add**.

### Assign a role

You need to assign a role to the service principal to grant it permission to access resources in your Azure account. The following Azure CLI example assigns the *contributor* role scoped to the resource group that contains the application.

```azurecli
az role assignment create --assignee <service-principal-id> \
  --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}
```

### Add OpenID Connect secrets to GitHub

1. In [GitHub](https://github.com/), go to your repository.
1. Go to **Settings** in the navigation menu.
1. Select **Security > Secrets and variables > Actions**.

    ![Screenshot of select Actions menu item.](../media/actions-menu-item.png)

1. Select **New repository secret**.
1. Add the secrets shown in the following table.

    | Name | Secret |
    |--|--|
    | AZURE_CLIENT_ID | Enter the **Application (client) ID**. |
    | AZURE_TENANT_ID | Enter the **Directory (tenant) ID**. |
    | AZURE_SUBSCRIPTION_ID | Enter your subscription ID. You can retrieve your ID with the `az account show` command. |

### Use the Azure Login action

The following workflow example authenticates using the Azure Login action with the OpenID Connect details stored in GitHub.

```yml
on: [push]

name: AzureLoginSample

permissions:
  id-token: write # Requires write permission to fetch a token.
  contents: read  # This is required for actions/checkout

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      #Login in your azure subscription using OpenID Connect (credentials stored as GitHub secrets in repo)
      - name: Azure Login
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

## Sign in with a service principal and a secret

The following examples show you how to create a service principal and configure it a scoped role. They also show how to add the principal as a GitHub secret and use that secret in the Azure Login action.

### Create a service principal

The following Azure CLI command creates the service principal and assigns the *contributor* role scoped to the resource group that contains the application.

```azurecli
az ad sp create-for-rbac --name "myApp" --role contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \ 
    --json-auth
```

The command generates a JSON object for your service principal. This output is the secret you add to your GitHub repository. Be sure to copy the information it can't be retrieved later.

```json
{
    "clientId": "<GUID>",
    "clientSecret": "<secret>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    (...)
}
```

### Add service principal as a GitHub secret

The following steps show how to create a secret named `AZURE_CREDENTIALS` that you can use to authenticate with Azure.

1. In [GitHub](https://github.com/), go to your repository.
1. Go to **Settings** in the navigation menu.
1. Select **Security > Secrets and variables > Actions**.

    ![Screenshot of select Actions menu item.](../media/actions-menu-item.png)

1. Select **New repository secret**.
1. Paste the entire JSON output from the Azure CLI command into the secret's value field. Give the secret name `AZURE_CREDENTIALS`.

  Select **Add secret**.

### Use the Azure Login action

The following workflow example authenticates using the Azure Login action with the service principal details stored in `secrets.AZURE_CREDENTIALS`.

```yml
on: [push]

name: AzureLoginSample

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Log in with Azure
        uses: azure/login@v2
        with:
          creds: '${{ secrets.AZURE_CREDENTIALS }}'
```

