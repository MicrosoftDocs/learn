In most scenarios, you should consider creating and testing analyzers using the visual interface in the Azure AI Foundry portal. However, in some cases you might want to create an analyzer by submitting a JSON definition of the schema for your desired content fields to the REST API.

## Defining a schema for an analyzer

Analyzers are based on schemas that define the fields you want to extract or generate from a content file. At its simplest, a schema is a set of fields, which can be specified in a JSON document, as shown in this example of an analyzer definition:

```json
{
    "description": "Simple business card",
    "baseAnalyzerId": "prebuilt-documentAnalyzer",
    "config": {
        "returnDetails": true
    },
    "fieldSchema": {
        "fields": {
            "ContactName": {
                "type": "string",
                "method": "extract",
                "description": "Name on business card"
            },
            "EmailAddress": {
                "type": "string",
                "method": "extract",
                "description": "Email address on business card"
            }
        }
    }
}
```

This example of a custom analyzer schema is based on the pre-built *document* analyzer, and describes two fields that you would expect to find on a business card: *ContactName* and *EmailAddress*. Both fields are defined as string data types, and are expected to be *extracted* from a document (in other words, the string values are expected to exist in the document so they can be "read"; rather than being fields that can be *generated* by inferring information about the document).

> [!NOTE]
> This example is deliberately simple, with the minimal information needed to create a working analyzer. In reality, the schema would likely include more fields of different types, and the analyzer definition would include more configuration settings. The JSON might even include a sample document. See the [Azure AI Content Understanding REST API documentation](/rest/api/contentunderstanding/content-analyzers/create-or-replace) for more details.

## Using the REST API to create an analyzer

With your analyzer definition in place, you can use the REST API to submit it to Azure AI Content Understanding to be created. The JSON data is submitted as a `PUT` request to the endpoint with the API key in the request header to start the analyzer creation operation. 

The response from the `PUT` request includes a **Operation-Location** in the header, which provides a *callback* URL that you can use to check on the status of the request by submitting a `GET` request.

You can use any HTTP-capable client tool or language to submit the request. For example, the following Python code submits a request to create an analyzer based on the contents of a file named *card.json* (which is assumed to contain the JSON definition described previously)

```python
import json
import requests

# Get the buisness card schema
with open("card.json", "r") as file:
    schema_json = json.load(file)

# Use a PUT request to submit the schema for a new analyzer
analyzer_name = "business_card_analyser"

headers = {
    "Ocp-Apim-Subscription-Key": "<YOUR_API_KEY>",
    "Content-Type": "application/json"}

url = f"{<YOUR_ENDPOINT>}/contentunderstanding/analyzers/{analyzer_name}?api-version=2025-05-01-preview"

response = requests.put(url, headers=headers, data=json.dumps(schema_json))

# Get the response and extract the ID assigned to the operation
callback_url = response.headers["Operation-Location"]

# Use a GET request to check the status of the operation
result_response = requests.get(callback_url, headers=headers)

# Keep polling until the operation is complete
status = result_response.json().get("status")
while status == "Running":
    result_response = requests.get(callback_url, headers=headers)
    status = result_response.json().get("status")

print("Done!")
```
