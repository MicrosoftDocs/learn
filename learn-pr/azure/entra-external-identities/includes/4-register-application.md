## Exercise - Register an application

To enable your app to sign in with Microsoft Entra External ID, you need to register the application in the directory.

> [!NOTE]
> You'll need at least the [Application Developer](/entra/identity/role-based-access-control/permissions-reference#application-developer) directory role to register an application. 
>
> **This role is a privileged role**. [Please read about best practices for working with privileged roles](/entra/identity/role-based-access-control/privileged-roles-permissions?tabs=admin-center#best-practices-for-using-privileged-roles).
>
> Do you have feedback? [Please let us know how your proof of concept project is going. We'd love to hear from you!](https://forms.microsoft.com/r/Um1E3Sexnk)

::: zone pivot="microsoft-entra-admin-center"

1. To register your own application, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) and browse to **Applications** > **App registrations**. Then, select **+ New registration**.

   [ ![Screenshot of App registrations blade with a button titled New registration highlighted.](../media/register-an-application/1_inline.png) ](../media/register-an-application/1.png#lightbox)

1. In the **Register an application** page that appears, enter a meaningful application **Name** that is displayed to users of the app, for example, **Woodgrove Groceries**. Under **Supported account types**, select **Accounts in this organizational directory only**. For **Platform**, select the **Web** option and enter your app **Redirect URI**. The redirect URI is the endpoint to which users are redirected by Microsoft Entra External ID after their authentication with Microsoft Entra External ID is completed.

   [ ![Screenshot of Register an application blade with Accounts in this organizational directory only highlighted for Who can use this application or access this API? and redirect URI is highlighted and set to Web as well as the URL for where to redirect the user after successful authentication.](../media/register-an-application/2_inline.png) ](../media/register-an-application/2.png#lightbox)

1. The application's **Overview** pane displays upon successful registration. Record the **Application (client) ID** to be used in your application source code.

   [ ![Screenshot of App registrations with Overview in the left navigation highlighted. The application (client) ID is also highlighted under Essentials.](../media/register-an-application/3_inline.png) ](../media/register-an-application/3.png#lightbox)

1. To add more **Redirect URIs** or a **Front-channel logout URL**, under **Manage**, select **Authentication**. The **Front-channel logout URL** is where we send a request to have the application clear the user's session data. This is required for single sign-out to work correctly.

   [ ![Screenshot of Authentication blade under App registrations with the URI highlighted under Web Redirect URIs as well as the URL for Front-channel logout URL.](../media/register-an-application/4_inline.png) ](../media/register-an-application/4.png#lightbox)

1. For a web application (confidential client) to acquire an access token, it needs a credential to prove its identity to Microsoft Entra ID. You can add certificates, client secrets (a string), or federated identity credentials as credentials to your confidential client app registration. For the groceries website, we will use a certificate. To add a certificate, select **Certificates & secrets** > **Certificates** > **Upload certificate**.

   [ ![Screenshot of Certificates and secrets blade under App registrations where there are zero certificates and highlights a button titled Upload certificate.](../media/register-an-application/5_inline.png) ](../media/register-an-application/5.png#lightbox)

1. Select the file you want to upload. It must be one of the following file types: .cer, .pem, .crt. Then select **Add**.

   [ ![Screenshot of Upload certificate pane open to the right with upload icon highlighted to upload certificate.](../media/register-an-application/6_inline.png) ](../media/register-an-application/6.png#lightbox)

1. In the following steps, you will add the required permission for the web application. Under **Manage**, select **API permissions**, then select **Add a permission**.

   [ ![Screenshot of API permissions under App registrations with a button titled Add a permission highlighted.](../media/register-an-application/7_inline.png) ](../media/register-an-application/7.png#lightbox)

1. In **Request API permissions**, select the **Microsoft APIs** tab, and then select **Microsoft Graph**.

   [ ![Screenshot of Request API permissions pane open to the right with a choice group titled Microsoft Graph highlighted.](../media/register-an-application/8_inline.png) ](../media/register-an-application/8.png#lightbox)

1. Select the **Delegated permissions** option. Then, under **Select permissions** section, search for and select both **openid** and **offline_access** permissions. To complete, select **Add permissions**.

   [ ![Screenshot of Request API permissions pane open to the right with a choice group titled Delegated permissions highlighted and permissions for offline_access and openid checked in checkboxes underneath.](../media/register-an-application/9_inline.png) ](../media/register-an-application/9.png#lightbox)

1. At this point, you've assigned the permissions correctly. However, since the tenant is an external tenant, the consumer users themselves can't consent to these permissions. You as the admin must consent to these permissions on behalf of all the users in the tenant: Select **Grant admin consent for `<your tenant name>`**, then select **Yes**.

   [ ![Screenshot of a button titled Grant admin consent for Woodgrove Groceries highlighted in the API permissions blade.](../media/register-an-application/10_inline.png) ](../media/register-an-application/10.png#lightbox)
   
    ***Well done!** Now your application is ready to use.*

::: zone-end

::: zone pivot="microsoft-graph-api"

#### 1. Register an application

[To register a web application](/graph/api/application-post-applications?view=graph-rest-1.0&tabs=http), use the Microsoft Graph request below and replace the following values.
- Value of **displayName** with your app displayed name. For example, *Woodgrove Groceries*.
- Values of the **redirectUris** with the redirect URI of your application. For example, *<https://woodgrovedemo.com/signin-oidc>*. You can also use *https://www.jwt.ms/*.

    ```json
    POST https://graph.microsoft.com/v1.0/applications
    {
        "displayName": "Woodgrove Groceries",
        "description": "Woodgrove Groceries live demo application",
        "signInAudience": "AzureADMyOrg",
        "api": {
            "acceptMappedClaims": true,
            "requestedAccessTokenVersion": 2
        },
        "requiredResourceAccess": [
            {
                "resourceAppId": "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1",
                "resourceAccess": [
                    {
                        "id": "b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2",
                        "type": "Scope"
                    },
                    {
                        "id": "c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3",
                        "type": "Scope"
                    }
                ]
            }
        ],
        "web": {
            "redirectUris": [
                "https://woodgrovedemo.com/signin-oidc"
            ],
            "implicitGrantSettings": {
                "enableAccessTokenIssuance": false,
                "enableIdTokenIssuance": false
            }
        }
    }
    ```

##### 1.1 Copy the application ID

From the response, copy the value of the **appId**. For example:

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
    "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
    "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "displayName": "Woodgrove Groceries",
    "description": "Woodgrove Groceries live demo application",
    ...
}      
```

#### 2. Create a service principal for your application

After you register your application, [create a service principal](/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0&tabs=http). The following Graph call creates a service principal. Replace the **{appId}** with the app **appId** from the previous call (not the object ID).

```json
POST https://graph.microsoft.com/v1.0/servicePrincipals
{
    "appId": "{appId}"
}
```

##### 2.1 Copy the service principal ID

From the response, copy the value of the **id**. For example:

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity",
    "id": "bbbbbbbb-1111-2222-3333-cccccccccccc",
    "displayName": "Woodgrove Groceries",
    "description": "Woodgrove Groceries live demo application",
    ...
}
```

#### 3. Consent to the required permissions

Since the tenant is an external tenant, the consumer users themselves can't consent to these permissions. You as the admin must [consent to these permissions](/graph/api/oauth2permissiongrant-post?view=graph-rest-1.0&tabs=http) on behalf of all the users in the tenant.

##### 3.1 Get the Microsoft Graph's service principal ID

Run the following GET request and copy the **id** from the response:

```json
GET https://graph.microsoft.com/v1.0/servicePrincipals(appId='22223333-cccc-4444-dddd-5555eeee6666')
{
    "id": "cccccccc-2222-3333-4444-dddddddddddd",
    "appDisplayName": "Microsoft Graph",
    "appId": "22223333-cccc-4444-dddd-5555eeee6666"
}
```

##### 3.2 Grant the required permissions

Replace the **{service-principal-id}** with the service-principal **id** you copied in the previous step. Replace the **{graph-service-principal-id}** with the service-principal **id** you copied in the last step.

```json
POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
{
    "clientId": "{service-principal-id}",
    "consentType": "AllPrincipals",
    "resourceId": "{graph-service-principal-id}",
    "scope": "openid offline_access"
}
```

#### 4. (Optional) Add a client secret

Credentials enable confidential applications to identify themselves to the authentication service when receiving tokens. For a higher level of assurance, we recommend using a [certificate](/graph/api/application-addkey?view=graph-rest-1.0&tabs=http) (instead of a client secret) as a credential. To obtain the [client secret](/graph/api/application-addpassword?view=graph-rest-1.0&tabs=http), run the following request. Replace the **{graph-service-principal-id}** with the **appId** with the appId from the first step.

```json
POST https://graph.microsoft.com/v1.0/applications(appId='appId')/addPassword
{
    "passwordCredential": {
        "displayName": "My app client secret"
    }
}
```

From the response, copy the value of the **secretText**:

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.passwordCredential",
    "displayName": "My app client secret",
    "endDateTime": "2026-05-23T15:16:42",
    "hint": "<Your hint will show up here>",
    "keyId": "aaaaaaaa-0b0b-1c1c-2d2d-333333333333",
    "secretText": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u",
    "startDateTime": "2024-05-23T15:16:42"
}
```

::: zone-end
