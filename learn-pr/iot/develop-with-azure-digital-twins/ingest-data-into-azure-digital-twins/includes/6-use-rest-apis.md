In this unit, learn about the Azure Digital Twins REST APIs: what they're for and how to use them.

## Why REST APIs?

Some application architectures don't support the Azure Digital Twins SDK. In such cases, you can use the Azure Digital Twins REST APIs to perform both control-plane operations (for example, to create Digital Twins instances) and data-plane operations (for example, ingesting telemetry or modifying Digital Twins instance properties).

For more information, see the [Azure Digital Twins REST APIs documentation](https://docs.microsoft.com/en-us/rest/api/azure-digitaltwins/).

## API authentication

Use the OAuth 2.0 client-credentials grant, specified in RFC 6749 and sometimes called "two-legged OAuth", to access web-hosted resources by using the identity of an application. This type of grant is commonly used for server-to-server interactions that must run in the background, without immediate interaction with a user. These types of applications are often called daemons or service accounts.

For more information on different authentication patterns, see the [Azure Active Directory documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-app-types).

### Grant admin consent

Your organization might require extra actions from subscription owners or administrators to successfully set up an app registration. The steps required might vary depending on your organization's specific settings. Admins perform such operations on the [Azure Active Directory App registrations](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps) page in the Azure portal.

The **Grant admin consent for [*company*]** action is often required for app registration. Your organization might have **Admin Consent Required** turned on globally in Azure Active Directory (Azure AD) for all app registrations within your subscription. If so, for the app registration to be valid, the owner or administrator must select the button for your company on the API permissions page for that app registration:

:::image type="content" source= "../media/grant-admin-consent.png" alt-text="Screenshot of API permissions page for Contoso, with Grant-consent button highlighted.":::

### Retrieve token

To use the Digital Twins APIs, you'll need to get an authorization token from Azure AD:

1. Use the following command to issue a POST request to the /oauth/v2.0/token endpoint for your Azure AD tenant:

    > [!NOTE]
    > Supply the values for *tenant_id*, *client_id*, and *client_secret* as appropriate for your configuration.
    >

    ```azurecli
    curl --location --request POST 'https://login.microsoftonline.com/tenant_id/oauth2/v2.0/token' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'client_id= <applicationid>' \
    --data-urlencode 'scope=https://digitaltwins.azure.net/.default' \
    --data-urlencode 'client_secret=<secret/pwd>' \
    --data-urlencode 'grant_type=client_credentials'
    ```

1. Azure AD responds with a bearer token that will be used in the next section:
    :::image type="content" source= "../media/bearertoken.png" alt-text="Partial screenshot of bearer-token text displayed in a console window.":::

## Use REST APIs

Run the following command to update the REST API property in the thermostat67 digital twin.

> [!NOTE]
> Supply the values for *adt_hostname* and *aad_token*.
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

## Query the twin to see the update

 To view the data added by the REST API call, run the following command:

```azurecli
az dt twin show -n $dtname --twin-id GrindingStep
```
