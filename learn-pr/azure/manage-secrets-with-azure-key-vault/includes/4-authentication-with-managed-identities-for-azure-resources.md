Azure Key Vault uses Microsoft Entra ID to authenticate users and apps that try to access a vault. To grant our web app access to the vault, you first need to register your app with Microsoft Entra ID. Registering creates an identity for the app. After the app has an identity, you can assign vault permissions to it.

Apps and users authenticate to Key Vault using a Microsoft Entra authentication token. Getting a token from Microsoft Entra ID requires a secret or certificate. Anyone with a token could use the app identity to access all of the secrets in the vault.

Your app secrets are secure in the vault, but you still need to keep a secret or certificate outside of the vault to access them! This issue is called the *bootstrapping problem*, and Azure has a solution for it.

## Managed identities for Azure resources

Managed identities for Azure resources is an Azure feature your app can use to access Key Vault and other Azure services without having to manage a single secret outside of the vault. Using a managed identity is a simple and secure way to take advantage of Key Vault from your web app.

When you enable managed identity on your web app, Azure activates a separate token-granting REST service specifically for your app to use. Your app requests tokens from this service instead of directly from Microsoft Entra ID. Your app needs to use a secret to access this service, but that secret is injected into your app's environment variables by App Service when it starts up. You don't need to manage or store this secret value anywhere, and nothing outside of your app can access this secret or the managed identity token service endpoint.

Managed identities for Azure resources also registers your app in Microsoft Entra ID for you. Microsoft Entra ID deletes the registration if you delete the web app or disable its managed identity.

Managed identities are available in all editions of Microsoft Entra ID, including the Free edition included with an Azure subscription. Using it in App Service has no extra cost and requires no configuration, and you can enable or disable it on an app at any time.

Enabling a managed identity for a web app requires only a single Azure CLI command with no configuration. You do it later when you set up an App Service app and deploy it to Azure. Before that, though, apply your knowledge of managed identities to write the code for our app.
