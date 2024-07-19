With MSAL.NET 3.x, the recommended way to instantiate an application is by using the application builders: `PublicClientApplicationBuilder` and `ConfidentialClientApplicationBuilder`. They offer a powerful mechanism to configure the application either from the code, or from a configuration file, or even by mixing both approaches.

Before initializing an application, you first need to register it so that your app can be integrated with the Microsoft identity platform.  After registration, you may need the following information (which can be found in the Azure portal):

* **Application (client) ID** - This is a string representing a GUID.
* **Directory (tenant) ID** - Provides identity and access management (IAM) capabilities to applications and resources used by your organization. It can specify if you're writing a line of business application solely for your organization (also named single-tenant application).
* The identity provider URL (named the **instance**) and the sign-in audience for your application. These two parameters are collectively known as the authority.
* **Client credentials** - which can take the form of an application secret (client secret string) or certificate (of type `X509Certificate2`) if it's a confidential client app.
* For web apps, and sometimes for public client apps (in particular when your app needs to use a broker), you need to set the **Redirect URI** where the identity provider will contact back your application with the security tokens.

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

In the code snippets using application builders, `.With` methods can be applied as modifiers (for example, `.WithAuthority` and `.WithRedirectUri`).

* `.WithAuthority` modifier: The `.WithAuthority` modifier sets the application default authority to a Microsoft Entra authority, with the possibility of choosing the Azure Cloud, the audience, the tenant (tenant ID or domain name), or providing directly the authority URI.

    ```csharp
    IPublicClientApplication app;
    app = PublicClientApplicationBuilder.Create(clientId)
        .WithAuthority(AzureCloudInstance.AzurePublic, tenantId)
        .Build();
    ```

* `.WithRedirectUri` modifier: The `.WithRedirectUri` modifier overrides the default redirect URI. 

    ```csharp
    IPublicClientApplication app;
    app = PublicClientApplicationBuilder.Create(client_id)
        .WithAuthority(AzureCloudInstance.AzurePublic, tenant_id)
        .WithRedirectUri("http://localhost")
        .Build();
    ```

## Modifiers common to public and confidential client applications

The table below lists some of the modifiers you can set on a public, or confidential client.

| Modifier | Description |
|--|--|
| `.WithAuthority()` | Sets the application default authority to a Microsoft Entra authority, with the possibility of choosing the Azure Cloud, the audience, the tenant (tenant ID or domain name), or providing directly the authority URI. |
| `.WithTenantId(string tenantId)` | Overrides the tenant ID, or the tenant description. |
| `.WithClientId(string)` | Overrides the client ID. |
| `.WithRedirectUri(string redirectUri)` | Overrides the default redirect URI. This is useful for scenarios requiring a broker. |
| `.WithComponent(string)` | Sets the name of the library using MSAL.NET (for telemetry reasons). |
| `.WithDebugLoggingCallback()` | If called, the application calls `Debug.Write` simply enabling debugging traces. |
| `.WithLogging()` | If called, the application calls a callback with debugging traces. |
| `.WithTelemetry(TelemetryCallback telemetryCallback)` | Sets the delegate used to send telemetry. |


## Modifiers specific to confidential client applications

The modifiers specific to a confidential client application builder can be found in the `ConfidentialClientApplicationBuilder` class. The different methods can be found in the [Azure SDK for .NET documentation](/dotnet/api/microsoft.identity.client.confidentialclientapplicationbuilder).

Modifiers such as `.WithCertificate(X509Certificate2 certificate)` and `.WithClientSecret(string clientSecret)` are mutually exclusive. If you provide both, MSAL throws a meaningful exception.
