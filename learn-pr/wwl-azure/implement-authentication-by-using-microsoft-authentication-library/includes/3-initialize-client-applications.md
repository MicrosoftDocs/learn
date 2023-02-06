
With MSAL.NET 3.x, the recommended way to instantiate an application is by using the application builders: `PublicClientApplicationBuilder` and `ConfidentialClientApplicationBuilder`. They offer a powerful mechanism to configure the application either from the code, or from a configuration file, or even by mixing both approaches.

Before initializing an application, you first need to register it so that your app can be integrated with the Microsoft identity platform.  After registration, you may need the following information (which can be found in the Azure portal):

* The client ID (a string representing a GUID)
* The identity provider URL (named the instance) and the sign-in audience for your application. These two parameters are collectively known as the authority.
* The tenant ID if you are writing a line of business application solely for your organization (also named single-tenant application).
* The application secret (client secret string) or certificate (of type X509Certificate2) if it's a confidential client app.
* For web apps, and sometimes for public client apps (in particular when your app needs to use a broker), you'll have also set the redirectUri where the identity provider will contact back your application with the security tokens.

## Initializing public and confidential client applications from code

The following code instantiates a public client application, signing-in users in the Microsoft Azure public cloud, with their work and school accounts, or their personal Microsoft accounts.

```csharp
IPublicClientApplication app = PublicClientApplicationBuilder.Create(clientId).Build();
```

In the same way, the following code instantiates a confidential application (a Web app located at `https://myapp.azurewebsites.net`) handling tokens from users in the Microsoft Azure public cloud, with their work and school accounts, or their personal Microsoft accounts. The application is identified with the identity provider by sharing a client secret:

```csharp
string redirectUri = "https://myapp.azurewebsites.net";
IConfidentialClientApplication app = ConfidentialClientApplicationBuilder.Create(clientId)
    .WithClientSecret(clientSecret)
    .WithRedirectUri(redirectUri )
    .Build();
```

## Builder modifiers

In the code snippets using application builders, a number of `.With` methods can be applied as modifiers (for example, `.WithAuthority` and `.WithRedirectUri`).

* `.WithAuthority` modifier: The `.WithAuthority` modifier sets the application default authority to an Azure Active Directory authority, with the possibility of choosing the Azure Cloud, the audience, the tenant (tenant ID or domain name), or providing directly the authority URI.

    ```csharp
    var clientApp = PublicClientApplicationBuilder.Create(client_id)
        .WithAuthority(AzureCloudInstance.AzurePublic, tenant_id)
        .Build();
    ```

* `.WithRedirectUri` modifier: The `.WithRedirectUri` modifier overrides the default redirect URI. In the case of public client applications, this will be useful for scenarios which require a broker.

    ```csharp
    var clientApp = PublicClientApplicationBuilder.Create(client_id)
        .WithAuthority(AzureCloudInstance.AzurePublic, tenant_id)
        .WithRedirectUri("http://localhost")
        .Build();
    ```

## Modifiers common to public and confidential client applications

The table below lists some of the modifiers you can set on a public, or confidential client.

| Modifier | Description |
|--|--|
| `.WithAuthority()` | Sets the application default authority to an Azure Active Directory authority, with the possibility of choosing the Azure Cloud, the audience, the tenant (tenant ID or domain name), or providing directly the authority URI. |
| `.WithTenantId(string tenantId)` | Overrides the tenant ID, or the tenant description. |
| `.WithClientId(string)` | Overrides the client ID. |
| `.WithRedirectUri(string redirectUri)` | Overrides the default redirect URI. In the case of public client applications, this will be useful for scenarios requiring a broker. |
| `.WithComponent(string)` | Sets the name of the library using MSAL.NET (for telemetry reasons). |
| `.WithDebugLoggingCallback()` | If called, the application will call `Debug.Write` simply enabling debugging traces. |
| `.WithLogging()` | If called, the application will call a callback with debugging traces. |
| `.WithTelemetry(TelemetryCallback telemetryCallback)` | Sets the delegate used to send telemetry. |


## Modifiers specific to confidential client applications

The modifiers you can set on a confidential client application builder are:

| Modifier | Description |
|--|--|
| `.WithCertificate(X509Certificate2 certificate)` | Sets the certificate identifying the application with Azure Active Directory. |
| `.WithClientSecret(string clientSecret)` | Sets the client secret (app password) identifying the application with Azure Active Directory. |
