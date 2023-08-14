Suppose you've decided to use OpenID Connect with your transportation company's app to allow users to authenticate by using the same credentials they use to access Microsoft 365. These credentials are stored in Azure Active Directory (Azure AD). Let's look at the resources and configuration you'll need to set this up properly.

## Create an Azure AD tenant

A tenant is an instance of Azure AD that represents an organization. It's a dedicated instance of Azure AD that an organization or app developer receives when the organization or app developer creates a relationship with Microsoft, like signing up for Azure, Microsoft Intune, or Microsoft 365.

Each Azure AD tenant is distinct and separate from other Azure AD tenants. An Azure AD tenant has its own representation of work and school identities and app registrations. An app registration inside your tenant can allow authentication from accounts only within your tenant or across all tenants.

Azure AD tenants are created in the *.onmicrosoft.com* domain by default. You can't delete or change this name, but you can add your own registered domain name, then create users and app registrations within that domain.

Azure AD tenants can be created only in the Azure portal.

## Register a web app

Within the Azure AD tenant, you'll need a registration for the application. The registration is a record of security details for the application in Azure AD. A registration ensures that Azure AD can identify the application and the user. An app registration includes these details:

- **Name**: This value identifies the registration and application.
- **Application type**: Use the **Web app/API** type for websites or web APIs that are accessed through the HTTP protocol. Use the **Native** type for applications that are installed on a user's device or computer.
- **Sign-on URL**: This value is the location of the sign-on page in the published application.
- **Application ID**: This generated GUID is unique to the registration. Configure your application to send the same GUID to Azure AD whenever it authenticates a user.

You can configure application registrations in the Azure portal. Applications are registered on the **App registrations** > **New application registration** page for the Azure AD tenant.

## Configure the app for authentication

There's a lot of detail to ensure that the OpenID Connect protocol specifications are followed properly. To help developers use OpenID Connect in their applications, Microsoft provides middleware to facilitate this communication. This middleware consists of APIs that include methods and properties that make it easy to interact with the identity provider.

The middleware is available for several different platforms. Microsoft supplies and supports middleware libraries for .NET Framework, .NET Core, and Node.js. There are also client-side libraries for JavaScript, Angular, PHP, and other platforms.

For example, if you have an ASP.NET Core 2.X web app and you need to use the OpenID Connect protocol to authenticate users using Azure AD, you can use the `Microsoft.AspNetCore.Authentication.AzureAD.UI` NuGet package. Then, add the following values to the `appsettings.json` file:

- `ida:Tenant`. This configuration value is the identity of the Azure AD directory that contains the application registration.
- `ida:ClientId`. This configuration value is the GUID that uniquely identifies the client registration.

Then, configure the authentication middleware in the `Startup.ConfigureServices` method:

```csharp
services.Configure<CookiePolicyOptions>(options =>
    {
        options.CheckConsentNeeded = context => true;
        options.MinimumSameSitePolicy = SameSiteMode.None;
    });

services.AddAuthentication(AzureADDefaults.AuthenticationScheme)
    .AddAzureAD(options => Configuration.Bind("AzureAd", options));

services.Configure<OpenIdConnectOptions>(AzureADDefaults.OpenIdScheme, options =>
    {
        options.Authority = options.Authority + "/v2.0/";
        options.TokenValidationParameters.ValidateIssuer = false;
    });
```

You can use the authentication middleware to sign in users from one or more Azure AD tenants. The middleware is initialized in the `Startup.Auth.cs` file by passing it the client ID of the application and the URL of the Azure AD tenant where the application is registered. The middleware then takes care of:

- Downloading the Azure AD metadata.
- Processing OpenID Connect authentication responses.
- Integration with the session cookie.
