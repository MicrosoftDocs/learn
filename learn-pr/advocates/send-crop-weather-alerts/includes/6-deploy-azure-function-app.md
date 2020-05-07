In this unit we will create and deploy an existing application to Azure Functions.

## Create a Storage account

Azure Functions requires a Storage Account for storing the application code and other information. Additionally our app requires a Table called `alerts` within the Storage Account to track the locations, phone numbers and temperature ranges to create alerts for.

All Azure Storage accounts have a name, and this name needs to be globally unique amongst all storage account. Storage accounts can be accessed over the web, and the name forms part of the URL. To make a unique name, include things like the date or your name. This name needs to be between 3 and 24 characters long and only contain lower-case letters and numbers.

1. Run the following commands in the Sandbox to create a Storage Account and the required table.

    ```azurecli
    export STORAGE_ACCOUNT_NAME=<YOUR-STORAGE-ACCOUNT-NAME>

    az storage account create \
      --name $STORAGE_ACCOUNT_NAME \
      --location westus \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --sku Standard_LRS

    az storage table create \
      --name alerts \
      --account-name $STORAGE_ACCOUNT_NAME
    ```

    Replace `<YOUR-STORAGE-ACCOUNT-NAME>` with the name you want to use for your storage account, for example `cropweatheralert20100519`.

## Create a function app

Azure Functions need a globally unique name. To make a unique name, include things like the date or your name. This can be the same as your storage account, as long as that name is unique across all Azure Functions apps.

1. Run this command to create a new Azure Functions app:

    ```azurecli
    export FUNCTIONS_APP_NAME=<YOUR-FUNCTION-APP-NAME>

    az functionapp create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --os-type Linux \
      --consumption-plan-location westus \
      --runtime python \
      --name $FUNCTIONS_APP_NAME \
      --storage-account $STORAGE_ACCOUNT_NAME \
      --functions-version 2
    ```

    Replace `<YOUR-FUNCTION-ACCOUNT-NAME>` with the name you want to use for your functions app, for example `cropweatheralert20100519`.

## Create Environment Variables

Our application once deployed will require the Azure Maps key, Twilio Phone number, Twilio Account SID, and Twilio Auth Token. We can provide this information to the application via environment variables known as App Settings.

1. Run the following command to create the App Settings as follows:

    ```azurecli
    az functionapp config appsettings set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTIONS_APP_NAME \
      --settings "AZURE_MAPS_SUBSCRIPTION_KEY=<YOUR-MAPS-KEY-HERE>" "TWILIO_PHONE_NUMBER=<YOUR-TWILIO-NUMBER-HERE, for example +12324345678>" "TwilioAccountSID=<YOUR-TWILIO-ACCOUNTSID>" "TwilioAuthToken=<YOUR-TWILIO-AUTHTOKEN>"
    ```

    Replace `<YOUR-MAPS-KEY-HERE>` with the Azure Maps primary key you noted down earlier in this unit.

    Replace `<YOUR-TWILIO-NUMBER-HERE>` with your Twilio trial phone number that you noted down in the previous unit.

    Replace `<YOUR-TWILIO-ACCOUNTSID>` with your Twilio Account SID that you noted down in the previous unit.

    Replace `<YOUR-TWILIO-AUTHTOKEN>` with your Twilio Auth Token that you noted down in the previous unit.

1. Verify the App Settings were created and have the correct value with the following command:

    ```azurecli
    az functionapp config appsettings list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTIONS_APP_NAME \
      --output table
    ```

## Download the application code for our app

The Function application's source code resides in a repository on GitHub.

1. Run the following command to clone the code down to our working environment.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-send-crop-weather-alerts.git
    ```

## Deploy the application to Azure Functions

We are now ready to deploy our application to Azure Functions.

1. Run the following command to publish the code

    ```azurecli
    cd mslearn-send-crop-weather-alerts
    func azure functionapp publish $FUNCTIONS_APP_NAME --python
    ```

## Obtain functions endpoints

One of our functions is configured to respond to HTTP requests, which will be made by Twilio.

1. Run the following command to obtain and note down the full endpoint URL.

    ```azurecli
    func azure functionapp list-functions $FUNCTIONS_APP_NAME --show-keys
    ```

1. Find the `SetupAlert` URL in the output

    ```output
    Functions in cropweatheralertjabenn:
        CheckForecast - [timerTrigger]

        ProcessAndNotify - [queueTrigger]

        SetupAlert - [httpTrigger]
            Invoke url: https://cropweatheralertjabenn.azurewebsites.net/api/setupalert?code=Secr3tC0de
    ```

    The full URL can be found after `Invoke url:`. Note this down.

In this unit, you created an Azure Function app, deployed an existing app to Azure Functions, and configured all required environment variables known as App Settings for the app. Finally, you obtained the endpoint URL for one of the functions to be called by Twilio.
