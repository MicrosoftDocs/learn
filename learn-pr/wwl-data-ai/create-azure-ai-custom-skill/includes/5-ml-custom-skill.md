Using a machine learning custom skill works the same as adding any other custom skill to a search index.

Here, you'll see how using the `AmlSkill` custom skill is different and explore the considerations of how to effectively use it.

## Custom Azure Machine Learning skill schema

When you enrich a search index with an Azure Machine Learning (AML) custom skill, the enrichment happens at the document level. The skillset used by your document indexer needs to include an `AmlSkill`. The schema for this skill is:

```json
{
      "@odata.type": "#Microsoft.Skills.Custom.AmlSkill",
      "name": "AML name",
      "description": "AML description",
      "context": "/document",
      "uri": "https://[Your AML endpoint]",
      "key": "Your AML endpoint key",
      "resourceId": null,
      "region": null,
      "timeout": "PT30S",
      "degreeOfParallelism": 1,
      "inputs": [
        {
          "name": "field name in the AML model",
          "source": "field from the document in the index"
        },
        {
          "name": "field name in the AML model",
          "source": "field from the document in the index"
        },

      ],
      "outputs": [
        {
          "name": "result field from the AML model",
          "targetName": "result field in the document"
        }
      ]
    }
```

> [!IMPORTANT]
> The URI has to use an HTTPS endpoint. This can either be a managed custom URL address provided by Microsoft or your own domain name and certificate.

Take note that the custom skill doesn't include settings for `batchSize` as the AML model will process a single document at a time. The remaining settings that control the performance of the skill are `timeout` and `degreeOfParallelism`. The above schema has set 30 seconds as the timeout value. The degree of parallelism should start at one. Depending on your infrastructure, you might be able to increase this number.

The best way to manage the efficiency of an AML skill is to scale up the Kubernetes inference cluster appropriately to manage your workload.

The index for the document needs a field to store the results from the AML model. You'll then add an output field mapping to store the results from the custom skill set to the field on the document in the index.

The JSON to do this output field mapping is:

```json
"outputFieldMappings": [
    {
      "sourceFieldName": "/result field in the document",
      "targetFieldName": "result field from the AML model"
    }
  ]
```

You create your Azure Machine Learning model using developer tools like the Python SDK, REST APIs, or Azure CLI. Another option is to take advantage of the Azure AI Machine Learning studio, a graphical user interface that lets you create, train, and deploy models without writing any code.

:::image type="content" source="../media/steps-enrich-search-index.png" alt-text="Diagram showing the steps to enrich a search index with an Azure AI Machine Learning Studio model." border="false":::

With a model created, you alter how the scoring code calls the model to allow it to be used by your custom search skill.

The last steps are to create a Kubernetes cluster to host an endpoint for your model.

### Create an AML workspace

When you create the AML workspace, Azure will also create storage accounts, a key store, and application insights resources. The AML workspace Overview pane gives you a link to launch the Azure AI Machine Learning Studio.

### Create and train a model in Azure Machine Learning studio

Azure AI Machine Learning Studio  lets you use a designer to use drag and drop to create pipelines that create and train models. There's an even easier way to create models by using prebuilt templates.

:::image type="content" source="../media/prebuilt-components-list.png" alt-text="Screenshot of all the prebuilt components in the Azure AI Machine Learning Studio." lightbox="../media/prebuilt-components-list.png":::

However you choose to create your models, they need to be registered in Azure AI Machine Learning Studio so that you can deploy the model to a web service.

### Alter how the model works to allow it to be called by the AML custom skill

The models you train will normally use many examples of the data. The datasets will have many rows and be split and used to train and test the model. The code that handles this data and passes it to the model needs to be changed to handle single rows.

The JSON response from the model should also contain only the output prediction.

For example, if your data is an array of JSON objects:

```json
[ 
    {
        "attribute-1": null,
        "attribute-2": null
    },
    {
        "attribute-1": null,
        "attribute-2": null
    },
    {
        "attribute-1": null,
        "attribute-2": null
    }
]
```

The python scoring code will have to process the data a row at a time:

```python
data = json.loads(data)
for row in data:
    for key, val in row.items():
        input_entry[key].append(decode_nan(val))
```

To change the input dataset to a single record:

```json
{
    "attribute-1": null,
    "attribute-2": null
}
```

The python code will need to change to:

```python
data = json.loads(data)
for key, val in data.items():
    input_entry[key].append(decode_nan(val))
```

For the response from the scoring code, the default code returns the whole JSON document:

```python
return json.dumps({"result": result.data_frame.values.tolist()})
```

The custom skill needs to be able to map a single response from the model. So the code should return JSON that is only the last attribute.

```python
output = result.data_frame.values.tolist()
# return the last column of the the first row of the dataframe
return {
    "predicted_outcome": output[0][-1]
}
```

### Create an endpoint for your model to use

The model is deployed to an endpoint. Azure AI Machine Learning Studio supports deploying a model to a real-time endpoint, a batch endpoint, or a web service. At the moment, the custom `AmlSkill` skill in Azure AI Search only supports web service endpoints.

The other restriction is that the endpoint has to be an Azure Kubernetes Service (AKS) cluster. Container instances aren't supported.

If you have experience in creating and managing AKS clusters, you can manually create the clusters in the Azure portal and reference them when you create your endpoint. However, an easier option is to let Azure AI Machine Learning Studio create and manage the cluster for you.

If you navigate to the compute section of the studio, you can create inference clusters. AML studio will then guide you through choosing the size of the cluster and even enable HTTPS and create a domain name for you. It will be in the format of `location.cloudapp.azure.com:443`.

### Connect the AML custom skill to the endpoint

With everything above in place, you need to update your Azure AI Search service. The steps to do so are similar to examples shown in this module, so we won't detail the specifics here but will list out the steps to follow.

1. First, to enrich your search index you'll add a new field to your index to include the output for the model.
1. Then you'll update your index skillset and add the `#Microsoft.Skills.Custom.AmlSkill` custom skill.
1. Next, you'll change your indexer to map the output from the custom skill to the field you created on the index.
1. The last step is to rerun your indexer to enrich your index with the AML model.
