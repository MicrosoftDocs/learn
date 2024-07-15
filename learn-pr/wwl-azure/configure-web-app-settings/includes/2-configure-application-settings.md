In App Service, app settings are variables passed as environment variables to the application code. For Linux apps and custom containers, App Service passes app settings to the container using the `--env` flag to set the environment variable in the container.

Application settings can be accessed by navigating to your app's management page and selecting **Environment variables > Application settings**.

:::image type="content" source="../media/configure-app-settings.png" alt-text="Navigating to Environment variables > Application settings":::

For ASP.NET and ASP.NET Core developers, setting app settings in App Service is like setting them in `<appSettings>` in *Web.config* or *appsettings.json*, but the values in App Service override the ones in *Web.config* or *appsettings.json*. You can keep development settings (for example, local MySQL password) in *Web.config* or *appsettings.json* and production secrets (for example, Azure MySQL database password) safely in App Service. The same code uses your development settings when you debug locally, and it uses your production secrets when deployed to Azure.

App settings are always encrypted when stored (encrypted-at-rest).

## Adding and editing settings

To add a new app setting, select **+ Add**. If you're using deployment slots you can specify if your setting is swappable or not. In the dialog, you can stick the setting to the current slot.

:::image type="content" source="../media/app-configure-slotsetting.png" alt-text="Selecting deployment slot setting to stick the setting to the current slot.":::

When finished, select **Apply**. Don't forget to select **Apply** back in the **Environment variables** page.

> [!NOTE]
> In a default Linux app service or a custom Linux container, any nested JSON key structure in the app setting name like `ApplicationInsights:InstrumentationKey` needs to be configured in App Service as `ApplicationInsights__InstrumentationKey` for the key name. In other words, any `:` should be replaced by `__` (double underscore). Any periods in the app setting name will be replaced with a `_` (single underscore).

### Editing application settings in bulk

To add or edit app settings in bulk, select the **Advanced edit** button. When finished, select **OK**. Don't forget to select Apply back in the Environment variables page. App settings have the following JSON formatting:

```json
[
  {
    "name": "<key-1>",
    "value": "<value-1>",
    "slotSetting": false
  },
  {
    "name": "<key-2>",
    "value": "<value-2>",
    "slotSetting": false
  },
  ...
]
```

## Configure connection strings

For ASP.NET and ASP.NET Core developers, setting connection strings in App Service are like setting them in `<connectionStrings>` in *Web.config*, but the values you set in App Service override the ones in *Web.config*. For other language stacks, it's better to use app settings instead, because connection strings require special formatting in the variable keys in order to access the values.

> [!TIP]
> There is one case where you may want to use connection strings instead of app settings for non-.NET languages: certain Azure database types are backed up along with the app *only* if you configure a connection string for the database in your App Service app.

Adding and editing connection strings follow the same principles as other app settings and they can also be tied to deployment slots. An example of connection strings in JSON formatting that you would use for bulk adding or editing:

```json
[
  {
    "name": "name-1",
    "value": "conn-string-1",
    "type": "SQLServer",
    "slotSetting": false
  },
  {
    "name": "name-2",
    "value": "conn-string-2",
    "type": "PostgreSQL",
    "slotSetting": false
  },
  ...
]
```

> [!NOTE]
> .NET apps targeting PostgreSQL should set the connection string to **Custom** as workaround for a known issue in .NET EnvironmentVariablesConfigurationProvider.

## Configure environment variables for custom containers

Your custom container might use environment variables that need to be supplied externally. You can pass them in via the Cloud Shell. In Bash:

```azurecli
az webapp config appsettings set --resource-group <group-name> --name <app-name> --settings key1=value1 key2=value2
```

In PowerShell:

```azurepowershell
Set-AzWebApp -ResourceGroupName <group-name> -Name <app-name> -AppSettings @{"DB_HOST"="myownserver.mysql.database.azure.com"}
```

When your app runs, the App Service app settings are injected into the process as environment variables automatically. You can verify container environment variables with the URL `https://<app-name>.scm.azurewebsites.net/Env`.
