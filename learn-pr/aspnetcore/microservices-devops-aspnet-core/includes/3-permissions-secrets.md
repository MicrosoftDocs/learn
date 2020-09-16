In this unit, you'll complete the following tasks:

- Verify the app is deployed correctly
- Set up permissions to deploy to ACR and AKS from GitHub
- Create secrets to store sensitive data used by the GitHub Actions

## Verify the deployment to AKS

After the app has deployed to AKS, you'll see a variation of the following message in the command shell:

```console
The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

You can begin exploring these services (when ready):
- Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://203.0.113.55/webstatus/ (See overall service status)
- Web SPA application       : http://203.0.113.55/
```

> [!TIP]
> To display these URLs again, run the following command:
>
> ```bash
> cat ~/clouddrive/aspnet-learn-temp/deployment-urls.txt
> ```

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/3-permissions-secrets/health-check.png" alt-text="Health check page" border="true" lightbox="../media/3-permissions-secrets/health-check.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. The credentials are provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Enter the code *:::no-loc text="DISC-10":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box for a 10 USD discount, and select **:::no-loc text="APPLY":::**.

        :::image type="content" source="../media/3-permissions-secrets/discount-code-field.png" alt-text="Shopping basket with the discount code text box" border="true" lightbox="../media/3-permissions-secrets/discount-code-field.png":::

    1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

You've successfully verified that the app was deployed to AKS and is working properly. The discount code feature is supported by the coupon service. In this module, you'll build a CI/CD pipeline to automate the build and deployment of the coupon service.

## Set up permissions to deploy from GitHub

GitHub Actions will be used to publish the container image to ACR. To configure permissions so the GitHub Actions runner can connect to Azure, complete the following steps:

1. Run the following command to create an Azure Active Directory service principal to allow access from GitHub:

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

1. Copy the JSON output from the command shell. Don't include the text output above the JSON. You'll need the JSON and the credentials for the GitHub Action in next step.

## Create the secrets

The service principal and the credentials for the container registry are sensitive information. The GitHub Actions runner will need the credentials to interact with ACR and AKS. As a best practice, sensitive information should be stored as encrypted *secrets* in a secure location. The secrets should be managed by repository administrators and accessed by the GitHub Actions runner. Complete the following steps to securely store the sensitive information as environment variables in your repository:

1. In the GitHub repository you forked, go to **:::no-loc text="Settings":::** > **:::no-loc text="Secrets":::**.
1. Select the **:::no-loc text="New secret":::** button.
1. Enter `AZURE_CREDENTIALS` and the JSON output you copied in the **:::no-loc text="Name":::** and **:::no-loc text="Value":::** text boxes, respectively.

    At this point, you should have something like this:

    :::image type="content" source="../media/3-permissions-secrets/add-github-secrets.png" alt-text="AZURE_CREDENTIALS environment variable secrets page" border="true" lightbox="../media/3-permissions-secrets/add-github-secrets.png":::
1. Select the **:::no-loc text="Add secret":::** button.
1. Create four additional secrets. Run the following command to get the values for the new secrets:

    ```bash
    cat ~/clouddrive/aspnet-learn-temp/config.txt
    ```

    Name the secrets as follows and use the values provided in the text output:

    - `IP_ADDRESS`
    - `REGISTRY_LOGIN_SERVER`
    - `REGISTRY_PASSWORD`
    - `REGISTRY_USERNAME`

With all five secrets configured, you'll see the following page:

:::image type="content" source="../media/3-permissions-secrets/github-secrets.png" alt-text="Page displaying three GitHub secrets" border="true" lightbox="../media/3-permissions-secrets/github-secrets.png":::

In this unit, you verified the app was deployed correctly. You then created an Azure Active Directory service principal and stored related sensitive information as GitHub secrets.
