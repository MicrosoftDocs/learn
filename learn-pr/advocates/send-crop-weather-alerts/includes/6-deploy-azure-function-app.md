In this unit, you'll create and deploy an existing application to the function app.

## Create a storage account

The function app requires a storage account for storing the application code and other information. The app also requires a table called *alerts* inside the storage account to track the locations, phone numbers, and temperature ranges to create alerts for.

An Azure storage account name must be globally unique among all storage account names in Azure. An Azure storage account can be accessed over the web. The storage account name forms part of the URL. To make a unique name, include information like the date or your name. This name must contain between 3 and 24 characters and can contain only lowercase letters and numbers.

1. Create an environment variable for the name of the storage account. The variable will be used in other command in this module.

    To create the variable, In the following command, replace *\<YOUR-STORAGE-ACCOUNT-NAME\>* with the name you want to use for your storage account (for example, *cropweatheralert20200519*).

    ```azurecli
    export STORAGE_ACCOUNT_NAME=<YOUR-STORAGE-ACCOUNT-NAME>
    ```

   > [!NOTE]
   > When you run this command, you can disregard warning messages about your credentials. The system will automatically query your storage account for the account key, which is sufficient for our purposes.

1. In the sandbox, create a storage account and the required table by running the following commands:

    ```azurecli
    az storage account create \
      --name $STORAGE_ACCOUNT_NAME \
      --location westus \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --sku Standard_LRS

    az storage table create \
      --name alerts \
      --account-name $STORAGE_ACCOUNT_NAME
    ```

## Create a function app

The name of the function app that you create in Azure Functions must be unique among all function app names in Azure. To make a unique name, include information like the date or your name. This name can be the same as your storage account name if it's unique.

1. To create an environment variable for the name of the function app, run the following command. The variable will be used by other commands later in this unit.

    Replace *\<YOUR-FUNCTION-APP-NAME\>* with the name you want to use for your function app (for example, *cropweatheralert20200519*).

    ```azurecli
    export FUNCTION_APP_NAME=<YOUR-FUNCTION-APP-NAME>
    ```

1. To create a new function app, run this command:

    ```azurecli
    az functionapp create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --os-type Linux \
      --consumption-plan-location westus \
      --runtime python \
      --name $FUNCTION_APP_NAME \
      --storage-account $STORAGE_ACCOUNT_NAME \
      --functions-version 2
    ```
    > [!NOTE]
    > Although your function app is now created, the app isn’t active until you publish content to the app from the Azure portal or by using the Functions Core Tools. You’ll learn how to publish content to your app in a later step.

## Create environment variables

After your application is deployed, it requires the Azure Maps key, the Twilio phone number, the Twilio account SID, and the Twilio auth token. This information is provided to the application via environment variables that are known as *app settings*.

1. To create the app settings, run this command:

    ```azurecli
    az functionapp config appsettings set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTION_APP_NAME \
      --settings "AZURE_MAPS_SUBSCRIPTION_KEY=<YOUR-MAPS-KEY-HERE>" "TWILIO_PHONE_NUMBER=<YOUR-TWILIO-NUMBER-HERE, for example +12324345678>" "TwilioAccountSID=<YOUR-TWILIO-ACCOUNTSID>" "TwilioAuthToken=<YOUR-TWILIO-AUTHTOKEN>"
    ```

    Replace *\<YOUR-MAPS-KEY-HERE\>* with the Azure Maps primary key that you copied earlier in this unit.

    Replace *\<YOUR-TWILIO-NUMBER-HERE\>* with your Twilio trial phone number, which you copied in the preceding unit.

    Replace *\<YOUR-TWILIO-ACCOUNTSID\>* with your Twilio account SID, which you copied in the preceding unit.

    Replace *\<YOUR-TWILIO-AUTHTOKEN\>* with your Twilio auth token, which you copied in the preceding unit.

1. To verify that the app settings were created and that they have the correct value, run this command:

    ```azurecli
    az functionapp config appsettings list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTION_APP_NAME \
      --output table
    ```

## Download the application code for the function app

The function app's source code lives in a repository on GitHub.

1. To clone the code in your working environment, run this command:  

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-send-crop-weather-alerts.git
    ```

    This code contains a timer trigger that runs at 12-hour intervals. The interval is perfect for a final app, but for testing purposes, 12 hours is too long for testing the application in the module sandbox.

    To view results faster, change this trigger to run every 10 minutes.

1. Run these commands to use the nano editor to edit the file:

    ```azurecli
    cd mslearn-send-crop-weather-alerts
    nano CheckForecast/function.json
    ```

1. Using the cursor keys, go to line 8. Change the text from:

    ```json
    "schedule": "12:00:00"
    ```

    to

    ```json
    "schedule": "0 */10 * * * *"
    ```

    This change schedules the trigger to run every 10 minutes.

1. To save the file, select Ctrl+O, and then select Enter to overwrite the existing file.

1. To close the nano editor, select Ctrl+X.

## Deploy the application to the function app

Now you're ready to deploy your application to the function app.

1. To publish the code, run this command:

    ```azurecli
    func azure functionapp publish $FUNCTION_APP_NAME --python
    ```

## Get the HTTP trigger endpoint

One of the functions in the function app is configured to respond to HTTP requests. Twilio will make HTTP requests in the application.

1. To get the full endpoint URL, run this command:

    ```azurecli
    func azure functionapp list-functions $FUNCTION_APP_NAME --show-keys
    ```

1. In the output, find the `SetupAlert` URL:

    ```output
    Functions in cropweatheralertjabenn:
        CheckForecast - [timerTrigger]

        ProcessAndNotify - [queueTrigger]

        SetupAlert - [httpTrigger]
            Invoke url: https://cropweatheralertjabenn.azurewebsites.net/api/setupalert?code=Secr3tC0de
    ```

    The full URL is displayed after `Invoke url:`. Copy the URL to use later.

In this unit, you created a function app in Azure, deployed code to the function app, and configured all required environment variables (app settings) for the function app. Finally, you obtained the endpoint URL for one of the functions to be called by Twilio. Next, you'll connect the function app to Twilio.
