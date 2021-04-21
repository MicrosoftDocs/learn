In this exercise, you're going to see Form Recognizer in action by deploying a Form Recognizer webapp, **simply by copying and pasting the Azure CLI command below**.

To do this, you'll need to activate the Sandbox above – just select the ‘Activate sandbox’ button and sign in, no payment or Azure subscription required.

## Deploy Form Recognizer

The command below will create an instance of Form Recognizer for you, along with deploying a webapp that connects to your instance of Form Recognizer. To create the Form Recognizer resource and deploy the webapp, follow the following three steps:

1. Once the Cloud Shell is loaded and shows a prompt, copy the command below and paste it into the Cloud Shell by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

    Run the following command in the Cloud Shell:

    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-to-form-recognizer/main/scripts/deploy-in-sandbox.sh | bash
    ```

2. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it won't impact the running script.

3. Select the URL displayed at the bottom of the shell. This will open the web app and let you use Form Recognizer.

After you run the code, you can play around with Form Recognizer at your own pace.

## Optional: Browse or clone the code in GitHub

The code deployed is open source (though not production ready). You can view the code, clone or fork the [GitHub repository](https://github.com/MicrosoftDocs/mslearn-intro-to-form-recognizer).

## Optional: Review the resource in the Azure portal

If you’d like to look at the resources created in the Cloud Shell, you can browse them in the [Azure portal](https://portal.azure.com/?azure-portal=true#blade/HubsExtension/BrowseResourceGroups).
