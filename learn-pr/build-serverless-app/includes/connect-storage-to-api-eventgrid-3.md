1. Navigate back to your functions app
2. Select **New Function**
3. Enter `Event` into the filter box
4. Select EventGrid trigger
5. Select **Javascript** from the **Language:** dropdown
6. Enter `imageProcessing` into the **Name:** field
7. Select **Create**
8. Once the function creates Select **Add Event Grid subscription**
9. Enter `imageProcessingGrid` in the **Name** field
10. Change the Topic Type to **Storage Accounts**
11. Select **serverlessRG** from the Use existing dropdown
12. Select your storage account from the **Instance** menu
13. Select **Create**
14. Copy the following code into the text box > **Save**

```javascript
const request = require('request');

module.exports = function (context, eventGridEvent) {
    var path = eventGridEvent.data.url.split('/').pop();
    if (eventGridEvent.data.url.indexOf("/img/") > -1) {
        var eventData = {
            id: path,
            url: eventGridEvent.data.url
        };
        processImage(context, eventData);
    }
};

function processImage(context, eventData) {
    // Replace <subscription key> string value with your valid subscription key.
    var subscriptionKey = "<subscription key>";

    // Replace or verify the region.
    var uriBase = "https://eastus.api.cognitive.microsoft.com";

    var options = {
        url: uriBase + "/vision/v1.0/describe?maxCandidates=1",
        body: '{"url": ' + '"' + eventData.url + '"}',
        headers: {
            "Content-Type": "application/json",
            "Ocp-Apim-Subscription-Key": subscriptionKey
        }
    };

    request.post(options, function (error, response, body) {
        var temp = JSON.parse(body);
        eventData.caption = temp.description.captions[0].text;
        eventData.tags = temp.description.tags;
        context.bindings.outputDocument = eventData;
        context.done();
    });
}
```

15. Select the **Integrate** sub-tab of the function
16. Select **New Output**
17. Locate **Azure Cosmos DB** > **Select**
18. Change the **Database name** to `serverless-app`
19. Change the **Collection Name** to `images`
20. Select the checkbox to create the Azure Cosmos DB database and collection
21. **Save**