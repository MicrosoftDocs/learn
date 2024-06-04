In this unit, you use the Jobs API to import a sample scenario graph complete with models, twins, and relationships. The Import Jobs API uses a file placed in Azure Blob Storage to import all of these entities into your Azure Digital Twins instance at once. You then use Models and Digitaltwins APIs to verify the graph that was imported.

Follow the steps in this unit to explore and import the sample scenario graph into your Azure Digital Twins instance.

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

## Make the import request

In this section, you send an Import Jobs API request to import the sample file of models, twins, and relationships.

Start by reviewing the [Jobs API documentation](/rest/api/digital-twins/dataplane/jobs). The API contains operations for managing long-running jobs, including add, cancel, delete, get by ID, and list for import jobs. In this section, you use **ImportJobs Add** to create an import request, and **ImportJobs GetById** to check the job's status.

:::image type="content" source="../media/3-jobs.png" alt-text="Reference doc screenshot showing the Jobs operations." border="true" lightbox="../media/3-jobs.png":::

Return to your Postman window.

From your Postman collections, expand the folder path _Data plane > jobs > imports > {id}_, and open **PUT Import Jobs Add**. You'll fill in this request template to create a new import job.

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31*. Set the **id** value to *importdistributiongrid* to assign an ID value to the job you're creating.

  :::image type="content" source="../media/3-import-jobs-variables.png" alt-text="Postman screenshot showing the variables for the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-variables.png":::

* In the **Body** tab, replace any contents with the following section of code. Replace the placeholder below with the URL of your Azure storage container created during the previous step. This information tells the request where to look for the file containing import details, and designates a location for any logs/outputted information.

  ```json
  {
    "inputBlobUri": "<container-URL>/distributionGridBulkImport.json",
    "outputBlobUri": "<container-URL>/output.json"
  }
  ```

Send the request.

[!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

The response from a successful request looks something like this:

:::image type="content" source="../media/3-import-jobs-add.png" alt-text="Postman screenshot showing the results of the Import Jobs Add request." border="true" lightbox="../media/3-import-jobs-add.png":::

This result indicates that the job was created. It has probably started running in the minutes since the response was sent, so check the current status of the job by opening the **GET Import Jobs Get By Id** request template from the collection (also found in the _Data plane > jobs > imports > {id}_ folder).

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31* and the **id** value to *importdistributiongrid*.

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/3-import-jobs-get-by-id.png" alt-text="Postman screenshot showing the results of the Import Jobs Get By ID request." border="true" lightbox="../media/3-import-jobs-get-by-id.png":::

The value of `succeeded` in the output indicates that the import job was successful.

## Verify imported elements

To check that your Azure Digital Twins graph now contains models, twins, and relationships, this section uses the data plane APIs for **Models** and **Digitaltwins**.

>[!TIP]
>For a full description of the requests and fields used in this section, see the [Models reference documentation](/rest/api/digital-twins/dataplane/models) and [Twins reference documentation](/rest/api/digital-twins/dataplane/twins). For more practice using the Models and Digitaltwins APIs, see the next unit in this module.

### Verify models

First, use one of the model APIs to see a list of all the models in your Azure Digital Twins instance.

From your Postman collections, open the request template at _Data plane > models > **GET Digital Twin Models List**_.

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31*. Uncheck the **dependenciesFor** options.
* In the **Headers** tab, uncheck the **max-items-per-page**, **traceparent**, and **tracestate** options.

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/3-digital-twin-models-list.png" alt-text="Postman screenshot showing the results of the Digital Twin Models List request." border="true" lightbox="../media/3-digital-twin-models-list.png":::

The reply body lists all of the models that are present in your Azure Digital Twins instance. Review the results to see that the models from the import file (including consumers, substations, plants, and more) are represented.

### Verify twins

Next, use the digital twins APIs to see the details of one of the twins that was imported, a power line named *pl_distribute*.

>[!TIP]
>To search for multiple digital twins at once, use the Query API, which is explored in [Unit 5](../5-query-graph.yml) of this module.

From your Postman collections, open the request template at _Data plane > digitaltwins > {id} > **GET Digital Twins Get By Id**_.

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31* and the **id** value to *pl_distribute*.
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/3-digital-twins-get-by-id.png" alt-text="Postman screenshot showing the results of the Digital Twins Get By ID request." border="true" lightbox="../media/3-digital-twins-get-by-id.png":::

The reply body gives details of the *pl_distribute* digital twin. This twin is a power line with two properties indicating `Capacity` and `GridType`.

### Verify relationships

In this section, you use the relationships APIs to see the all of the relationships coming from the *pl_distribute* twin.

From your Postman collections, open the request template at _Data plane > digitaltwins > {id} > relationships > **GET Digital Twins List Relationships**_.

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31* and the **id** value to *pl_distribute*. Uncheck the **relationshipName** parameter to avoid specifying any one type of relationship, so you can see them all.
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/3-digital-twins-list-relationships.png" alt-text="Postman screenshot showing the results of the Digital Twins List Relationships request." border="true" lightbox="../media/3-digital-twins-list-relationships.png":::

The reply body lists all the relationships, both incoming and outgoing, of the *pl_distribute* digital twin. Review the results to see what kind of relationships this power line twin has in the graph.

### Further exploration

From here, you can experiment with different API requests for viewing additional models, twins, or relationships in your graph. You may also want to view an interactive, visual version of the graph that you've created in this unit.

[!INCLUDE [Instructions to view an Azure Digital Twins graph in Azure Digital Twins Explorer](../../includes/view-azure-digital-twins-graph.md)]
