Now it's time to run your app in Azure. You need to create an Azure App Service app, set it up with a managed identity and your vault configuration, and deploy your code.

## Create the App Service plan and app

Creating an App Service app is a two-step process: First create the *plan*, then the *app*.

The *plan* name only needs to be unique within your subscription, so you can use the same name: `keyvault-exercise-plan`. The app name needs to be globally unique, though, so pick your own.

1. In Azure Cloud Shell, run the following command to create an App Service plan.

    ```azurecli
    az appservice plan create \
        --name keyvault-exercise-plan \
        --sku FREE \
        --location centralus \
        --resource-group "<rgn>[sandbox resource group name]</rgn>"
    ```

1. Next, to create the Web App that uses the App Service plan you created, run the following command. Make sure to replace `<your-unique-app-name>` with your app's name in the `--name` parameter.

    ::: zone pivot="csharp"

    ```azurecli
    az webapp create \
        --plan keyvault-exercise-plan \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name <your-unique-app-name>
    ```

    ::: zone-end

    ::: zone pivot="javascript"

    ```azurecli
    az webapp create \
        --plan keyvault-exercise-plan \
        --runtime "node|16LTS" \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name <your-unique-app-name>
    ```

    ::: zone-end

## Add configuration to the app

::: zone pivot="csharp"

To deploy to Azure, follow the App Service best practice of putting the `VaultName` configuration in an app setting instead of a configuration file. To create the app setting, run this command. Make sure to replace both `<your-unique-app-name>` with your app's name in the `--name` parameter, and `<your-unique-vault-name>` with your vault's name in the `--settings` parameter.

```azurecli
az webapp config appsettings set \
    --resource-group "<rgn>[sandbox resource group name]</rgn>" \
    --name <your-unique-app-name> \
    --settings 'VaultName=<your-unique-vault-name>'
```

::: zone-end

::: zone pivot="javascript"

To deploy to Azure, follow the App Service best practice of putting the `VaultName` configuration in an app setting instead of a configuration file. You also set the `SCM_DO_BUILD_DURING_DEPLOYMENT` setting to `true` so that App Service restores your app's packages on the server and creates the necessary configuration to run the app. To create the app settings, run this command. Make sure to replace both `<your-unique-app-name>` with your app's name in the `--name` parameter, and `<your-unique-vault-name>` with your vault's name in the `--settings` parameter.

```azurecli
az webapp config appsettings set \
    --resource-group "<rgn>[sandbox resource group name]</rgn>" \
    --name <your-unique-app-name> \
    --settings 'VaultName=<your-unique-vault-name>' 'SCM_DO_BUILD_DURING_DEPLOYMENT=true'
```

::: zone-end

## Enable managed identity

Enabling managed identity on an app is a one-liner. To enable it on your app, run the following command. Make sure to replace `<your-unique-app-name>` with your app's name in the `--name` parameter.

```azurecli
az webapp identity assign \
    --resource-group "<rgn>[sandbox resource group name]</rgn>" \
    --name <your-unique-app-name>
```

From the resulting JSON output, copy the `principalId` value. `PrincipalId` is the unique ID of the app's new identity in Microsoft Entra ID, and you're going to use it in the next step.

## Grant access to the vault

The last step before deploying is to assign Key Vault permissions to your app's managed identity.  Make sure to replace both `<your-unique-vault-name>` with your vault's name in the `--name` parameter, and enter the `principalId` value you copied from the previous step as the value for `object-id` in the following command. To establish `Get` and `List` access, run this command.

```azurecli
az keyvault set-policy \
    --secret-permissions get list \
    --name <your-unique-vault-name> \
    --object-id <your-managed-identity-principleid>
```

## Deploy the app and try it out

::: zone pivot="csharp"

1. All your configuration is set, and you're ready to deploy! The following commands publish the site to the *pub* folder, zip it up into *site.zip*, and deploy the zip to App Service. Make sure to replace `<your-unique-app-name>` with your app's name in the `--name` parameter.

    > [!NOTE]
    > You'll need to `cd` back to the KeyVaultDemoApp directory if you're not still there.

    ```azurecli
    dotnet publish -o pub
    zip -j site.zip pub/*

    az webapp deployment source config-zip \
        --src site.zip \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name <your-unique-app-name>
    ```

::: zone-end

::: zone pivot="javascript"

1. All your configuration is set and you're ready to deploy! The following commands will zip up your app into *site.zip*, and deploy it to App Service. We exclude `node_modules` from the zip because App Service restores them automatically when you deploy.  Make sure to replace `<your-unique-app-name>` with your app's name in the `--name` parameter.

    > [!NOTE]
    > You'll need to `cd` back to the KeyVaultDemoApp directory if you're not still there.

    ```azurecli
    zip site.zip * -x node_modules/

    az webapp deployment source config-zip \
        --src site.zip \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name <your-unique-app-name>
    ```

::: zone-end

2. The deployment might take a minute or two to complete. After you get a result that indicates that the site deployed, open `https://<your-unique-app-name>.azurewebsites.net/api/SecretTest` in a browser. The app takes a moment to start up for the first time on the server, but after it does, you should see the secret value, *reindeer_flotilla*.

Your app is finished and deployed!
