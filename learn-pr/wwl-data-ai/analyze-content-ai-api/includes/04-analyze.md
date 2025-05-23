To analyze the contents of a file, you can use the Azure AI Content Understanding REST API to submit it to the endpoint using a `POST` request. You can specify the content as a URL (for a file hosted in an Internet-accessible location) or as the binary contents of the file (for example, a .pdf document, a .png image, an .mp3 audio file, or an .mp4 video file). The request header must include the API key, and the endpoint address for the **analyze** request includes the analyzer to be used.

As with the request to create an analyzer, the **analyze** request starts an asynchronous operation. The `POST` request returns a unique operation ID, which you can then use in a `GET` request to check the status of the  analysis operation.

For example, suppose you want to use the business card analyzer discussed previously to extract the name and email address from the following scanned business card image:

![Photograph of a business card for John Smith.](../media/business-card.png)

The following Python code submits a request for analysis, and then polls the service until the operation is complete and the results are returned.

```python
import json
import requests

# Read the image data
with open("business-card.png", "rb") as file:
        image_data = file.read()
    
## Use a POST request to submit the image data to the analyzer
analyzer_name = "business_card_analyser"

headers = {
        "Ocp-Apim-Subscription-Key": "<YOUR_API_KEY>",
        "Content-Type": "application/octet-stream"}

url = f"{<YOUR_ENDPOINT>}/contentunderstanding/analyzers/{analyzer_name}:analyze?api-version=2024-12-01-preview"

response = requests.post(url, headers=headers, data=image_data)

# Get the response and extract the ID assigned to the analysis operation
response_json = response.json()
id_value = response_json.get("id")

# Use a GET request to check the status of the analysis operation
result_url = f"{<YOUR_ENDPOINT>}/contentunderstanding/analyzers/{analyzer_name}/results/{id_value}?api-version=2024-12-01-preview"

result_response = requests.get(result_url, headers=headers)

# Keep polling until the analysis is complete
status = result_response.json().get("status")
while status == "Running":
        result_response = requests.get(result_url, headers=headers)
        status = result_response.json().get("status")

# Get the analysis results
if status == "Succeeded":
    result_json = result_response.json()


```

## Processing analysis results

The results in the response JSON depend on:

- The kind of content the analyzer is designed to analyze (for example, document, video, image, or audio).
- The schema for the analyzer.
- The contents of the file that was analyzed.

For example, the response from the *document*-based business card analyzer when analyzing the business card described previously contain:

- The extracted fields
- The optical character recognition (OCR) layout of the document, including locations of lines of text, individual words, and paragraphs on each page.

Here's the complete JSON response for the business card analysis:

```json
{
    "id": "00000000-0000-0000-0000-a00000000000",
    "status": "Succeeded",
    "result": {
        "analyzerId": "biz_card_analyser_2",
        "apiVersion": "2024-12-01-preview",
        "createdAt": "2025-05-16T03:51:46Z",
        "warnings": [],
        "contents": [
            {
                "markdown": "John Smith\nEmail: john@contoso.com\n",
                "fields": {
                    "ContactName": {
                        "type": "string",
                        "valueString": "John Smith",
                        "spans": [
                            {
                                "offset": 0,
                                "length": 10
                            }
                        ],
                        "confidence": 0.994,
                        "source": "D(1,69,234,333,234,333,283,69,283)"
                    },
                    "EmailAddress": {
                        "type": "string",
                        "valueString": "john@contoso.com",
                        "spans": [
                            {
                                "offset": 18,
                                "length": 16
                            }
                        ],
                        "confidence": 0.998,
                        "source": "D(1,179,309,458,309,458,341,179,341)"
                    }
                },
                "kind": "document",
                "startPageNumber": 1,
                "endPageNumber": 1,
                "unit": "pixel",
                "pages": [
                    {
                        "pageNumber": 1,
                        "angle": 0.03410444,
                        "width": 1000,
                        "height": 620,
                        "spans": [
                            {
                                "offset": 0,
                                "length": 35
                            }
                        ],
                        "words": [
                            {
                                "content": "John",
                                "span": {
                                    "offset": 0,
                                    "length": 4
                                },
                                "confidence": 0.992,
                                "source": "D(1,69,234,181,234,180,283,69,283)"
                            },
                            {
                                "content": "Smith",
                                "span": {
                                    "offset": 5,
                                    "length": 5
                                },
                                "confidence": 0.998,
                                "source": "D(1,200,234,333,234,333,282,200,283)"
                            },
                            {
                                "content": "Email:",
                                "span": {
                                    "offset": 11,
                                    "length": 6
                                },
                                "confidence": 0.995,
                                "source": "D(1,75,310,165,309,165,340,75,340)"
                            },
                            {
                                "content": "john@contoso.com",
                                "span": {
                                    "offset": 18,
                                    "length": 16
                                },
                                "confidence": 0.977,
                                "source": "D(1,179,309,458,311,458,340,179,341)"
                            }
                        ],
                        "lines": [
                            {
                                "content": "John Smith",
                                "source": "D(1,69,234,333,233,333,282,69,282)",
                                "span": {
                                    "offset": 0,
                                    "length": 10
                                }
                            },
                            {
                                "content": "Email: john@contoso.com",
                                "source": "D(1,75,309,458,309,458,340,75,340)",
                                "span": {
                                    "offset": 11,
                                    "length": 23
                                }
                            }
                        ]
                    }
                ],
                "paragraphs": [
                    {
                        "content": "John Smith Email: john@contoso.com",
                        "source": "D(1,69,233,458,233,458,340,69,340)",
                        "span": {
                            "offset": 0,
                            "length": 34
                        }
                    }
                ],
                "sections": [
                    {
                        "span": {
                            "offset": 0,
                            "length": 34
                        },
                        "elements": [
                            "/paragraphs/0"
                        ]
                    }
                ]
            }
        ]
    }
}
```

Your application must typically parse the JSON to retrieve field values. For example, the following python code extracts all of the *string* values:

```python
# (continued from previous code example)

# Iterate through the fields and extract the names and type-specific values
contents = result_json["result"]["contents"]
for content in contents:
    if "fields" in content:
        fields = content["fields"]
        for field_name, field_data in fields.items():
            if field_data['type'] == "string":
                print(f"{field_name}: {field_data['valueString']}")

```

The output from this code is shown here:

```
ContactName: John Smith
EmailAddress: john@contoso.com
```
