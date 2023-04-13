In this unit, you'll create and deploy a function app.

The function app you'll create requires a storage account for storing the application code and other information. First, create an Azure Storage account.

## Create an Azure Storage account

The function app needs a storage account and a table called *alerts* inside the storage account to track the locations, phone numbers, and temperature ranges to create alerts for.

When you choose a name for your Azure storage account, keep this guidance in mind:

- The storage account name must be globally unique among all storage account names in Azure.
- The storage account can be accessed over the web, and the storage account name forms part of the URL.
- To make a unique storage account name, include information like the date or your name.
- The name must be 3 to 24 characters long and can contain only lowercase letters and numbers.

To create a storage account in the sandbox:

1. First, create an environment variable for the storage account name you'll use. The variable will be used in other commands in this module.

    To create the variable, in the following command, replace \<your-storage-account-name\> with the name you want to use for your storage account (for example, *cropweatheralert20200519*).

    ```azurecli
    export STORAGE_ACCOUNT_NAME=<your-storage-account-name>
    ```

   > [!NOTE]
   > When you run this command, you can disregard warning messages about your credentials. The system will automatically query your storage account for the account key, which is sufficient for our purposes.

1. Then, run this command to create a storage account and a table to store alerts:

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

1. First, create an environment variable for the name of the function app by running the following command. The variable will be used in other commands later in this unit.

    Replace \<your-function-app-name\> with the name you want to use for your function app (for example, *cropweatheralert20200519*).

    ```azurecli
    export FUNCTION_APP_NAME=<your-function-app-name>
    ```

1. Then, run this command to create a new function app:

    ```azurecli
    az functionapp create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --os-type Linux \
      --consumption-plan-location westus \
      --runtime python \
      --name $FUNCTION_APP_NAME \
      --storage-account $STORAGE_ACCOUNT_NAME \
      --functions-version 4
    ```

    > [!NOTE]
    > Although your function app is now created, the app isn’t active until you publish content to the app from the Azure portal or by using the Functions Core Tools. You’ll learn how to publish content to your app in a later step.

## Configure the function app

We need to do a couple more steps to configure and deploy the function app: create environment variables and download code for the function app to use.

### Create environment variables

After your application is deployed, it requires the Azure Maps key, the Twilio phone number, the Twilio account SID, and the Twilio auth token. This information is provided to the application via environment variables that are known as *app settings*.

1. To create the app settings, run this command:

    ```azurecli
    az functionapp config appsettings set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTION_APP_NAME \
      --settings "AZURE_MAPS_SUBSCRIPTION_KEY=<your-azure-maps-key>" "TWILIO_PHONE_NUMBER=<your-twilio-phone-number, for example +12324345678>" "TwilioAccountSID=<your-twilio-account-sid>" "TwilioAuthToken=<your-twilio-auth-token>"
    ```

    Before you run the code, make the following replacements with values you copied earlier:

    - Replace \<your-azure-maps-key\> with the Azure Maps primary key.
    - Replace \<your-twilio-phone-number\> with your Twilio trial phone number.
    -  Replace \<your-twilio-account-sid\> with your Twilio account SID.
    -  Replace \<your-twilio-auth-token\> with your Twilio auth token.

1. To verify that the app settings were created and that they have the correct values, run this command:

    ```azurecli
    az functionapp config appsettings list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $FUNCTION_APP_NAME \
      --output table
    ```

### Download the function app code

We'll get the function app's source code from a repository on GitHub.

1. To clone the code in your working environment, run this command:  

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-send-crop-weather-alerts.git
    ```

    This code contains a timer trigger that runs at 12-hour intervals. The interval is perfect for a final app, but 12 hours is too long for testing the application in the module sandbox.

    To view results faster, change this trigger to run every 10 minutes.

1. Run these commands to edit the file in an editor called nano:

    ```azurecli
    cd mslearn-send-crop-weather-alerts
    nano CheckForecast/function.json
    ```

1. Using the cursor keys, go to line 8.

    Replace this text:

    ```json
    "schedule": "12:00:00"
    ```

    With this text:

    ```json
    "schedule": "0 */10 * * * *"
    ```

    This change schedules the trigger to run every 10 minutes.

1. To save the file, select Ctrl+O, and then select Enter to overwrite the existing file.

1. To close the nano editor, select Ctrl+X.

## Deploy the function app

Now you're ready to deploy the function app.

To publish the code, run this command:

```azurecli
func azure functionapp publish $FUNCTION_APP_NAME --python
```

In this unit, you created a storage account and a function app in Azure, downloaded code for the function app to use, and configured all required environment variables for the function app. Finally, you deployed the function app! 

The final step in creating the weather alert text message application is to set up Twilio to connect to the function app.
