Microsoft identity platform is an evolution of the Azure Active Directory (Azure AD) developer platform. It allows developers to build applications that sign in users, get tokens to call APIs, such as Microsoft Graph, or APIs that developers have built. It consists of an authentication service, open-source libraries, application registration, and configuration (through a developer portal and application API), full developer documentation, quickstart samples, code samples, tutorials, how-to guides, and other developer content. The Microsoft identity platform supports industry-standard protocols such as OAuth 2.0 and OpenID Connect.

Up until now, most developers have worked with the Azure AD v1.0 platform to authenticate work and school accounts (provisioned by Azure AD) by requesting tokens from the Azure AD v1.0 endpoint, using Azure AD Authentication Library (ADAL), Azure portal for application registration and configuration, and the Microsoft Graph API for programmatic application configuration.

With the unified Microsoft identity platform (v2.0), you can write code once and authenticate any Microsoft identity into your application. For several platforms, the fully supported open-source Microsoft Authentication Library (MSAL) is recommended for use against the identity platform endpoints. MSAL is simple to use, provides great single sign-on (SSO) experiences for your users, helps you achieve high reliability and performance, and is developed using Microsoft Secure Development Lifecycle (SDL). When calling APIs, you can configure your application to take advantage of incremental consent, which allows you to delay the request for consent for more invasive scopes until the application’s usage warrants this at runtime. MSAL also supports Azure Active Directory B2C, so your customers use their preferred social, enterprise, or local account identities to get single sign-on access to your applications and APIs.

With Microsoft identity platform, one can expand their reach to these kinds of users:

 -  Work and school accounts (Azure AD provisioned accounts)
 -  Personal accounts (such as Outlook.com or Hotmail.com)
 -  Your customers who bring their own email or social identity (such as LinkedIn, Facebook, Google) via MSAL and Azure AD B2C

You can use the Azure portal to register and configure your application and use the Microsoft Graph API for programmatic application configuration.

### Microsoft identity platform<br>

The following diagram depicts the Microsoft identity experience at a high level, including the app registration experience, software development kits (SDKs), endpoints, and supported identities.

:::image type="content" source="../media/MSFT%20Identity%20Platform%20for%20Developers1A.jpg-4a8416c5.png":::


MSAL can be used in many application scenarios, including the following:

 -  Single-page applications (JavaScript)
 -  Web app signing in users
 -  Web application signing in a user and calling a web API on behalf of the user
 -  Protecting a web API so only authenticated users can access it
 -  Web API calling another downstream Web API on behalf of the signed-in user
 -  Desktop application calling a web API on behalf of the signed-in user
 -  Mobile application calling a web API on behalf of the user who's signed in interactively.
 -  Desktop/service daemon application calling web API on behalf of itself

:::row:::
  :::column:::
    **Library**
  :::column-end:::
  :::column:::
    **Supported platforms and frameworks**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL for Android
  :::column-end:::
  :::column:::
    Android
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL Angular
  :::column-end:::
  :::column:::
    Single-page apps with Angular and Angular.js frameworks
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL for iOS and macOS
  :::column-end:::
  :::column:::
    iOS and macOS
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL Go (Preview)
  :::column-end:::
  :::column:::
    Windows, macOS, Linux
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL Java
  :::column-end:::
  :::column:::
    Windows, macOS, Linux
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL.js
  :::column-end:::
  :::column:::
    JavaScript/TypeScript frameworks such as Vue.js, Ember.js, or Durandal.js
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL.NET
  :::column-end:::
  :::column:::
    .NET Framework, .NET Core, Xamarin Android, Xamarin iOS, Universal Windows Platform
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL Node
  :::column-end:::
  :::column:::
    Web apps with Express, desktop apps with Electron, Cross-platform console apps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL Python
  :::column-end:::
  :::column:::
    Windows, macOS, Linux
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MSAL React
  :::column-end:::
  :::column:::
    Single-page apps with React and React-based libraries (Next.js, Gatsby.js)
  :::column-end:::
:::row-end:::


The Microsoft identity platform has two endpoints (v1.0 and v2.0) and two sets of client libraries to handle these endpoints. When developing a new application, consider the advantages and the current state of the endpoints and the authentication libraries. Also, consider that:<br>

 -  The supported platforms are as follows:
    
     -  The Azure AD Authentication Library (ADAL) supports Microsoft .NET, JavaScript, iOS, Android, Java, and Python.
     -  The Microsoft Authentication Library (MSAL) supports .NET, JavaScript, and in preview iOS, and Android.
     -  Other endpoints support .NET and Node.js server middleware for protecting APIs and sign-in.
 -  The bulk of innovation, such as dynamic consent and incremental consent, is happening on the v2.0 endpoint and MSAL while Microsoft continues to support v1.0 and ADAL.

These are the five primary application scenarios that Azure AD supports:

 -  Single-page application (SPA) - A user needs to sign in to a single-page application that Azure AD helps secure.
 -  Web browser to web application - A user needs to sign in to a web application that Azure AD helps secure.
 -  Native application to web API - A native application that runs on a phone, tablet, or computer needs to authenticate a user to get resources from a web API that Azure AD helps secure.
 -  Web application to web API - A web application needs to get resources from a web API that Azure AD helps secure.
 -  Daemon or server application to web API - A daemon application or a server application with no web user interface needs to get resources from a web API that Azure AD helps secure.

### Migrate apps that use ADAL to MSAL

Active Directory Authentication Library (ADAL) integrates with the Azure AD for developers (v1.0) endpoint, where MSAL integrates with the Microsoft identity platform. The v1.0 endpoint supports work accounts, but not personal accounts. The v2.0 endpoint is the unification of Microsoft personal accounts and works accounts into a single authentication system. Additionally, with MSAL you can also get authentications for Azure AD B2C.
