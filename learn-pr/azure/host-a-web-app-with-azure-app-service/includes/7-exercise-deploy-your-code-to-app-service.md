In this unit, you'll deploy your web application to App Service.

::: zone pivot="csharp"

## Deploy with ZIP deploy

Let's deploy our .NET application with ZIP deploy.

First, use `dotnet publish` to build the final app files and `zip` to package them into a zip file.

```bash
cd ~/BestBikeApp
dotnet publish -o pub
cd pub
zip -r site.zip *
```

Finally, perform the deployment with `az webapp deployment source config-zip`. Replace `<your-app-name>` in the following command with the name of your Azure web app and run it.

```bash
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-app-name>
```

The deployment will take a couple minutes, during which time you'll see status output.

## Verify the deployment

Let's browse to our application to see it live. Navigate back to the open browser tab containing the placeholder page and refresh it. If the placeholder page appears again, your App Service instance hasn't fully restarted yet, so wait a moment and try again. When you refresh after your app has restarted, you'll see the splash page for a new ASP.NET Core web app.

You have successfully hosted your new ASP.NET Core application on App Service!

::: zone-end

::: zone pivot="node"

## Deploy with `az webapp up`

Let's deploy our Node.js application with `az webapp up`. This command will package up our application and send it to our App Service instance, where it will be built and deployed.

First, we need to gather some information about our web app resource. Run these commands to set shell variables that contain our app's name, resource group name, plan name, sku, and location. These use different `az` commands to request the information from Azure; `az webapp up` needs these values to target our existing web app.

```bash
APPNAME=$(az webapp list --query [0].name --output tsv)
APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
APPPLAN=$(az appservice plan list --query [0].name --output tsv)
APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
APPLOCATION=$(az appservice plan list --query [0].location --output tsv)
```

Now, run `az webapp up` with the appropriate values. Make sure you are in the `helloworld` directory before running this command.

```bash
az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"
```

The deployment will take a couple minutes, during which time you'll see status output.

## Verify the deployment

Let's browse to our application to see it live. The last line of text output from `az webapp up`, before the JSON output, has a link to your app. Click it to navigate there in a new browser tab. The page will take a moment to load, as App Service is initializing your app for the first time.

Once it loads, you'll see the greeting message from your app &mdash; you've deployed successfully!

::: zone-end

::: zone pivot="java"

## Configure deployment credentials

Some App Service deployment techniques, including the one we'll use here, require a username and password that are separate from your Azure login. Every web app comes preconfigured with its own username and a password that can be reset to a new random value, but can't be changed to something you choose.

Instead of finding those credentials for each one of your apps and storing them somewhere, you can use an App Service feature called User Deployment Credentials to create your own username and password. The values you choose will work for deployments on *all* App Service web apps that you have permissions to, including new web apps that you create in the future. The username and password you select are tied to your Azure login and intended only for your use, so don't share them with others. You can change both the username and password at any time.

The easiest way to create deployment credentials is from the Azure CLI. Run the following command in the Cloud Shell to set them up, substituting `<username>` and `<password>` with values you choose.

```azurecli
az webapp deployment user set --user-name <username> --password <password>
```

## Deploy the application package with WAR deploy

Let's deploy our Java application with WAR deploy. WAR deploy is part of the Kudu REST API: an administrative service interface, available on all App Service web apps, that can be accessed over HTTP. The simplest way to use WAR deploy is with the `curl` HTTP utility from the command line.

Run the following commands to deploy your app with WAR deploy. Replace `<username>` and `<password>` with the Deployment User username and password you created above, and replace `<your-app-name>` with the name of your web app.

```console
cd ~/helloworld/target
curl -v -X POST -u [username]:[password] https://<your-app-name>.scm.azurewebsites.net/api/wardeploy --data-binary @helloworld.war
```

When the command finishes running, open a new browser tab and navigate to `https://<your-app-name>.azurewebsites.net`. You'll see the greeting message from your app &mdash; you've deployed successfully!

::: zone-end

::: zone pivot="python"

## Deploy with `az webapp up`

Let's deploy our Python application with `az webapp up`. This command will package up our application and send it to our App Service instance, where it will be built and deployed.

First, we need to gather some information about our web app resource. Run these commands to set shell variables that contain our app's name, resource group name, plan name, sku, and location. These use different `az` commands to request the information from Azure; `az webapp up` needs these values to target our existing web app.

```bash
APPNAME=$(az webapp list --query [0].name --output tsv)
APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
APPPLAN=$(az appservice plan list --query [0].name --output tsv)
APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
APPLOCATION=$(az appservice plan list --query [0].location --output tsv)
```

Now, run `az webapp up` with the appropriate values. Make sure you are in the `BestBikeApp` directory before running this command.

```bash
cd ~/BestBikeApp
az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"
```

The deployment will take a couple minutes, during which time you'll see status output.

## Verify the deployment

Let's browse to our application to see it live. The last line of text output from `az webapp up`, before the JSON output, has a link to your app. Click it to navigate there in a new browser tab. The page will take a moment to load, as App Service is initializing your app for the first time.

Once it loads, you'll see the greeting message from your app &mdash; you've deployed successfully!

::: zone-end
