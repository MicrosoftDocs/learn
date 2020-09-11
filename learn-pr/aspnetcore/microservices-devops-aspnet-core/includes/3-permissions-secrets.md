In this unit, you'll complete the following tasks:

- Verify the app is deployed correctly
- Set up permissions to deploy to ACR and AKS from GitHub
- Create secrets to store sensitive data used by the GitHub Actions

## Verify deployment to AKS

After the app has deployed to AKS, you'll see a variation of the following message in the command shell:

```console
The eShop-Learn application has been deployed.

You can begin exploring these services (when available):
- Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://203.0.113.55/webstatus/ (See overall service status)
- Web SPA application       : http://203.0.113.55/
```

> [!TIP]
> To display these URLs again, run the following command:
>
> ```bash
> cat ~/clouddrive/aspnet-learn/deployment-urls.txt
> ```

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **General application status** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/3-permissions-secrets/health-check.png" alt-text="Health check page" border="true" lightbox="../media/3-permissions-secrets/health-check.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **Centralized logging** URL, are available before the other endpoints.

1. After all the services are healthy, select the **Web SPA application** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **LOGIN** link in the upper right to sign into the app. The credentials are provided on the page.
    1. Add the **.NET BLUE HOODIE** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**, and then select **PLACE ORDER** to complete the purchase.

    :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="shopping cart with .NET Blue Hoodie" border="true" lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

In this unit, you've seen the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. You'll review the design of the new coupon service in the next unit.

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
