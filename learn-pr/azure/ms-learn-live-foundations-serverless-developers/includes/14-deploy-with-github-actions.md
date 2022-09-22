Your code is on GitHub. To get a deployed version of the API functions project to Azure, you can use GitHub actions.

## Objective

- Configure continuous deployment using GitHub actions to update your API on Azure.

## Instructions

### If you're using your Azure subscription

1. Open [Azure portal](https://portal.azure.com) in your browser and select your subscription.

1. Open Cloud Shell (the button is located at the top, next to the notifications bell, and looks like this: >_) and select to use a *Bash* shell.

### If you're using the Learn Live Sandbox

1. Activate the Azure Sandbox to execute the lab instructions in a free subscription, and open [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Make sure to push your locally-working API function project into your GitHub account.

1. Open the Azure portal, and create a new functions project performing the steps described in the earlier exercise *Create your first function*.

1. Wait for the resource to be created, and go to it.

1. In the top menu bar, select **Get publish profile** in the overview screen of the function app to download the publishing profile. GitHub needs this to know where to deploy the code.

1. Open the GitHub actions workflow samples page at [https://github.com/marketplace/actions/azure-functions-action](https://github.com/marketplace/actions/azure-functions-action) in a new browser tab.

1. Open the workflow template for *Node* and *Windows*.

1. View its "raw" data, and copy the workflow template's YML code into the clipboard.

1. In GitHub, navigate to your forked repository, and select **Actions** from the top menu bar.

1. Select the **Skip this and set up a workflow yourself** link.

1. Change the name of the workflow from the default *main.yml* to *deploytoazure.yml*.

1. Paste the workflow YML into the editor.

1. In the editor, find the environment variable names *AZURE_FUNCTIONAPP_NAME*, and change it to the application name you used when creating the Azure functions resource. Note: Make sure to enclose the name in 'single quotes'.

1. Adjust the variable named *AZURE_FUNCTIONAPP_PACKAGE_PATH* if the functions project is not in the root folder.

1. Change the setting "NODE_VERSION" to '12.x'.

1. Select the green button labeled **Start commit** to add the deployment file to your repository.

1. In the top menu bar, switch to **Settings**.

1. In the left menu pane, select **Secrets**.

1. Select **Add new secret**.

1. For the name of the secret, enter *AZURE_FUNCTIONAPP_PUBLISH_PROFILE*.

1. Paste the contents of the downloaded publishing profile into the **Value** text box, and select **Add secret**.

1. Update your local repository, then modify a file, commit, and push the changes to GitHub.

1. Inspect the **Actions** tab. The deployment was triggered by the *push* operation.

1. Wait for the run to complete, and switch back to Azure portal where you should find the deployed functions.

    If you try to execute the deployed functions, they will fail because the connection to the Cosmos DB instance is missing. You can fix this by adding an application setting to the function app. Perform the following steps:

1. In the function app's left menu pane, select **Configuration**.

1. Add a new application setting named *CONNECTION_STRING*.

    The value of the setting is the connection string of the Cosmos DB instance you're using. You can find this in the portal or in your local `local.settings.json` file.

1. Don't forget to select **Save**!
