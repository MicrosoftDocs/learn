Azure App Service provides built-in authentication and authorization support, so you can sign in users and access data by writing minimal or no code in your web app, API, and mobile back end, and also Azure Functions.

Secure authentication and authorization requires deep understanding of security, including federation, encryption, JSON web tokens (JWT) management, grant types, and so on. App Service provides these utilities so that you can spend more time and energy on providing business value to your customer.

> [!NOTE]
> You're not required to use App Service for authentication and authorization. Many web frameworks are bundled with security features, and you can use them if you like.

## How it works

:::image type="content" source="../media/secure-app-service-180b001e.png" alt-text="Screenshot of the App Service authentication being enabled and configured to Login to Azure Active Directory.":::


The authentication and authorization module runs in the same sandbox as your application code. When it's enabled, every incoming HTTP request passes through it before being handled by your application code. This module handles several things for your app:

 -  Authenticates users with the specified provider.
 -  Validates, stores, and refreshes tokens.
 -  Manages the authenticated session.
 -  Injects identity information into request headers.

The module runs separately from your application code and is configured using app settings. No SDKs, specific languages, or changes to your application code are required.

## Configuration settings

In the Azure portal, you can configure App Service with a number of behaviors:

1.  **Allow Anonymous requests (no action):** This option defers authorization of unauthenticated traffic to your application code. For authenticated requests, App Service also passes along authentication information in the HTTP headers.This option provides more flexibility in handling anonymous requests. It lets you present multiple sign-in providers to your users.
2.  **Allow only authenticated requests:** The option is **Log in with \<provider\>**. App Service redirects all anonymous requests to `/.auth/login/<provider>` for the provider you choose. If the anonymous request comes from a native mobile app, the returned response is an `HTTP 401 Unauthorized`. With this option, you don't need to write any authentication code in your app.

> [!NOTE]
> Restricting access in this way applies to all calls to your app, which may not be desirable for apps wanting a publicly available home page, as in many single-page applications.

## Logging and tracing

If you enable application logging, you will see authentication and authorization traces directly in your log files. If you see an authentication error that you didn’t expect, you can conveniently find all the details by looking in your existing application logs. If you enable failed request tracing, you can see exactly what role the authentication and authorization module may have played in a failed request. In the trace logs, look for references to a module named `EasyAuthModule_32/64`.
