Key Vault uses **Azure Active Directory** to authenticate users and applications that try to access a vault. To grant our web application access to the vault, we first need to register our app with Azure Active Directory. Registering creates an identity for the app. Once we have an identity, we can assign vault permissions to it.

Apps and users authenticate to Key Vault using an Azure Active Directory authentication token. Getting a token from Azure Active Directory requires a secret or certificate, because anyone with a token could use the application identity to access all of the secrets in the vault.

Our application secrets are secure in the vault, but we still need to keep a secret or certificate outside of the vault in order to access them! This problem is called the *bootstrapping problem*, and Azure has a solution for it.

## Managed Service Identity

*Managed Service Identity* (MSI) is a feature of Azure App Service that your app can use to access Key Vault and other Azure services without having to manage even a single secret. Using MSI is simpler and more secure than managing a secret yourself.

When you enable MSI, Azure activates a separate token-granting REST service specifically for use by your app. When your app requests a token from the MSI token service, the service contacts Azure Active Directory to get a token for the MSI identity and hands it back to your app for use with Key Vault. The most important part of this workflow is the way that your app authenticates to the MSI token service &mdash; instead of requiring a secret or certificate you need to manage in your configuration, your app uses a secret that Azure securely injects into its environment variables when it starts up. You don't need to manage or store this secret value anywhere. Nothing outside of your app can access this secret or the MSI token service endpoint.

MSI also registers your app in Azure Active Directory for you, and will delete the registration if you disable MSI or delete the app.

MSI is available in all editions of Azure Active Directory, including the Free edition included with an Azure subscription. Using it in App Service has no extra cost and requires no configuration, and it can be enabled or disabled on an app at any time.

> [!NOTE]
> MSI is not currently supported for Linux or Container web apps.

Enabling MSI requires only a single Azure CLI command with no configuration. We'll do it in unit 5 when we set up an App Service app and deploy to Azure. Before that, though, we're going to apply our knowledge of MSI to write the code for our app.