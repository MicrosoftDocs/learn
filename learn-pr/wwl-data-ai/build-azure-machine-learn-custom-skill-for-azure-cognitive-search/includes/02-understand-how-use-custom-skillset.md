
Using a machine learning custom skill works the same as adding any other custom skill to a search index.

Here, you'll see how using the `AmlSkill` custom skill is different and explore the considerations of how to effectively use it.

### Custom Azure Machine Learning skill schema

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

Take note that the custom skill doesn't include settings for `batchSize`. As the AML model will process a single document at a time. The remaining settings that control the performance of the skill are `timeout` and `degreeOfParallelism`. The above schema has set 30 seconds as the timeout value. The degree of parallelism should start at one. Depending on your infrastructure, you might be able to increase this number. 

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

