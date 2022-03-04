Create an IoT Central application for your devices to connect to and be managed from.

You want to create an IoT Central application to test integration with your fleet management application.

In this unit, you'll use an Azure CLI control plane operation to create an IoT Central application from the **Custom application** template. You'll then use the IoT Central REST API for the data plane operations that operate on your application.

To make the REST API calls, this module uses the `az rest` command in a sandbox environment so that you don't need to install any tools on your local machine. For each command you can see the request URL, the method (`get`, `put`, `patch`, or `delete`), and any JSON body. Some commands use the `--query` argument to format the response for readability. If you prefer, you can use your own GUI-based tool such as [Postman](https://www.postman.com/) to make the API calls.

The IoT Central REST API currently has some generally available (GA) operations, and some that are in preview. If the request includes the query string `api-version=1.0`, it's a GA operation. If the request includes the query string `api-version=preview`, the operation is in preview.

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
      --display-name 'Fleet management'
    ```

    Expect this command to take a minute or two to run.

1. Run the following command to see a list of the IoT Central applications in your subscription:

    ```azurecli
    az iot central app list -o table \
    --query "[].{DisplayName:displayName, Subdomain:subdomain}"
    ```

1. Run the following command to sign in to your subscription. You don't usually run this command in the Cloud Shell, but here it's necessary to generate a bearer token for your IoT Central application. Follow the instructions to complete the login process:

    ```azurecli
    TENANT=`az account show --query homeTenantId -o tsv`
    az login --tenant $TENANT
    ```

1. Run the following commands to get the IDs of the built-in **App Administrator** and **App Operator** roles from your application. You don't yet have an API token to use, so the `--resource https://apps.azureiotcentral.com` parameter generates an authorization header with a bearer token:

    ```azurecli
    # Get the admin and operator roles in the application
    ADMIN_ROLE_ID=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/roles \
    --url-parameters api-version=1.0 \
    --resource https://apps.azureiotcentral.com \
    --query "value[?displayName=='Administrator'].id" -o tsv`
    echo $ADMIN_ROLE_ID

    OPERATOR_ROLE_ID=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/roles \
    --url-parameters api-version=1.0 \
    --resource https://apps.azureiotcentral.com \
    --query "value[?displayName=='Operator'].id" -o tsv`
    echo $OPERATOR_ROLE_ID
    ```

1. Generate an API token for the **App Administrator** role. You still need to use the bearer token for this:

    ```azurecli
    ADMIN_TOKEN=`az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/apiTokens/admintoken \
      --url-parameters api-version=1.0 \
      --resource https://apps.azureiotcentral.com --query "token" -o tsv --body \
    '{
      "roles": [
        {
          "role": "'$ADMIN_ROLE_ID'"
        }
      ]
    }'`
    echo $ADMIN_TOKEN
    ```

1. Now you can use the administrator API token to create an operator API token:

    ```azurecli
    OPERATOR_TOKEN=`az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/apiTokens/operatortoken \
      --url-parameters api-version=1.0 \
      --headers Authorization="$ADMIN_TOKEN" --query "token" -o tsv --body \
    '{
      "roles": [
        {
          "role": "'$OPERATOR_ROLE_ID'"
        }
      ]
    }'`
    echo $OPERATOR_TOKEN
    ```

1. Copy the generated admin and operator API tokens and save them locally in a text file. If you lose the tokens, you'll have to delete and then recreate them. All the remaining commands in this module will use either the `ADMIN_TOKEN` or the `OPERATOR_TOKEN`.

The two API tokens you created each have the permission set associated their role. You can also use the REST API to create API tokens for any custom roles you created in your IoT Central application. The following two commands demonstrate that an administrator has access to API tokens, but an operator doesn't:

1. The following command succeeds because the **App Administrator** role lets you work with API tokens:

    ```azurecli
    az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/apiTokens \
      --url-parameters api-version=1.0 \
      --headers Authorization="$ADMIN_TOKEN"
    ```

1. The following command fails because the **App Operator** role doesn't let you work with API tokens:

    ```azurecli
    az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/apiTokens \
      --url-parameters api-version=1.0 \
      --headers Authorization="$OPERATOR_TOKEN"
    ```
