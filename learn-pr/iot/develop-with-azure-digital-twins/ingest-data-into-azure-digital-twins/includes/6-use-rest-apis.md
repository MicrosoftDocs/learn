## Why REST APIs?

Some application architectures will not support using the Azure Digital Twin SDK. In this scenario, the Azure Digital Twin REST APIs are used to perform both Control Plane operations (ex: Create Azure digital twin instances) and Data Plane operations (ex: ingesting telemetry / modifying Azure digital twin instance properties).

More information on Azure digital twin REST APIs is found in the documentation.

 [Azure Digital Twins REST APIs](https://docs.microsoft.com/rest/api/azure-digitaltwins/)

## API authentication

Use the OAuth 2.0 client credentials grant specified in RFC 6749, sometimes called two-legged OAuth, to access web-hosted resources by using the identity of an application. This type of grant is commonly used for server-to-server interactions that must run in the background, without immediate interaction with a user. These types of applications are often referred to as daemons or service accounts.

More information on the different authentication patterns is found in the [Azure Active Directory documentation](https://docs.microsoft.com/azure/active-directory/develop/v2-app-types)

### Admin consent

It's possible that your organization requires extra actions from subscription Owners/administrators to successfully set up an app registration. The steps required may vary depending on your organization's specific settings.

Here are some common potential activities that an Owner/administrator on the subscription may need to perform. These and other operations are performed from the [Azure AD App registrations](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps) page in the Azure portal.

Grant admin consent for the app registration. Your organization may have Admin Consent Required globally turned on in Azure AD for all app registrations within your subscription. If so, the Owner/administrator will need to select this button for your company on the app registration's API permissions page for the app registration to be valid:

:::image type="content" source= "../media/grant-admin-consent.png" alt-text="Admin Consent":::

### Retrieve token

In order to use the Azure Digital Twin APIs, we'll need to get an Authorization Token from Azure Active Directory:

1. The command below will issue a POST request to the /oauth/v2.0/token endpoint for your AAD Tenant, which will respond with a bearer token

    > [!NOTE]
    > Update the values for tenant_id, client_id, and client_secret
    >

    ```azurecli
    curl --location --request POST 'https://login.microsoftonline.com/tenant_id/oauth2/v2.0/token' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'client_id= <applicationid>' \
    --data-urlencode 'scope=https://digitaltwins.azure.net/.default' \
    --data-urlencode 'client_secret=<secret/pwd>' \
    --data-urlencode 'grant_type=client_credentials'
    ```

1. Azure Active Directory will respond with a Bearer Token that will be used in the next section:
    :::image type="content" source= "../media/bearertoken.png" alt-text="Bearer Token":::

## Use REST APIs

Run the command below to update the REST API property in the thermostat67 digital twin.

> [!NOTE]
> Update the values for adt_hostname, aad_token
>

```azurecli
    curl -i --location --request POST 'https://adt_hostname/digitaltwins/GrindingStep/telemetry?api-version=2020-10-31&dt-id=1' \
    --header 'Authorization: Bearer aad_token' \
    --header 'Content-Type: application/json' \
    --header 'Message-Id: 12345' \
    --data-raw '{
        "GrindingStep": 63.2
    }'
```

## Query twin to see the update

 To view the data added by the REST API call, run the following command:

```azurecli
az dt twin show -n $dtname --twin-id GrindingStep
```
