To integrate Azure AI Document Intelligence into the Cognitive Search indexing process, you must write a Web service that integrates the custom skill interface.

In your polling company, you've decided to implement a custom skill that sends completed polling forms to Azure AI Document Intelligence to extract the voter ID and other values. You want to store these values in your index to ensure that users can search by voter ID and find the polling forms they need.

In this unit, you'll learn how to create and host a custom skill that calls Azure AI Document Intelligence.

> [!NOTE] 
> The instructions in this unit assume that you've already deployed Azure AI Document Intelligence and trained any custom model you want it to use.

## Custom skill interface and requirements

A custom Web API skill has to integrate with other skills in your skillset and with the rest of the Cognitive Search indexing pipeline. Therefore it must accept input data and return output data in compatible formats. When you write a custom skill, including one that integrates Azure AI Document Intelligence, one of your primary concerns is to implement the custom skill interface to ensure this compatibility.

Your code should handle the following input values in the JSON body of the REST request:

- `values`. The JSON body will include a collection named `values`. Each item in this collection represents a form to analyze.
  - `recordId`. Each item in the `values` collection has a `recordId`. You must include this ID in the output JSON so that Cognitive Search can match input forms with their results.
  - `data`. Each item in the `values` includes a `data` collection with two values:
    - `formUrl`. This is the location of the form to analyze.
    - `formSasToken`. If the form is stored in Azure Storage, this token enables your code to authenticate with that account.

From the input data, your code can formulate requests to send to Azure AI Document Intelligence. You'll need the following connection information for these requests:

- The Azure AI Document Intelligence endpoint.
- The Azure AI Document Intelligence API key.

You can obtain both these values from the Azure AI Document Intelligence resource in the Azure portal.

Your code should formulate a REST response that includes a JSON body. The Cognitive Search service expects this response to include:

- `values`. A collection in which each item is one of the submitted forms.
  - `recordId`. Cognitive Search uses this value to match results to one of the input forms.
  - `data`. Use the `data` collection to return the fields that Azure AI Document Intelligence has extracted from each input form.
  - `errors`. If you couldn't obtain the analysis for a form, use the `errors` collection to indicate why.
  - `warnings`, If you have obtained results but some non-critical problem has arisen, use the `warnings` collection to report the issue.

## Testing the custom skill

During development, you'll need to test your custom skill by sending it REST requests and observing its responses. REST developers often use the **Postman** tool to help with this process, but any tool that helps you to formulate and submit REST requests with JSON message bodies can be used. You can also use the **Code + Test** tool in the Azure portal to formulate and submit test REST requests.

In Visual Studio, deploy the function locally by pressing **F5**. Then, you can submit requests to the function by sending them to this URL:

```http
POST https://localhost:7071/api/analyze-form
```

The request specifies a form to analyze by its URL included in the JSON body:

```json
{
    "values": [
        {
            "recordId": "record1",
            "data": { 
                "formUrl": "<your-form-url>",
                "formSasToken": "<your-sas-token>"
            }
        }
    ]
}
```

If your form is stored in an Azure Storage Account, you can use the `formSasToken` property to authenticate with that storage account. To obtain the correct SAS token, open Azure Storage Explorer, browse to the form, then right-click it and select **Get Shared Access Signature**.

The response to such a request should look like this:

```json
{
    "values": [
        {
            "recordId": "record1",
            "data": {
                "address": "1111 8th st. Bellevue, WA 99501 ",
                "recipient": "Southridge Video 1060 Main St. Atlanta, GA 65024"
            },
            "errors": null,
            "warnings": null
        }
    ]
}
```

The keys and values returned in the `data` object, depend on the model you've calling in Azure AI Document Intelligence.

## Hosting a custom skill

The custom skill is a Web API service and so you have many choices on how to host it. For example, if you want to host the skill within Azure, for example, you could host the skill as:

- An Azure Function.
- A container in the Azure Container Instance Service (ACI).
- A container in Azure Kubernetes Services (AKS).

## Add the custom skill to a skillset

Once the custom skill is completed, tested, and hosted, you must configure Cognitive Search to call it. In the previous unit, you saw sample definition JSON code for built-in skills. The equivalent definition code for a custom skill is:

```json
{
  "@odata.type": "#Microsoft.Skills.Custom.WebApiSkill",
  "description": "A custom skill that calls Azure AI Document Intelligence",
  "uri": "https://contoso.com/formrecognizer",
  "batchSize": 1,
  "context": "/document",
  "inputs": [
    {
      "name": "formUrl",
      "source": "/document/metadata_storage_path"
    }
  ],
  "outputs":[ 
    { 
      "name":"address",
      "targetName":"address"
    },
    { 
      "name":"recipient",
      "targetName":"recipient"
    }
  ]
}
```

In this code:

- `Microsoft.Skills.Custom.WebApiSkill` is required to define this as a Web API skill.
- `uri` is the location of the web service. In this module, the web service is implemented as an Azure Function. The Function is the interface between the search pipeline and Azure AI Document Intelligence.
- `inputs` determines the data that is sent to the skill for analysis.
- `outputs` determines the data that is returned from the skill.

## Learn more

- [Add a custom skill to an Azure Cognitive Search enrichment pipeline](/azure/search/cognitive-search-custom-skill-interface)
- [Postman](https://www.postman.com)