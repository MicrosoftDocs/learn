In this unit, you use the Jobs API to import a sample scenario graph complete with models, twins, and relationships. The Import Jobs API uses a file placed in Azure Blob Storage to import all of these entities into your Azure Digital Twins instance at once. You then use Models and Digitaltwins APIs to verify the graph that was imported.

Follow the steps in this unit to explore the sample scenario graph and import it into your Azure Digital Twins instance.

## Understand sample scenario and import file

The sample scenario of this unit represents a city energy grid, including different types of plants and consumers, power lines, receivers, and substations.

These entities are connected by relationships indicating ownership and feed of power between them. The sample scenario has the following digital twin graph:

:::image type="content" source="../media/3-sample-graph.png" alt-text="Azure Digital Twins Explorer screenshot showing the sample scenario, including a list of models and a graph of twins connected by relationships." border="true" lightbox="../media/3-sample-graph.png":::

Each model, twin, and relationship in the sample graph is stored in JSON format in the import file for this module. You'll pass this file through the Import Jobs API to import all of these elements into your own Azure Digital Twins instance.

Open the sample file in GitHub here: [distributionGridBulkImport.json](https://github.com/Azure-Samples/azure-digital-twins-getting-started/blob/main/models/energy-grid-example/distributionGridBulkImport.json). Notice that the code in the file is split into three sections: `Models`, `Twins`, and `Relationships`. Each line within a section represents a different model, twin, or relationship to be imported.

:::image type="content" source="../media/3-import-file.png" alt-text="GitHub screenshot showing the body of the import file." border="true" lightbox="../media/3-import-file.png":::

When you're done reviewing the contents of the import file, download the sample file from GitHub to use later in this unit.

## Set up import resources and permissions

For this unit, you'll be using the same Azure Digital Twins instance that you created in the previous unit. If you still have the same console window open, the name of this instance is stored in a variable `$INSTANCE_NAME`. Also, your subscription is stored in `$AZURE_SUBSCRIPTION`, your resource group is stored in `$RESOURCE_GROUP`, and your Azure user ID is stored in a variable `$AZURE_USER`. All of these variables are used in commands in this unit.

Navigate back to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

Set two console variables to use for your new storage resource names, replacing placeholders with your own values:

```azurecli
STORAGE_ACCOUNT=<Enter a name to use for your Azure storage account>
CONTAINER=<Enter a name to use for your storage container>
```

Next, run the following command to assign a system-assigned identity to the Azure Digital Twins instance, and store its ID value to a `$PRINCIPALID` console variable. This value is needed to give Azure Digital Twins permission to access the import file from Azure Blob Storage.

```azurecli
az dt create --dt-name $INSTANCE_NAME --resource-group $RESOURCE_GROUP --mi-system-assigned --location $REGION
PRINCIPALID=$(az dt identity show -n $INSTANCE_NAME -g $RESOURCE_GROUP --query "principalId" --output tsv)
```

Next, create an Azure storage account and blob container, and assign access permission for both your user account and your Azure Digital Twins instance. These Azure storage resources are necessary to store the import file used by the Import Jobs API.

```azurecli
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $REGION --sku Standard_ZRS --encryption-services blob
az storage container create --account-name $STORAGE_ACCOUNT --name $CONTAINER --auth-mode login

az role assignment create --role "Storage Blob Data Contributor" --assignee $AZURE_USER --scope "/subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"
az role assignment create --role "Storage Blob Data Contributor" --assignee $PRINCIPALID --scope "/subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"
```

Run this command to get the URL of your new storage container. Save this value, because you'll use it later when you run the Import Jobs API command from Postman.

```azurecli
echo "https://$STORAGE_ACCOUNT.blob.core.windows.net/$CONTAINER"
```

Finally, upload the sample file you downloaded [at the start of this unit](#understand-sample-scenario-and-import-file) to your Cloud Shell. Using the **Manage files** button in the bar across the top of the Cloud Shell, upload *distributionGridBulkImport.json* to your Cloud Shell storage.

Now that the sample file is accessible from the Cloud Shell, you can run the following CLI command to upload the sample file to your Azure storage container.

```azurecli
az storage blob upload --account-name $STORAGE_ACCOUNT --container-name $CONTAINER --name distributionGridBulkImport.json --file distributionGridBulkImport.json --auth-mode login
```

Now you have the import file available in an Azure storage account that your Azure Digital Twins instance can access. In the next section, you'll send an API request that uses this file to create the entities it defines in your Azure Digital Twins instance.

## Send an import request

In this section, you send an Import Jobs API request to import the sample file of models, twins, and relationships.

### View Jobs API documentation

Start by reviewing the [Jobs API documentation](/rest/api/digital-twins/dataplane/jobs). The API contains operations for managing long-running jobs, including add, cancel, delete, get by ID, and list for import jobs. In this section, you use **ImportJobs Add** to create an import request, and **ImportJobs GetById** to check the job's status.

### Make the request

Build the import request by following these steps.

1. Open the API documentation page for [ImportJobs Add](/rest/api/digital-twins/dataplane/jobs/import-jobs-add), and copy the HTTP request.

    :::image type="content" source="../media/3-import-jobs-add-copy.png" alt-text="Reference doc screenshot showing the Import Jobs Add operations." border="true" lightbox="../media/3-import-jobs-add-copy.png":::

1. Return to your Visual Studio project you started in the previous unit, and open *data.http*.

1. Paste the PUT request in a new line below the variables.

    :::image type="content" source="../media/3-import-jobs-add-request.png" alt-text="Visual Studio screenshot showing the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-request.png":::

1. Edit the parameters in the request.
    * Replace `digitaltwins-hostname` with `{{hostName}}`. This will use the value of the `hostName` variable you created in the previous unit.
    * Replace `{id}` with `importdistributiongrid`. This will assign an ID value to the job you're creating.
    * Replace `2023-10-31` with `{{DPversion}}` to use the value of the `DPversion` variable you created in the previous unit. (If the values are the same, this is optional. Using the variable will allow you to easily make changes to all requests in this file at once if the version changes in the future.)

    :::image type="content" source="../media/3-import-jobs-add-parameters.png" alt-text="Visual Studio screenshot showing the parameters for the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-parameters.png":::

1. On a new line underneath the request, add the following line (exactly as written) to specify authentication with your bearer token variable.
    ```http
    Authorization: Bearer {{DPtoken}}
    ```

    :::image type="content" source="../media/3-import-jobs-add-authorization.png" alt-text="Visual Studio screenshot showing the authorization for the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-authorization.png":::

1. Skip a line, and add the following section of JSON as the body of the request. Replace the placeholder in the code snippet with the URL of your Azure storage container created during the previous step. This information tells the request where to look for the file containing import details, and designates a location for any logs or outputted information.

    ```json
    {
        "inputBlobUri": "<your-container-URL>/distributionGridBulkImport.json",
        "outputBlobUri": "<your-container-URL>/output.json"
    }
    ```

    :::image type="content" source="../media/3-import-jobs-add-body.png" alt-text="Visual Studio screenshot showing the body for the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-body.png":::

1. Select **Send request** above the request to send it.

    :::image type="content" source="../media/3-import-jobs-add-send.png" alt-text="Visual Studio screenshot of sending the request for the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-send.png":::

Visual Studio brings up a pane with the details of the response. The response from a successful request looks something like this:

:::image type="content" source="../media/3-import-jobs-add-response.png" alt-text="Visual Studio screenshot showing the results of the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add-response.png":::

[!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

This result indicates that the job was created. It has probably started running in the minutes since the response was sent, so check the current status of the job with an [ImportJobs GetById](/rest/api/digital-twins/dataplane/jobs/import-jobs-get-by-id) request.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

    :::image type="content" source="../media/3-import-jobs-delimiter.png" alt-text="Visual Studio screenshot showing a new delimiter between requests." border="true" lightbox="../media/3-import-jobs-delimiter.png":::

1. Paste the following GET request on the next line. This is the [ImportJobs GetById](/rest/api/digital-twins/dataplane/jobs/import-jobs-get-by-id) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and the ID value of the job. It also has the authorization line specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/jobs/imports/importdistributiongrid?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```
    :::image type="content" source="../media/3-import-jobs-get-request.png" alt-text="Visual Studio screenshot showing the Import Jobs Get By Id request." border="true" lightbox="../media/3-import-jobs-get-request.png":::

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/3-import-jobs-get-response.png" alt-text="Visual Studio screenshot showing the results of the Import Jobs Get By Id request." border="true" lightbox="../media/3-import-jobs-get-response.png":::

    The value of `succeeded` in the output indicates that the import job was successful.

## Verify imported elements

To check that your Azure Digital Twins graph now contains models, twins, and relationships, this section uses the data plane APIs for **Models** and **Digitaltwins**.

>[!TIP]
>For a full description of the requests and fields used in this section, see the [Models reference documentation](/rest/api/digital-twins/dataplane/models) and [Twins reference documentation](/rest/api/digital-twins/dataplane/twins). For more practice using the Models and Digitaltwins APIs, see the next unit in this module.

### Verify models

First, use the [DigitalTwinModels List](/rest/api/digital-twins/dataplane/models/digital-twin-models-list) API to see a list of all the models in your Azure Digital Twins instance.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwinModels List](/rest/api/digital-twins/dataplane/models/digital-twin-models-list) request copied from the reference documentation, with parameters filled in for the host name and data plane version. It also has the authorization line specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/models?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/3-models-list-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twin Models List request." border="true" lightbox="../media/3-models-list-response.png":::
    
    The reply body lists all of the models that are present in your Azure Digital Twins instance. Review the results to see that the models from the import file (including consumers, substations, plants, and more) are represented.

### Verify twins

Next, use the [DigitalTwins GetById](/rest/api/digital-twins/dataplane/twins/digital-twins-get-by-id) API to see the details of one of the twins that was imported, a power line named *pl_distribute*.

>[!TIP]
>To search for multiple digital twins at once, use the Query API, which is explored in [Unit 5](../5-query-graph.yml) of this module.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwins GetById](/rest/api/digital-twins/dataplane/twins/digital-twins-get-by-id) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and ID of the *pl_distribute* twin. It also has the authorization line specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/digitaltwins/pl_distribute?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/3-twins-get-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins Get By ID request." border="true" lightbox="../media/3-twins-get-response.png":::

    The reply body gives details of the *pl_distribute* digital twin. This twin is a power line with two properties indicating `Capacity` and `GridType`.

### Verify relationships

In this section, you use the [DigitalTwins ListRelationships](/rest/api/digital-twins/dataplane/twins/digital-twins-list-relationships) API to see the all of the relationships coming from the *pl_distribute* twin.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwins ListRelationships](/rest/api/digital-twins/dataplane/twins/digital-twins-list-relationships) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and ID of the *pl_distribute* twin. It also has the authorization line specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/digitaltwins/pl_distribute/relationships?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/3-twins-list-relationships-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins List Relationships request." border="true" lightbox="../media/3-twins-list-relationships-response.png":::

    The reply body lists all the relationships, both incoming and outgoing, of the *pl_distribute* digital twin. Review the results to see what kind of relationships this power line twin has in the graph.

## Further exploration

From here, you can experiment with different API requests for viewing additional models, twins, or relationships in your graph. You may also want to view an interactive, visual version of the graph that you've created in this unit.

[!INCLUDE [Instructions to view an Azure Digital Twins graph in Azure Digital Twins Explorer](../../includes/view-azure-digital-twins-graph.md)]
