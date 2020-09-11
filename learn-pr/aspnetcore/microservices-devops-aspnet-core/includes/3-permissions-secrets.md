In this unit, you'll complete the following tasks:

- Set up permissions to deploy to ACR and AKS from GitHub
- Create secrets to store sensitive data used by the GitHub Actions

## Set up permissions to deploy from GitHub

A GitHub Action will be used to deploy to ACR and AKS. You must set up permissions so the GitHub Action agent can connect to Azure. Complete the following steps:

1. Run the following command to create a service principal to allow access from GitHub:

    ```azurecli
    az ad sp create-for-rbac --sdk-auth --name http://eshop-learn-sp
    ```

    A variation of the following output appears:

    ```console
    Creating a role assignment under the scope of "/subscriptions/<SUBSCRIPTION-ID>"
    {
      "clientId": "<CLIENT-ID>",
      "clientSecret": "<CLIENT-SECRET>",
      "subscriptionId": "<SUBSCRIPTION-ID>",
      "tenantId": "<TENANT-ID>",
      "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
      "resourceManagerEndpointUrl": "https://management.azure.com/",
      "activeDirectoryGraphResourceId": "https://graph.windows.net/",
      "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
      "galleryEndpointUrl": "https://gallery.azure.com/",
      "managementEndpointUrl": "https://management.core.windows.net/"
    }
    ```

1. Copy the JSON output from the command shell. You'll need this and the credentials for the GitHub Action in next step.

### Create secrets

1. In the GitHub repository you forked, go to **Settings** > **Secrets**.
1. Select the **New secret** button.
1. Enter `AZURE_CREDENTIALS` and the JSON output you copied in the **Name** and **Value** text boxes, respectively.

    At this point, you should have something like this:

    :::image type="content" source="../media/4-build-github-action/add-github-secrets.png" alt-text="Image description follows in text" border="true" lightbox="../media/4-build-github-action/add-github-secrets.png":::
1. Select the **Add secret** button.
1. Create two additional secrets representing the username and password for accessing the ACR instance. Run the following command to get the values to be used for the new secrets:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/config.txt
    ```

    Name the secrets as follows and use the values provided in the text output:
    - `REGISTRY_USERNAME`
    - `REGISTRY_PASSWORD`
