To manage data export definitions, you use the IoT Central REST API.

You want to enable your existing store management application to manage data export definitions in your IoT Central application programmatically.

In this unit, you create an Azure Storage blob container to use as an export destination. Then you use the IoT Central REST API to set a create a data export definition that sends device telemetry to the blob container for later analysis. Telemetry from the devices you set up previously is sent to the blob container. You view the telemetry data by downloading and viewing the blob container contents.

## Prepare the storage container

Before you can configure the data export from IoT Central, you must set up the Azure Storage account and blob container that'll store the exported telemetry. You need a connection string and container name when you set up the data export in IoT Central.

Run the following commands to create storage account and container, and retrieve the connection string:

TODO: verify SKU to use, resource group and whether account name must be unique
TODO: capture connection-string in a variable to use in the next step

```azurecli
STORAGE_ACCOUNT=storemanagement
az storage account create --name $STORAGE_ACCOUNT --resource-group test-central-api-learn --location centralus --sku Standard_LRS
az storage container create --name dataexport --account-name $STORAGE_ACCOUNT
az storage account show-connection-string --name $STORAGE_ACCOUNT -o table
```

## Create a data export definition

Run the following command to create a data export for telemetry, devices, and device templates to the blob container:

```azurecli
az rest -m post -u https://$APP_SUBDOMAIN.azureiotcentral.com/api/preview/continuousDataExports \
--headers Authorization="$API_TOKEN" --body \
\"{ \
    \"@type\": \"ContinuousDataExport\", \
    \"displayName\": \"Export telemetry\", \
    \"endpoint\": { \
        \"@type\": \"StorageEndpoint\", \
        \"connectionString\": \"$STORAGE_CONNECTION_STRING\", \
        \"name\": \"dataexport\" \
    }, \
    \"enabled\": true \
}"
```

## View the data

You may need to wait a few minutes for the data export to get started in your IoT Central application before you can see any data.

Run the following commands to list the blobs in the container:

```azurecli
az storage blob list --container-name=dataexport \
--connection-string "$STORAGE_CONNECTION_STRING" \
--query '[].{BlobName:name}' -o table
```

You see a blob that contains the device template definitions in the application and a sequence of blobs that contain telemetry. If you re-run the previous command, you see the number of telemetry blobs has increased.

Run the following commands to download a telemetry blob and view its contents:

```azurecli
az storage blob download --container-name telemetryexport --connection-string "$STORAGE_CONNECTION_STRING" --name 1987a4ee-150b-4b45-86ba-fb1e345cf023/telemetry/2019/09/30/14/20/00.json --file telemetry.json
cat telemetry.json
```
