You must create an IoT Central application for your devices to connect to and be managed from.

You want to create an IoT Central application to test integration with your store management application.

In this unit, you use the Azure CLI to create an IoT Central application from the **Preview application** template. This application template enables the the preview REST API. You run the CLI commands in the Azure sandbox activated for this module and then navigate to the application's web UI to complete the setup by adding a device template.

## Install the Azure IoT CLI extension

The **azure-cli-iot-ext** CLI extension provides commands to manage IoT resources such as IoT Central applications. Run the following command in the Cloud Shell to install the extension:

```azurecli
az extension add --name azure-cli-iot-ext
```

## Create and configure the IoT Central application

The following steps create an IoT Central application and import a device template to use later in this module. In this module you use the **MxChip IoT DevKit** as your test device.

TODO: check on default resource group, add notes about using a unique subdomain, maybe add it to the shell environment to use later?

1. Run the following command in the Cloud Shell to create an IoT Central application in the sandbox:

    TODO: Be smarter about saving variables - append to .bashrc? :)

    ```azurecli
    APP_SUBDOMAIN=
    az iotcentral app create --resource-group test-central-api-learn --name store-manager --sku S1 --location centralus --subdomain $APP_SUBDOMAIN --template iotc-pnp-preview@1.0.0 --display-name 'Store Management'
    ```

1. In another browser tab or window, navigate to https://YOUR_APP_SUBDOMAIN.azureiotcentral.com/admin/tokens. This is the page in the web UI where you generate API tokens:

    TODO: Add screenshot here.

1. Select **+ Generate Token**. Add **admin** as the **Token name** and select **Application Administrator** as the **Role**:

    TODO: add a screenshot here

1. Select **Generate**. Copy the generated token and save it locally in a text file. If you lose the token, you'll have to regenerate it.

1. Run the following commands in the Cloud Shell to list the IoT Central applications you have access to. The command adds an **Authorization** header with your API token to the **GET** request:

    TODO: Be smarter about saving variables - append to .bashrc? :)

    ```azurecli
    API_TOKEN=
    az rest -m get -u https://$APP_SUBDOMAIN.azureiotcentral.com/api/preview/applications --headers Authorization="$API_TOKEN"
    ```

    The output from the previous command shows the IoT Central applications you have access to in the sandbox environment. In the sandbox environment, you only have access to the IoT Central application you just created.
