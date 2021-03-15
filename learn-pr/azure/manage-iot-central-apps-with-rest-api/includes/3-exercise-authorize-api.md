Create an IoT Central application for your devices to connect to and be managed from.

You want to create an IoT Central application to test integration with your fleet management application.

In this unit, you'll use an Azure CLI control plane operation to create an IoT Central application from the **Custom application** template. This application template enables the preview REST API. You'll run the CLI commands in the Azure sandbox activated for this module and then navigate to the application's web UI. In the web UI, you complete the setup by generating an API token to authorize REST API calls.

## Create and configure the IoT Central application

The following steps create an IoT Central application and generate an API token to use later in this module.

1. Run the following commands in the Cloud Shell to generate a unique name for your IoT Central application and save it in an environment variable to use later:

    ```azurecli
    APP_NAME="fleet-manager-$RANDOM"
    echo "Your application name is: $APP_NAME"

    ```

    Make a note of the application name just in case the shell times out and loses the environment variable.

1. Run the following command in the Cloud Shell to create an IoT Central application in the sandbox:

    ```azurecli
    az iot central app create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name $APP_NAME --sku ST2 --location centralus \
      --subdomain $APP_NAME --template iotc-pnp-preview \
      --display-name 'fleet management'
    echo "You can now navigate to: https://$APP_NAME.azureiotcentral.com/admin/tokens"

    ```

    Expect this command to take a minute or two to run.

1. Run the following command to generate a bearer token that gives you the same level of access that your Azure Active Directory user has in the IoT Central application. In this case, because you created the IoT Central application, this bearer token gives you administrative rights:

    ```azurecli
    BEARER_TOKEN=`az account get-access-token --resource https://apps.azureiotcentral.com --query accessToken -o tsv`
    echo $BEARER_TOKEN
    ```

1. Now you have a bearer token, you can use it with the REST API to generate API tokens for administrators and operators:

    ```azurecli
    # Get the admin and operator roles in the application
    ADMIN_ROLE_ID=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/roles \
      --headers Authorization="$BEARER_TOKEN" \
      --query "value[?displayName=='Administrator'].id" -o tsv`
    echo $ADMIN_ROLE_ID

    OPERATOR_ROLE_ID=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/roles \
      --headers Authorization="$BEARER_TOKEN" \
      --query "value[?displayName=='Operator'].id" -o tsv`
    echo $OPERATOR_ROLE_ID

    # Use the bearer token and role IDs to create API tokens:

    ADMIN_TOKEN=`az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/apiTokens/admintoken \
      --headers Authorization="$BEARER_TOKEN" \
      --query "token" -o tsv --body \
    '{
    "roles": [
        {
        "role": "'$ADMIN_ROLE_ID'"
        }
    ]
    }'`
    echo $ADMIN_TOKEN

    # Use the admin token you just generated to create an operator token
    OPERATOR_TOKEN=`az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/apiTokens/operatortoken \
      --headers Authorization="$ADMIN_TOKEN" \
      --query "token" -o tsv --body \
    '{
    "roles": [
        {
        "role": "'$OPERATOR_ROLE_ID'"
        }
    ]
    }'`
    echo $OPERATOR_TOKEN
    ```

    You can use the REST API to create API tokens for any custom roles you created in your IoT Central application.

1. Copy the generated API tokens and save them locally in a text file. If you lose the tokens, you'll have to delete and then recreate them.

1. The following command succeeds because the **App Administrator** role lets you work with API tokens:

    ```azurecli
    az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/apiTokens \
      --headers Authorization="$ADMIN_TOKEN"
    ```

1. The following command fails because the **App Operator** role lets you work with API tokens:

    ```azurecli
    az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/apiTokens \
      --headers Authorization="$OPERATOR_TOKEN"
    ```

<!--
1. In another browser tab or window, navigate to URL shown in the output of the last command. This page in the web UI is where you generate API tokens:

    ![The API Tokens page in the IoT Central UI with no tokens shown](../media/3-tokens.png)

1. Select **Create an API token**. Enter `admin` as the **Token name** and make sure **Administrator** is selected as the **Role**. Then select **Generate**:

    ![Generate an API token with the Application Administrator role in the IoT Central UI](../media/3-generate-token.png)

1. Copy the generated API token and save it locally in a text file. If you lose the token, you'll have to regenerate it:

    ![Copy a generated API token from the IoT Central UI](../media/3-copy-token.png)

1. Replace the `ADD YOUR TOKEN HERE` in the following command and run it the Cloud Shell. This command saves the API token in an environment variable to use later in the module. Be sure to enclose the token in double quotation marks, `"..."`:

    ```azurecli
    API_TOKEN="ADD YOUR TOKEN HERE"

    ```
-->
