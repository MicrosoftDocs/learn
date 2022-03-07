Our **CustomerFriend** bot greets users by name. Its welcome message clearly states its purpose. Now that we've added some basic functionality, let's deploy our bot to the cloud.

We'll use the Azure CLI to deploy our bot.

## Sign in to Azure

Start by signing in to the Azure portal.

1. Open a PowerShell window.
1. Sign in to the Azure portal by entering this command:

   ```azurecli
   az login
   ```

   A browser window should open and display a message that prompts you to sign in.

1. To view the list of subscriptions that are associated with your account, run this command:

   ```azurecli
   az account list
   ```

1. From the available subscriptions, decide which one you'd like to use for deploying the bot. Make that subscription the default one by running this command:

   ```azurecli
   az account set --subscription "<azure-subscription-id>"
   ```

## Create a bot resource

Next we'll create a bot resource in Azure. This resource is a specialized type of Azure web app that provides a way for users to interact with our bot.

1. Run this command to create the bot:

   ```azurecli
   az ad app create --display-name "<display-name>" --password "<password>" --available-to-other-tenants
   ```

   The command uses these options:

   - `display-name`: The name for the bot that appears in the Azure portal. The general resources list displays this name, as does the bot's resource group.
   - `password`: The bot's password, or client secret, which you create. Make it at least 16 characters long, and include the following characters:

     - At least one uppercase or lowercase alphabetical character
     - At least one numeric character
     - At least one special character

   - `available-to-other-tenants`: A flag that indicates that any Azure AD tenant can use the bot.

   For example, you might run the command with these arguments:

   ```azurecli
   az ad app create --display-name "CustomerFriendBot" --password "tw8PcygLmq3nWi?Xeqe_0" --available-to-other-tenants
   ```

   If the command successfully creates the bot, the CLI displays the bot's properties.

1. In the property list that the CLI displays, locate `appId`. Copy and save the `appId` value. Also make a note of the password that you created for the bot.

## Create an application service

Our bot resource will use functionality and tools that Azure App Service provides. In this step, we'll set up an instance of App Service. At the same time, we'll create a service plan and a resource group for our bot.

An Azure Resource Manager template (ARM template) will help us in this step. In an earlier unit, you downloaded code for a sample bot. That code includes a `DeploymentTemplates` folder, which contains ARM templates. We'll use one of those templates now, `template-with-new-rg.json`.

Run this command to create the app service:

```azurecli
az deployment sub create --template-file "<new-resource-group-template-path.json>" --location <bot-app-service-location> --parameters appType="MultiTenant" appId="<app-id-from-previous-step>" appSecret="<password-from-previous-step>" botId="<bot-resource-name>" botSku=F0 newAppServicePlanName="<new-service-plan-name>" newWebAppName="<bot-app-service-name>" groupName="<new-resource-group-name>" groupLocation="<resource-group-location>" newAppServicePlanLocation="<service-plan-location>" --name "<bot-app-service-deployment-name>"
```

The command uses these options:

- `template-file`: The path to the `template-with-new-rg.json` template that's in your sample bot's `DeploymentTemplates` folder. The path can be absolute, or it can be relative to the directory that you're running the Azure CLI commands in.
- `location`: The Azure location for the bot application service. Use `az account list-locations` to see which locations your subscription supports.
- `appType`: The type of the bot application service that you're creating. Use **MultiTenant**.
- `appId`: The `appId` value that you saved when you created the bot resource.
- `appSecret`: The password that you created for the bot resource.
- `botId`: The display name of your bot resource.
- `botSku`: The pricing tier for the app service plan that you're creating.
  - For the free plan, use **F0**.
  - For the standard plan, use **S1**.
- `newAppServicePlanName`: The name for the app service plan that you're creating.
- `newWebAppName`: The name for the bot application service that you're creating.
- `groupName`: The name for the resource group that you're creating for your bot resource, bot application service, and bot application service plan.
- `groupLocation`: The Azure location for the resource group that you're creating. Use `az account list-locations` to see which locations your subscription supports.
- `newAppServicePlanLocation`: The Azure location for the service plan that you're creating. Use `az account list-locations` to see which locations your subscription supports.
- `name`: The deployment name for the bot application service that you're creating.

