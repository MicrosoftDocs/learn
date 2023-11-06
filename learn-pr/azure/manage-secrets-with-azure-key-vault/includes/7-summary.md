In this module, you secured an app's secret configuration in Azure Key Vault. Your app code authenticated to the vault with a managed identity, and automatically loaded the secrets from the vault into memory at startup.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

To clean up your Cloud Shell storage, delete the *KeyVaultDemoApp* directory.

## Next steps

If this app was a real app, what would come next?

- Put all your app secrets in your vaults! There's no longer any reason to have them in configuration files.
- Continue to develop the app. Your production environment is all set up, so you don't need to repeat all the setup for future deployments.
- To support development, create a development-environment vault that contains secrets with the same names but different values. Grant permissions to the development team and configure the vault name in the app's development-environment configuration file. Configuration depends on your implementation: for ASP.NET Core, `AddAzureKeyVault` automatically detects local installations of Visual Studio and the Azure CLI and use Azure credentials configured in those apps to sign in and access the vault. For Node.js, you can create a development-environment service principal with permissions to the vault and have the app authenticate using `loginWithServicePrincipalSecret`.
- Create more environments for purposes like user acceptance testing.
- Separate vaults across different subscriptions and resource groups to isolate them.
- Grant access to other environment vaults to the appropriate people.

## Further reading

- [Key Vault documentation](/azure/key-vault/)
- [More about AddAzureKeyVault and its advanced options](/aspnet/core/security/key-vault-configuration?tabs=aspnetcore2x&view=aspnetcore-2.1&preserve-view=true)
- [This tutorial](/azure/key-vault/key-vault-use-from-web-application) walks through using a Key Vault `SecretClient`, including manually authenticating it to Microsoft Entra ID using a client secret instead of using a managed identity.
- [Managed identities for Azure resources token service documentation](/azure/app-service/app-service-managed-service-identity#using-the-rest-protocol) for implementing the authentication workflow yourself.
