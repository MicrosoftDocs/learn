In this unit we will create and deploy our existing application to Azure Functions.

## Creating a Storage account

Azure Functions requires a Storage Account for storing the application code and other information. Additionally our app requires a Table called `alerts` within the Storage Account. Run the following commands in the Sandbox to create a Storage Account and the required table.

```Azure CLI
STORAGE_ACCOUNT_NAME = "learnmodulestorage"
az storage account create --name $STORAGE_ACCOUNT_NAME --location westus --resource-group <rgn>[sandbox resource group name]</rgn> --sku Standard_LRS
az storage table create --name alerts --account-name $STORAGE_ACCOUNT_NAME
```

## Creating a function app

1. Run this command to create a new Azure Maps account

    ```azurecli
    FUNCTIONS_APP_NAME = "cropweatheralert"
    az functionapp create --resource-group <rgn>[sandbox resource group name]</rgn> --os-type Linux --consumption-plan-location westus --runtime python --name $FUNCTIONS_APP_NAME --storage-account $STORAGE_ACCOUNT_NAME
    ```

## Create Environment Variables

Our application once deployed will require the Azure Maps key, Twilio Phone number, Twilio Account SID, and Twilio Auth Token. We can provide this information to the application via environment variables known as App Settings.

Create the App Settings as follows:

    ```azurecli
    az functionapp config appsettings set -g <rgn>[sandbox resource group name]</rgn> -n $FUNCTIONS_APP_NAME --settings "AZURE_MAPS_SUBSCRIPTION_KEY=<YOUR-KEY-HERE>" "TWILIO_PHONE_NUMBER=<YOUR-TWILIO-NUMBER-HERE, for example +12324345678>" "TwilioAccountSID=<YOUR-TWILIO-ACCOUNTSID>" "TwilioAuthToken=<YOUR-TWILIO-AUTHTOKEN>"
    ```
Verify the App Settings were created and have the correct value with the following command:

    ```azurecli
    az functionapp config appsettings list -g <rgn>[sandbox resource group name]</rgn> -n $FUNCTIONS_APP_NAME
    ```

## Download the application code for our app

Our Function application's source code resides in a repository on GitHub. Run the following command to clone the code down to our working environment.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-send-crop-weather-alerts.git
    ```

## Deploy the application to Azure Functions

We are now ready to deploy our application to Azure Functions.

    ```azurecli
    cd mslearn-send-crop-weather-alerts
    func azure functionapp publish $FUNCTION_APP_NAME
    ```

## Obtain functions endpoints

One of our functions is configured to respond to HTTP requests as made by Twilio. Run the following command to obtain and note down the full endpoint URL.

    ```azurecli
    func azure functionapp list-functions $FUNCTIONS_APP_NAME --show-keys
    ```
The full URL can be found after **Invoke url:**

In this unit, you created an Azure Function app, deployed an existing app to Azure Functions, and configured all required environment variables known as App Settings for the app. Finally, you obtained the endpoint URL for one of the functions to be called by Twilio.
