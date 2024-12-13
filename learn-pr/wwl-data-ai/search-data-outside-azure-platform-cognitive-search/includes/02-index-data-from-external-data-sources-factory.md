Adding external data that doesn't reside in Azure is a common need in an organization's search solution. Azure AI Search is flexible as it allows many ways to create and push data into indexes.

## Push data into a search index using Azure Data Factory (ADF)

A first approach is a zero-code option for pushing data into an index using ADF. ADF comes with connections to nearly 100 different data stores. With connectors like HTTP and REST that allow you to connect an unlimited number of data stores. These data stores are used as a source or a target (called sinks in the copy activity) in pipelines.

The Azure AI Search index connector can be used as a sink in a copy activity.

### Create an ADF pipeline to push data into a search index

The steps you need to take to use and ADF pipeline to push data into a search index are:

1. Create an Azure AI Search index with all the fields you want to store data in.
1. Create a pipeline with a copy data step.
1. Create a data source connection to where your data resides.
1. Create a sink to connect to your search index.
1. Map the fields from your source data to your search index.
1. Run the pipeline to push the data into the index.

For example, imagine you've customer data in JSON format that is hosted externally. You want to copy these customers into a search index. The JSON is in this format:

```json
{
  "_id": "5fed1b38309495de1bc4f653",
  "firstName": "Sims",
  "lastName": "Arnold",
  "isAlive": false,
  "age": 35,
  "address": {
    "streetAddress": "Sumner Place",
    "city": "Canoochee",
    "state": "Palau",
    "postalCode": 1558
  },
  "phoneNumbers": [
    {
      "type": "home",
      "number": "+1 (830) 465-2965"
    },
    {
      "type": "home",
      "number": "+1 (889) 439-3632"
    }
  ]
}
```

#### Create a search index

Create an Azure AI Search service and an index to store this information in. If you've completed the [Create an Azure AI Search solution](/training/modules/create-azure-cognitive-search-solution/) module, then you've seen how to do this. Follow the steps to create the search service but stop at the point of importing data. As pushing data into an index doesn't need you to create an indexer or skillset.

Create an index and add these fields and properties:

:::image type="content" source="../media/search-index-fields.png" alt-text="A screenshot of the search index field definitions." lightbox="../media/search-index-fields.png":::

At the moment you have to create the index first, as ADF can't create indexes.

#### Create a pipeline using the ADF Copy Data tool

Open the [Azure Data Factory Studio](https://adf.azure.com/) and select your Azure subscription and data factory name. 

:::image type="content" source="../media/create-ingestion-pipeline.png" alt-text="A screenshot of Azure Data Factory and selecting ingest." lightbox="../media/create-ingestion-pipeline.png":::

1. Select **Ingest**.
1. Select **Next**.

    > [!NOTE]
    > You can choose to schedule the pipeline if your data is changing and you need to keep your index up-to-date. For this example, you'll import the data once.

#### Create the source linked service

1. In **Source type**, select **HTTP**.
1. Next to **Connection**, select **+ New connection**.

    :::image type="content" source="../media/create-http-linked-service-new-small.png" alt-text="A screenshot showing creating an HTTP linked service." lightbox="../media/create-http-linked-service-new.png":::

1. In the **New connection** pane, in **Name** enter **dataLocation**.
1. In the **Base URL**, enter where your JSON file resides, in this example enter **https://raw.githubusercontent.com/Azure-Samples/azure-sql-db-import-data/main/json/user1.json**.
1. In **Authentication type**, select **Anonymous**.
1. Select **Create**.
1. Select **Next**.

    :::image type="content" source="../media/copy-data-configuration.png" alt-text="A screenshot of the configuration page of the lined service." lightbox="../media/copy-data-configuration.png":::

1. In **File format**, select **JSON**.
1. Select **Next**.

#### Create the target linked service

1. In **Destination type**, select **Azure Search**. Then select **+ New connection**.

    :::image type="content" source="../media/create-search-linked-service-small.png" alt-text="A screenshot showing creating a linked service to AI Search." lightbox="../media/create-search-linked-service.png":::

1. In the **New connection** pane, in **Name** enter **search_index**.
1. In **Azure subscription**, select your Azure subscription.
1. In **Service name**, select your Azure AI Search service.
1. Select **Create**.
1. On the **Destination data store** pane, in **Target**, select the search index you created.

#### Map source fields to target fields

1. Select **Next**.

    :::image type="content" source="../media/update-schema-mapping-new-small.png" alt-text="A screenshot of the schema mapping pane." lightbox="../media/update-schema-mapping-new.png":::

1. If you created an index with field names that match the JSON attributes ADF will automatically map the JSON to the field in your search index.
1. In the above example, three fields in the JSON document need mapping to fields in the index.
1. Map your fields, then select **Next**.
1. On the **Settings** pane, in **Task name**, enter **jsonToSearchIndex**.
1. Select **Next**.

#### Run the pipeline to push the data into the index

1. On the **Summary** pane, select **Next**.

    :::image type="content" source="../media/deployment-complete.png" alt-text="A screenshot showing the pipeline deployment complete." lightbox="../media/deployment-complete.png":::

1. Once the pipeline has been validated and deployed, select **Finish**.

The pipeline has been deployed and run. The JSON document will have been added to your search index. You can use the Azure portal and run a search in the search explorer. You should see the imported JSON data.

:::image type="content" source="../media/view-search-index-results.png" alt-text="A screenshot of the JSON data in the search index." lightbox="../media/view-search-index-results.png":::

Following these steps you've seen how you can push data into an index. The pipeline you've created by default merges updates into the index. If you amended the JSON data and rerun the pipeline, the search index would be updated. You can change the write behavior to upload only if you want the data to be replaced each time you run your pipeline. 

### Limitations of using the built-in Azure AI Search as a linked service

At the moment, the Azure AI Search linked service as a sink only supports these fields:

|Azure AI Search data type  |
|---------|
|String     |
|Int32     |
|Int64     |
|Double     |
|Boolean     |
|DataTimeOffset     |

This means ComplexTypes and arrays aren't currently supported. Looking at the JSON document above this means that it isn't possible to map all the phone numbers for the customer. Only the first telephone number has been mapped.
