In this module, you:

- Reviewed ASP.NET Core app configuration concepts.
- Implemented a centralized Azure App Configuration store.
- Implemented feature flags in an ASP.NET Core app.
- Implemented configuration settings in an ASP.NET Core app.

## Remove Azure resources

> [!IMPORTANT]
> It's important to deprovision the Azure resources you used in this module to avoid accruing unwanted charges.

To remove all the resources created in this module, run the following command:

```azurecli
az group delete --name rg-eshop --yes
```

The preceding command deletes the resource group that contains the Azure App Configuration instance.

## Cleanup Codespace

You can delete the codespace on [GitHub](https://github.com/codespaces) under **By repository** where you see **MicrosoftDocs/mslearn-dotnet-cloudnative**.

## Learn more about Azure App Configuration

* [Azure App Configuration documentation](/azure/azure-app-configuration/)
* [Quickstart: Add feature flags to an ASP.NET Core app](/azure/azure-app-configuration/quickstart-feature-flag-aspnet-core)
* [Quickstart: Create an ASP.NET Core app with Azure App Configuration](/azure/azure-app-configuration/quickstart-aspnet-core-app)