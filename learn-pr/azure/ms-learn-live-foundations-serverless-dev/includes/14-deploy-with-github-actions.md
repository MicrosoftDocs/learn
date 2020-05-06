## 💻 Exercise - Configure continuous deployment using GitHub actions

Your code is already hosted on GitHub. In order to get a deployed version of the API functions project to Azure, you can use GitHub actions.

## Objective

- Configure continuous deployment using GitHub actions to update your API on Azure

## Instructions

### If you're using your own Azure subscription

- Open [Azure portal](https://portal.azure.com) in your browser and select your subscription
- Open the Cloud Shell (the button is located at the top, next to the notifications bell and looks like this: >_) and select to use a "Bash" shell.

### If you're using the Learn Live Sandbox

Activate the Azure Sandbox to execute the lab instructions in a free subscription and open [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)

- Make sure to push your locally working API function project into your GitHub account.
- Open the Azure portal and create a new functions project using the steps discussed in the earlier exercise "[Create your first Function](1-execute-first-function-in-portal.md)"
- Wait for the resource to be created and navigate to it
- Find the button "Get publish profile" in the overview screen of the function app; it's located in the top menu.
- Click it to download the publishing profile. GitHub needs this to know where to deploy the code to.
- Open the GitHub actions workflow samples page at [https://github.com/marketplace/actions/azure-functions-action](https://github.com/marketplace/actions/azure-functions-action) in a new browser tab.
- Find the workflow template for "Node" and "Windows" and open it.
- View its "raw" data and copy the workflow template's YML code into the clipboard.
- In GitHub, navigate to your forked repository and select "Actions" from the top menu.
- Locate the link named "Skip this and set up a workflow yourself" and click it.
- Change the name of the workflow from the default "main.yml" to "deploytoazure.yml"
- Paste the workflow YML into the editor.
- In the editor, find the environment variable names "AZURE_FUNCTIONAPP_NAME" and change it to the application name you used when creating the Azure functions resource. Note: make sure to enclose the name in 'single quotes'.
- Adjust the variable named "AZURE_FUNCTIONAPP_PACKAGE_PATH" if the functions project is not in the root folder.
- Change the setting "NODE_VERSION" to '12.x'.
- Click the green button labeled "Start commit" to add the deployment file to your repository.
- In the top menu, switch to "Settings"
- In the left menu, select "Secrets"
- Click "Add new secret"
- For the name of the secret enter "AZURE_FUNCTIONAPP_PUBLISH_PROFILE".
- Paste the contents of the downloaded publishing profile into the "Value" text box and click "Add secret"
- Update your local repository, then modify a file, commit and push the changes to GitHub.
- Inspect the "Actions" tab: the deployment was triggered by the "push" operation.
- Wait for the run to complete and switch back to Azure portal where you should find the deployed functions.

> [!NOTE]
> If you try to execute the deployed functions, they will fail because the connection to the CosmosDB instance is missing.
> You can fix this by adding an application setting to the function app. Follow the steps below.

- In the function app's side menu, select "Configuration"
- Add a new application setting named "CONNECTION_STRING"
- The value of the setting is the connection string of the CosmosDB instance you're using. You can find this in the portal or in your local `local.settings.json` file.
- Don't forget to save!
