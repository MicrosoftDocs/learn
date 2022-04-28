In this exercise, you'll create your App Service and Application Insights resources.

## Fork the GitHub sample repository

1. Open the [GitHub sample](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server) `https://github.com/Azure-Samples/msdocs-javascript-nodejs-server` repository in a new browser tab or window.
1. Select the **Fork** button to create your own fork of the sample repository.

## Clone your fork to your local computer

1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Git: Clone** and select it.
1. Enter your fork's URL of the sample repository. It should look something like this example:

    |URL|
    |--|
    |https://github.com/YOUR-GITHUB-ALIAS/msdocs-javascript-nodejs-server|

1. Select a local folder on your computer.
1. When asked if you want to open the cloned repository, select **Open**.
1. Visual Studio Code reopens with your local fork of the sample repository.
1. In the Explorer, select the **3-Add-cosmosdb-mongodb** folder and select **Open in Integrated Terminal**.
1. Install the npm packages with the following command. 

    ```bash
    npm install
    ```

1. Close Visual Studio Code then reopen to the **3-Add-cosmosdb-mongodb** folder. Keep Visual Studio open at this level. 

> [!Note]
> All files used in this module is in the **3-Add-cosmosdb-mongodb** folder of the sample repo. 

## Sign in to the Learn sandbox

Select the **Sign in to activate sandbox** button to sign in. This step might include reviewing permissions. When you see **Sandbox activated!** with a time remaining on this page, this step is complete.

Make sure you use the same account to sign in to the sandbox and Azure from Visual Studio Code.

## Find the subscription in Visual Studio Code

Find the free sandbox subscription in Visual Studio Code.

1. Open Visual Studio Code.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign Out**. When you sign in, the Learn sandbox tenant is available.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
1. When the listing of Azure clouds appears, select **Azure Cloud**.
1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to the sandbox subscription.

    |Subscription name|Value|
    |--|--|
    |**Subscription name**|`Concierge Subscription`|
1. Enable the sandbox subscription **Concierge Subscription**. Clear any other subscription checkboxes so that you can focus while you complete this module.

## Install Azure extensions

In Visual Studio Code, install the following extensions:

* [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice)
* [Azure Databases](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb)
* [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - used to provide your local computer with a database in a container

## Create App Service and other web resources

Create your web app resources. The database resource creation is handled in a later unit. 

1. Copy this [setup.sh](https://raw.githubusercontent.com/Azure-Samples/msdocs-javascript-nodejs-server/main/3-Add-cosmosdb-mongodb/setup-in-sandbox.sh) script from the GitHub sample repository into your local computer's clipboard. 
1. In the Learn sandbox terminal, open a new file with the nano editor:

    ```bash
    nano
    ```

1. Paste the script from the clipboard with your local computer operating system's paste command.
1. Use the nano command to save the file: <kbd>ctrl</kbd> + <kbd>v</kbd>.
1. When asked if you want to save the file, select `yes` and enter the script name, `setup.sh`.
1. Run the script with the following command:

    ```bash
    bash setup.sh
    ```

1. Optionally, list the resources you just created by running the following Azure CLI command in the Learn sandbox terminal. 

    ```azurecli
    az resource list --query [].type --output tsv | uniq
    ```     

## View the resources in Visual Studio Code

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **App Service** section, right-click the sandbox subscription name. 
1. View the new App Service created by the script.

## Check your work

* In Visual Studio Code, you're signed into Azure.
* In the Azure pane, you see your App Service resource.