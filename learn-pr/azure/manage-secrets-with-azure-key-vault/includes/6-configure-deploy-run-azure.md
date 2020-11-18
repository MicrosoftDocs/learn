Now it's time to run your app in Azure. You'll need to create an Azure App Service app, set it up with a managed identity and your vault configuration, and deploy our code.

## Create the App Service plan and app

Creating an App Service app is a two-step process: First create the *plan*, then the *app*.

The *plan* name only needs to be unique within your subscription, so you can use the same name you've used: **keyvault-exercise-plan**. The app name needs to be globally unique, though, so you'll need to pick your own.

In the Azure Cloud Shell, to create an App Service plan, run the following command.

```azurecli
az appservice plan create \
    --name keyvault-exercise-plan \
    --sku FREE \
    --location centralus \
    --resource-group <rgn>[sandbox resource group name]</rgn>
```

Next, to create the Web App that uses the App Service plan you just created, run the following command.

::: zone pivot="csharp"

```azurecli
az webapp create \
    --plan keyvault-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name>
```

::: zone-end

::: zone pivot="javascript"

```azurecli
az webapp create \
    --plan keyvault-exercise-plan \
    --runtime "node|10.6" \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name>
```

::: zone-end

## Add configuration to the app

::: zone pivot="csharp"

For deploying to Azure, you'll follow the App Service best practice of putting the VaultName configuration in an app setting instead of a configuration file. To create the app setting, run this command.

```azurecli
az webapp config appsettings set \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name> \
    --settings 'VaultName=<your-unique-vault-name>'
```

::: zone-end

::: zone pivot="javascript"

For deploying to Azure, you'll follow the App Service best practice of putting the VaultName configuration in an app setting instead of a configuration file. You'll also set the `SCM_DO_BUILD_DURING_DEPLOYMENT` setting to `true` so that App Service restores our app's packages on the server and creates the necessary configuration to run the app. To create the app settings, run this command.

```azurecli
az webapp config appsettings set \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name> \
    --settings 'VaultName=<your-unique-vault-name>' 'SCM_DO_BUILD_DURING_DEPLOYMENT=true'
```

::: zone-end

## Enable managed identity

Enabling managed identity on an app is a one-liner &mdash. To enable it on your app, run this Command.

```azurecli
az webapp identity assign \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name>
```

From the JSON output that results, copy the **principalId** value. PrincipalId is the unique ID of the app's new identity in Azure Active Directory, and you're going to use it in the next step.

## Grant access to the vault

The last step before deploying is to assign Key Vault permissions to your app's managed identity. Use the **principalId** value you copied from the previous step as the value for **object-id** in the following command. To establish **Get** and **List** access, run this command.

```azurecli
az keyvault set-policy \
    --secret-permissions get list \
    --name <your-unique-vault-name> \
    --object-id <your-managed-identity-principleid>
```

## Deploy the app and try it out

::: zone pivot="csharp"

All your configuration is set and you're ready to deploy! The following commands will publish the site to the `pub` folder, zip it up into `site.zip`, and deploy the zip to App Service.

> [!NOTE]
> You'll need to `cd` back to the KeyVaultDemoApp directory if you're not still there.

```azurecli
dotnet publish -o pub
zip -j site.zip pub/*

az webapp deployment source config-zip \
    --src site.zip \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name>
```

::: zone-end

::: zone pivot="javascript"

All your configuration is set and you're ready to deploy! The following commands will zip up your app into `site.zip`, and deploy it to App Service. We exclude `node_modules` from the zip because App Service will restore them automatically when you deploy.

> [!NOTE]
> You'll need to `cd` back to the KeyVaultDemoApp directory if you're not still there.

```azurecli
zip site.zip * -x node_modules/

az webapp deployment source config-zip \
    --src site.zip \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name>
```

::: zone-end

The deployment may take a minute or two to complete. After you get a result that indicates the site has deployed, open `https://<your-unique-app-name>.azurewebsites.net/api/SecretTest` in a browser. The app will take a moment to start up for the first time on the server, but after it does, you should see the secret value, **reindeer_flotilla**.

Your app is finished and deployed!