After you've completed development of your bot, you can deploy it to Azure. The specific details of how the bot is hosted varies, depending on the programming language and underlying runtime you have used; but the basic steps for deployment are the same.

## Create the Azure resources required to support your bot

Your will need to create an Azure application registration to give your bot an identity it can use to access resources, and a bot application service to host the bot.

### Register an Azure app

You can create the application registration by using the `az ad app create` Azure command-line interface (CLI) command, specifying a display name and password for your app identity. This command registers the app and returns its registration information, including a unique application ID that you will need in the following step.

### Create a bot application service

Your bot requires a **Bot Channels Registration** resource, along with associated application service and application service plan. To create these resources, you can use the Azure resource deployment templates provided with the Bot Framework SDK template you used to create your bot. Just run the `az deployment group create` command, referencing the deployment template and specifying your bot application registration's ID (from the `az ad app create` command output) and the password you specified.

## Prepare your bot for deployment

The specific steps you need to perform to prepare your bot depend on the programming language used to create it. For C# and JavaScript bots, you can use the `az bot prepare-deploy` command to ensure your bot is properly configured with the appropriate package dependencies and build files. For Python bots, you must include a **requirements.txt** file listing any package dependencies that must be installed in the deployment environment.

## Deploy your bot as a web app

The final step is to package your bot application files in a zip archive, and use the `az webapp deployment source config-zip` command to deploy the bot code to the Azure resources you created previously.

After deployment has completed, you can test and configure your bot in the Azure portal.

## More Information

For more information about deploying a bot, see the [Bot Framework SDK documentation](/azure/bot-service/bot-builder-deploy-az-cli).
