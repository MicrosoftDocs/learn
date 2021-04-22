In this exercise, you're going to see Form Recognizer in action by deploying a Form Recognizer and a webapp that will use it. All this will happen **simply by copying and pasting the Azure CLI command below**.

To start, you'll need to activate the Sandbox above – just select the ‘Activate sandbox’ button and sign in, no payment or Azure subscription required. Though you're signed-in and have full admin access to the website and Azure resources, the resources in this exercise are created on Microsoft's subscription, and won't cost you anything.

## Choose your demo experience
You'll have the option to treat this as a demo, and just see what you can do with Form Recognizer. Or, since you fully control these resources, if you are interested in peeking at the technical details, you can choose to dive deeper. Browse the code in github, check out the resources in the Azure Portal, or even use Visual Studio remote debugging and step through.

For more guided hands-on learning on Form Recognizer we have more Learn modules for you to check out. After learning more you can always come back here to apply what you've learned in the free sandbox.

## Deploy Form Recognizer

To create the Form Recognizer resource and deploy the webapp, complete the following three steps:

1. Once the Cloud Shell is loaded and shows a prompt, copy the command below and paste it into the Cloud Shell by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

    Run the following command in the Cloud Shell:

    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-to-form-recognizer/main/scripts/deploy-in-sandbox.sh | bash
    ```

2. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it won't impact the running script.

3. Activate the link to the URL displayed at the bottom of the shell. The web app will open letting you use Form Recognizer. You can also use the following link, but remember, it won't work until the script finishes running: [fr-<rgn>[sandboxName]</rgn>.azurewebsites.net](https://fr-<rgn>[sandboxName]</rgn>.azurewebsites.net?azure-portal=true)

After you run the code, you can play around with Form Recognizer at your own pace.

## Optional: Browse or clone the code in GitHub

The code deployed is open source (though not production ready). You can view the code, clone, or fork the [GitHub repository](https://github.com/MicrosoftDocs/mslearn-intro-to-form-recognizer).

## Optional: Review the resource in the Azure portal

If you’d like to look at the resources created in the Cloud Shell, you can browse them in the [Azure portal](https://portal.azure.com/?azure-portal=true#blade/HubsExtension/BrowseResourceGroups).
