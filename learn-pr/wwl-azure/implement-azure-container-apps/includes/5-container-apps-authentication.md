


Azure Container Apps provides built-in authentication and authorization features to secure your external ingress-enabled container app with minimal or no code. The built-in authentication feature for Container Apps can save you time and effort by providing out-of-the-box authentication with federated identity providers, allowing you to focus on the rest of your application.

* Azure Container Apps provides access to various built-in authentication providers.
* The built-in auth features don’t require any particular language, SDK, security expertise, or even any code that you have to write.

This feature should only be used with HTTPS. Ensure `allowInsecure` is disabled on your container app's ingress configuration. You can configure your container app for authentication with or without restricting access to your site content and APIs.

* To restrict app access only to authenticated users, set its *Restrict access* setting to **Require authentication**.
* To authenticate but not restrict access, set its *Restrict access* setting to **Allow unauthenticated** access.

## Identity providers

Container Apps uses federated identity, in which a third-party identity provider manages the user identities and authentication flow for you. The following identity providers are available by default:

| Provider | Sign-in endpoint | How-To guidance |
|---|---|---|
| Microsoft Identity Platform | `/.auth/login/aad` | [Microsoft Identity Platform](/azure/container-apps/authentication-azure-active-directory) |
| Facebook | `/.auth/login/facebook` | [Facebook](/azure/container-apps/authentication-facebook) |
| GitHub | `/.auth/login/github` | [GitHub](/azure/container-apps/authentication-github) |
| Google | `/.auth/login/google` | [Google](/azure/container-apps/authentication-google) |
| Twitter | `/.auth/login/twitter` | [Twitter](/azure/container-apps/authentication-twitter) |
| Any OpenID Connect provider | `/.auth/login/<providerName>` | [OpenID Connect](/azure/container-apps/authentication-openid) |

When you use one of these providers, the sign-in endpoint is available for user authentication and authentication token validation from the provider. You can provide your users with any number of these provider options.

## Feature architecture

The authentication and authorization middleware component is a feature of the platform that runs as a sidecar container on each replica in your application. When enabled, every incoming HTTP request passes through the security layer before being handled by your application.

:::image type="content" source="../media/container-apps-authorization-architecture.png" alt-text="Diagram showing requests being intercepted by a sidecar container interacting with identity providers before allowing traffic to the app container.":::

The platform middleware handles several things for your app:

* Authenticates users and clients with the specified identity provider(s)
* Manages the authenticated session
* Injects identity information into HTTP request headers

The authentication and authorization module runs in a separate container, isolated from your application code. As the security container doesn't run in-process, no direct integration with specific language frameworks is possible. However, relevant information your app needs is provided in request headers.

## Authentication flow

The authentication flow is the same for all providers, but differs depending on whether you want to sign in with the provider's SDK:

* **Without provider SDK** (server-directed flow or server flow): The application delegates federated sign-in to Container Apps. Delegation is typically the case with browser apps, which presents the provider's sign-in page to the user.

* **With provider SDK** (client-directed flow or client flow): The application signs users in to the provider manually and then submits the authentication token to Container Apps for validation. This approach is typical for browser-less apps that don't present the provider's sign-in page to the user. An example is a native mobile app that signs users in using the provider's SDK.