For example, you might run the command with these arguments:

```azurecli
az deployment sub create --template-file "../../CustomerFriend/DeploymentTemplates/template-with-new-rg.json" --location eastus --parameters appType="MultiTenant" appId="<app-id-from-previous-step>" appSecret="tw8PcygLmq3nWi?Xeqe_0" botId="CustomerFriendBot" botSku=F0 newAppServicePlanName="CustomerFriendServicePlan" newWebAppName="CustomerFriendAppService" groupName="CustomerFriendResourceGroup" groupLocation="eastus" newAppServicePlanLocation="eastus" --name "CustomerFriendAppServiceDeploymentName"
```

This command might run for a few minutes. If the command successfully creates the app service, the CLI displays the service's properties.

## Prepare for deployment

Before we deploy the bot, we'll take a few more steps to prepare the code.

### Update the configuration file

Take these steps to add information about the bot's identity to its configuration file:

1. Open your bot's project in Visual Studio.

1. Open the `appsettings.json` file that's in your project.

1. In that file, add values to these settings:

   - `MicrosoftAppType`: Enter **MultiTenant**.
   - `MicrosoftAppId`: Enter the `appId` value that you saved when you created the bot resource.
   - `MicrosoftAppPassword`: Enter the password that you created for the bot resource.

   :::image type="content" source="../media/visual-studio-edit-app-settings.png" alt-text="Screenshot of the appsettings.json configuration file in Visual Studio. The settings that you edit are called out.":::

1. Save your changes.

1. In the Visual Studio top menu bar, select **Build** > **Clean Solution**.

   :::image type="content" source="../media/visual-studio-clean-solution.png" alt-text="Screenshot of Visual Studio. The Build menu is visible, with Clean Solution called out.":::

1. In the Visual Studio top menu bar, select **Build** > **Rebuild Solution**.

   :::image type="content" source="../media/visual-studio-rebuild-solution.png" alt-text="Screenshot of Visual Studio. The Build menu is visible, with Rebuild Solution called out.":::

### Generate a deployment file

Take these steps to generate a `.deployment` file:

1. In PowerShell, use the `cd` command to make your bot's project folder the current working directory. For C# bots, navigate to the folder that contains the `.csproj` file.

1. To create the deployment file, enter this command:

   ```azurecli
   az bot prepare-deploy --lang Csharp --code-dir "." --proj-file-path "<project-file>"
   ```

   Supply the `--proj-file-path` option with the name of your bot's project file. For instance, you might enter a command similar to this one:

   ```azurecli
   az bot prepare-deploy --lang Csharp --code-dir "." --proj-file-path "EchoBot.csproj"
   ```

### Zip the code

In PowerShell, use this command to compress the contents of your bot's project folder and subfolders into a single file:

```powershell
Compress-Archive -Path * -DestinationPath <zip-file>
```

Supply the `DestinationPath` option with the name you'd like to use for the zip file. For instance, you might enter a command similar to this one:

```powershell
Compress-Archive -Path * -DestinationPath CustomerFriendZip.zip
```

## Deploy the bot

Enter this command to deploy the bot code to the Azure bot resource that you created earlier:

```azurecli
az webapp deployment source config-zip --resource-group "<resource-group-name>" --name "<bot-app-service-name>" --src "<zip-file-path>"
```

The command uses these options:

- `resource-group`: The name of the resource group that you created earlier for the bot.
- `name`: The name of the application service that you created earlier for the bot to use.
- `src`: The path to the zipped file that you created in the last step.

For example, you might run the command with these arguments:

```azurecli
az webapp deployment source config-zip --resource-group "CustomerFriendResourceGroup" --name "CustomerFriendAppService" --src "./CustomerFriendZip.zip"
```

This command typically runs for a few minutes. While it's running, you might see a message about a deployment endpoint responding with status code `202`. This message means that the deployment process is still ongoing.

If the command successfully deploys the bot, the CLI displays information about the deployment process.

Your bot is now ready for online chat sessions. In the next unit, we'll try talking to the bot.
