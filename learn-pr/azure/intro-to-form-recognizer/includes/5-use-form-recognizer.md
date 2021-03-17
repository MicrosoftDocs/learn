To use Form Recognizer in a free Azure environment, you'll need to activate the Sandbox above. No credit card or Azure subscription is required.

## Deploy Form Recognizer

To see Form Recognizer in action, we'll deploy a working web app. The script below will create an instance of Form Recognizer in Azure for you, along with deploying an Azure web app that connects to your instance of Form Recognizer.

The code deployed is open source (though not production ready). You can view the code, clone or fork the GitHub repository at [https://github.com/MicrosoftDocs/cognitive-services-form-recognizer-demo](https://github.com/MicrosoftDocs/cognitive-services-form-recognizer-demo)

Once the cloud shell is loaded and shows a prompt, copy the command below and paste it into the cloud shell by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

The command will take several minutes to run. When it is complete, it will provide you with a link to your web app.

1. Run the following code in the Cloud Shell

    ```azurecli
    curl https://raw.githubusercontent.com/MicrosoftDocs/cognitive-services-form-recognizer-demo
    ```

1. Wait several minutes for the command to run. You may finish reading this page and naviage to other pages within this module - it will not impact the running script.
1. Copy the URL displayed at the bottom of the shell output and paste it into a new browser window. This will open the web app and let you use Form Recognizer.
