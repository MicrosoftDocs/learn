## Using the API 

To extract form data using a custom model, use the **analyze document** function of either a supported SDK, or the REST API, while supplying model ID (generated during model training). This function starts the form analysis. which you can then request the result to get the analysis.

Example code to call your model:

**C#**

```csharp
string endpoint = "<endpoint>";
string apiKey = "<apiKey>";
AzureKeyCredential credential = new AzureKeyCredential(apiKey);
DocumentAnalysisClient client = new DocumentAnalysisClient(new Uri(endpoint), credential);

string modelId = "<modelId>";
Uri fileUri = new Uri("<fileUri>");

AnalyzeDocumentOperation operation = await client.AnalyzeDocumentFromUriAsync(WaitUntil.Completed, modelId, fileUri);
AnalyzeResult result = operation.Value;
```

**Python**

```python
endpoint = "YOUR_DOC_INTELLIGENCE_ENDPOINT"
key = "YOUR_DOC_INTELLIGENCE_KEY"

model_id = "YOUR_CUSTOM_BUILT_MODEL_ID"
formUrl = "YOUR_DOCUMENT"

document_analysis_client = DocumentAnalysisClient(
    endpoint=endpoint, credential=AzureKeyCredential(key)
)

# Make sure your document's type is included in the list of document types the custom model can analyze
task = document_analysis_client.begin_analyze_document_from_url(model_id, formUrl)
result = task.result()
```

A successful JSON response contains **analyzeResult** that contains the content extracted and an array of pages containing information about the document content.

Example **analyze document** JSON response:

```json
{
	"status": "succeeded",
	"createdDateTime": "2023-10-18T23:39:50Z",
	"lastUpdatedDateTime": "2023-10-18T23:39:54Z",
	"analyzeResult": {
		"apiVersion": "2022-08-31",
		"modelId": "DocIntelModel",
		"stringIndexType": "utf16CodeUnit",
		"content": "Purchase Order\nHero Limited\nCompany Phone: 555-348-6512 Website: www.herolimited.com Email: accounts@herolimited.com\nPurchase Order\nDated As: 12/20/2020 Purchase Order #: 948284\nShipped To Vendor Name: Balozi Khamisi Company Name: Higgly Wiggly Books Address: 938 NE Burner Road Boulder City, CO 92848 Phone: 938-294-2949\nShipped From Name: Kidane Tsehaye Company Name: Jupiter Book Supply Address: 383 N Kinnick Road Seattle, WA 38383\nPhone: 932-299-0292\nDetails\nQuantity\nUnit Price\nTotal\nBindings\n20\n1.00\n20.00\nCovers Small\n20\n1.00\n20.00\nFeather Bookmark\n20\n5.00\n100.00\nCopper Swirl Marker\n20\n5.00\n100.00\nSUBTOTAL\n$140.00\nTAX\n$4.00\nTOTAL\n$144.00\nKidane Tsehaye\nManager\nKidane Tsehaye\nAdditional Notes: Do not Jostle Box. Unpack carefully. Enjoy. Jupiter Book Supply will refund you 50% per book if returned within 60 days of reading and offer you 25% off you next total purchase.",
		"pages": [
			{
				"pageNumber": 1,
				"angle": 0,
				"width": 1159,
				"height": 1486,
				"unit": "pixel",
				"words": [
					{
						"content": "Purchase",
						"polygon": [
							89,
							90,
							174,
							91,
							174,
							112,
							88,
							112
						],
						"confidence": 0.996,
						"span": {
							"offset": 0,
							"length": 8
						}
					},
					{
						"content": "Order",
						"polygon": [
							178,
							91,
							237,
							91,
							236,
							113,
							178,
							112
						],
						"confidence": 0.997,
						"span": {
							"offset": 9,
							"length": 5
						}
					},
                    ...
```

Explore the documentation for [supported language quickstarts](/azure/ai-services/document-intelligence/quickstarts/get-started-sdks-rest-api?azure-portal=true).

## Understanding confidence scores 

If the confidence values of the **analyzeResult** are low, try to improve the quality of your input documents.

You want to make sure that the form you're analyzing has a similar appearance to forms in the training set if the confidence values are low. If the form appearance varies, consider training more than one model, with each model focused on one form format.

Depending on the use case, you might find that a confidence score of 80% or higher is acceptable for a low-risk application. For more sensitive cases, like reading medical records or billing statements, a score of 100% is recommended.
