Now it's time to run our app in Azure. We need to create an App Service app, set it up with MSI and our vault configuration, and deploy our code.

# Exercise

## Create the App Service plan and app

Creating an App Service app is a two-step process: first create the *plan*, then the *app*.

The *plan* name only needs to be unique within your subscription, so you can use the same name we've used: **keyvault-exercise-plan**. The app name needs to be globally unique, though, so you'll need to pick your own.

In Cloud Shell, run the following:

```azurecli
az appservice plan create --name keyvault-exercise-plan --resource-group keyvault-exercise-group
az webapp create --name <your-unique-app-name> --plan keyvault-exercise-plan --resource-group keyvault-exercise-group
```

## Add configuration to the app

For deploying to Azure, we'll follow the App Service best practice of putting configuration in Application Settings instead of a configuration file.

```azurecli
az webapp config appsettings set --name <your-unique-app-name> --resource-group keyvault-exercise-group --settings VaultName=<your-unique-vault-name>
```

## Enable MSI

Enabling MSI on an app is a one-liner:

```azurecli
az webapp identity assign --name <your-unique-app-name> --resource-group keyvault-exercise-group
```

From the JSON output that results, copy the **principalId** value. PrincipalId is the unique ID of the app's new identity in Azure Active Directory, and we're going to use it in the next step.

## Grant access to the vault

Now we need to give our app identity permissions to get and list secrets from our production-environment vault. Use the **principalId** value you copied from the previous step as the value for **object-id** in the command below.

```azurecli
az keyvault set-policy --name <your-unique-vault-name> --object-id <your-msi-principleid> --secret-permissions get list
```

## Deploy the app and try it out

All our configuration is set and we're ready to deploy! The below commands will publish the site to the `pub` folder, zip it up into `site.zip`, and deploy the zip to App Service.

> [!NOTE]
> You'll need to `cd` back to the KeyVaultDemoApp directory if you haven't already.

```console
dotnet publish -o pub
zip -j site.zip pub/*
az webapp deployment source config-zip --src site.zip --name <your-unique-app-name> --resource-group keyvault-exercise-group
```

Once you get a result that indicates the site has deployed, open `https://<your-unique-app-name>.azurewebsites.net/api/SecretTest` in a browser. You should see the secret value, **reindeer_flotilla**.

Our app is finished and deployed!