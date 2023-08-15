In this unit, you complete the following tasks:

- Verify that the app deployed correctly.
- Create an Azure Active Directory (Azure AD) service principal to deploy to Azure Container Registry and Azure Kubernetes Service (AKS) from GitHub.
- Create secrets to store sensitive data that GitHub Actions uses.

## Verify the deployment to AKS

After the app deploys to AKS, the terminal displays the URLs for your app:

```console
The eShop-Learn application has been deployed to "http://000.0.000.00" (IP: 000.0.000.00).

You can begin exploring these services (when ready):
- Centralized logging       : http://000.0.000.00/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://000.0.000.00/webstatus/ (See overall service status)
- Web SPA application       : http://000.0.000.00/
```

> [!TIP]
> You can also find these URLs in the *deployment-urls.txt* file in the root of the GitHub project.

Even though the app has deployed, it might take a few minutes to come online. While the app is starting up, you might receive an HTTP 503 or 502 response from the server. Retry after about one minute. The [Seq](https://datalust.co/seq) logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

To verify that the app is deployed online and working correctly:

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically every 10 seconds.

   :::image type="content" source="../media/3-permissions-secrets/health-check.png" alt-text="Screenshot that shows the Health check page." border="true" lightbox="../media/3-permissions-secrets/health-check.png":::

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the :::no-loc text="eShopOnContainers"::: web app. The app home page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot that shows the eShop single page app." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. On the app page, complete a purchase as follows:
   1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. The page provides demo credentials.
   1. Select the **:::no-loc text=".NET BLUE HOODIE":::** to add it to the shopping bag.
   1. Select the shopping bag icon at upper right.
   1. Select the **:::no-loc text="CHECKOUT":::** button.
   1. Enter the code *:::no-loc text="DISC-10":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box for a 10 USD discount, and select **:::no-loc text="APPLY":::**.

      :::image type="content" source="../media/3-permissions-secrets/discount-code-field.png" alt-text="Shopping basket with the discount code text box." border="true" lightbox="../media/3-permissions-secrets/discount-code-field.png":::

   1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

You've verified that the app successfully deployed to AKS and is working properly, and that the coupon service supports the discount code feature. Next, you build a CI/CD pipeline to automate the build and deployment of the coupon service.

## Create a service principal to deploy from GitHub

GitHub Actions publishes the container image to Azure Container Registry, so the GitHub runner must have permissions to connect to Azure. The following steps create an Azure AD service principal to act as the GitHub Actions identity in Azure.

1. Run the following command in the terminal to display your Subscription ID.

   ```azurecli
   az account show --query 'id' --output tsv
   ```

1. Run the following command to create an Azure AD service principal to allow access from GitHub. Replace the `<subscription-id>` placeholder with your Subscription ID.

   ```azurecli
   az ad sp create-for-rbac --sdk-auth --name http://eshop-learn-sp --role Contributor --scopes /subscriptions/<subscription-id>
   ```

   A variation of the following output appears:

   ```console
   Option '--sdk-auth' has been deprecated and will be removed in a future release.
   Creating 'Contributor' role assignment under scope '/subscriptions/00000000-0000-0000-0000-000000000000'
   
   The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
    {
     "clientId": "00000000-0000-0000-0000-000000000000",
     "clientSecret": "abc1A~abc123ABC123abc123ABC123abc123ABC1",
     "subscriptionId": "00000000-0000-0000-0000-000000000000",
     "tenantId": "00000000-0000-0000-0000-000000000000",
     "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
     "resourceManagerEndpointUrl": "https://management.azure.com/",
     "activeDirectoryGraphResourceId": "https://graph.windows.net/",
     "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
     "galleryEndpointUrl": "https://gallery.azure.com/",
     "managementEndpointUrl": "https://management.core.windows.net/"
   }
   ```

   > [!NOTE]
   > The deprecated `--sdk-auth` warning is a known issue.

1. Copy the JSON output and brackets to use in the next step.

## Create the secrets

The GitHub Actions runner uses credentials to interact with Container Registry and AKS. The service principal and the credentials for the container registry are sensitive information. It's best to store sensitive information as encrypted *secrets* in a secure location. GitHub provides a built-in location to store secrets and other variables.

Complete the following steps to securely store the sensitive information as environment variables in your repository. Repository administrators should manage the secrets that the GitHub Actions runner can access.

1. In your forked GitHub repository, go to **:::no-loc text="Settings":::** > **:::no-loc text="Secrets and variables":::** > **:::no-loc text="Actions":::**.
1. On the **:::no-loc text="Actions secrets and variables":::** page, select **:::no-loc text="New repository secret":::**.
1. On the **:::no-loc text="New secret":::** page, under **:::no-loc text="Name":::** enter *AZURE_CREDENTIALS*, and under **:::no-loc text="Secret":::**, enter the JSON output you copied from the terminal.

   The settings should look similar to the following screenshot:

   :::image type="content" source="../media/3-permissions-secrets/add-github-secrets.png" alt-text="Screenshot of the New secret page to set environment variable secrets in GitHub." border="true" lightbox="../media/3-permissions-secrets/add-github-secrets.png":::

1. Select **:::no-loc text="Add secret":::**.
1. On the **:::no-loc text="Actions secrets and variables":::** page, select **:::no-loc text="New repository secret":::** again, and create four more repository secrets with the following names:

   - `IP_ADDRESS`
   - `REGISTRY_LOGIN_SERVER`
   - `REGISTRY_PASSWORD`
   - `REGISTRY_USERNAME`

   To get the values for the secrets, run the following command in the terminal:

   ```bash
   cat ../../config.txt
   ```

   When all five secrets are configured, you should see the following list under **:::no-loc text="Repository secrets":::** on the **:::no-loc text="Actions secrets and variables":::** page:

   :::image type="content" source="../media/3-permissions-secrets/github-secrets.png" alt-text="Screenshot that shows the list of Repository secrets on the Actions secrets and variables page." lightbox="../media/3-permissions-secrets/github-secrets.png":::

In this unit, you verified that the app deployed correctly. You then created an Azure AD service principal for GitHub access and stored related sensitive information as GitHub secrets.
